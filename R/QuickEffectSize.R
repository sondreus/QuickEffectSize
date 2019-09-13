#' QuickEffectSize (qes)
#'
#' This package visualizes effect sizes. It relies on the Zelig package.
#' @param zelig.model Fitted zelig model
#' @param iv.var Independent variable.
#' @param sim.n Number of simulations for each value of iv.var simulated. Defaults to 100.
#' @param range.n Number of different values of iv.var to simulate. Defaults to 100.
#' @param custom.range Vector of two values specifying a range within which different values of iv.var should be simulated. (Optional)
#' @param return.pdata Should the data to construct the plot be returned instead of the plot itself? Defaults to FALSE.
#' @param progress Should progress be reported? (defaults to TRUE)
#' @param coord.ylim Sets limits on what part of the x.axis to display through ggplots coord_cartesian() function. (Optional)
#' @param set.covar Option to specify values of other predictors in simulations. (Optional)
#' @param transform.x If provided a function, transforms x-values according to function before plotting. (Optional)
#' @param transform.y If provided a function, transforms y-values according to function before plotting. (Optional)
#' @param ... Passed to ggplot2's *theme()* function. (Optimal)
#' @keywords qes QuickEffectSize effect Zelig plot
#' @aliases qes
#' @export qes QuickEffectSize
#' @examples
#' dat <- data.frame(y = rnorm(100), x1 = rnorm(100), x2 = rnorm(100))
#' dat$x3 <- dat$y + rnorm(100)
#' library(Zelig)
#' qes(zelig(y ~ x1 + x2 + x3, data = dat, model = "normal"), iv.var = "x3", xlab = "Using qes", ylab = "Productivity")

QuickEffectSize <- qes <- function(zelig.model, iv.var, sim.n = 100, range.n = 100, custom.range, return.pdata = FALSE, progress = TRUE, xlab = iv.var, ylab = dv.var, coord.ylim, set.covar = NULL, transform.x, transform.y, ...){

# Load packages on which this function depends
  library(Zelig)
  library(ggplot2)

# (Legacy, could be more efficient)
model <- zelig.model

# If iv.var not specified, use first listed
if(missing(iv.var)){
  iv.var <- names(coef(model)[2])
}

dv.var <- model$formula[[2]]

## If specifying covariance structure further, then add ", " else leave this as empty string
if(!is.null(set.covar)){
  set.covar <- paste0(", ", set.covar)
} else {
  set.covar <- ""
}

## Get range of iv to plot for
# Check for custom range, if specified, generate range.n unique values within range
if(!missing(custom.range)){
  iv_range <- seq(custom.range[1], custom.range[2], length.out = range.n)
} else {
# ... else use default, equal to range.n values from one standard deviation above to one standard deviation below the mean of the iv
  iv_range <- as.numeric(sort(data.frame(model.matrix(zelig.model$formula, data = zelig.model$data))[, iv.var]))
  iv_range <- seq(mean(iv_range)-sd(iv_range), mean(iv_range)+sd(iv_range), length.out = range.n)
}

## Generate container data frame
pdata <- data.frame(my.iv = sort(rep(iv_range, sim.n)), ev = rep(NA, sim.n*range.n), name = rep(iv.var, length(sim.n*range.n)))

## Generate simulated quantitites of interest in loop with range.n steps
index <- 0
for(i in 1:length(iv_range)){

  # 1. Set level of IV
  setx.with.custom.iv <- paste0("setx(model, ", iv.var, " = ", iv_range[i], set.covar, ")")
  model.fit <- eval(parse(text = setx.with.custom.iv))

  # 2. Simulate quantity of interest for this level of IV
  sim   <- sim(model, x = model.fit, num = sim.n)

  # 3. Save result
  pdata[(1+(i-1)*sim.n):(i*sim.n), "ev"] <- unlist(sim$get_qi(qi = "ev", xvalue = "x"))



  # (If desired, report progress:)
  if(progress){
  index <- index + 1
  cat(paste("\r", ifelse(index == length(iv_range), paste(100, "%  -  complete !"), paste(sprintf("%.2f", round(index/length(iv_range), 4)*100), "%")), " -  Package: QuickEffectSize  -  IV:", iv.var))
  }

}
cat("\n")

if(!missing(transform.x)){
  pdata$my.iv <- transform.x(pdata$my.iv)
}
if(!missing(transform.y)){
  pdata$ev <- transform.y(pdata$ev)
}


# Generate plot using ggplot2
p <- ggplot(pdata, aes(x=my.iv, y=ev))+geom_point(alpha = max(1/sim.n, 0.05), col = "skyblue")+theme_classic()+stat_smooth(col = "skyblue")+xlab(xlab)+ylab(ylab)+theme(...)

# If custom coordinates to plot is set, restrict plot to these
if(!missing(coord.ylim)){
  p <- p+coord_cartesian(ylim = coord.ylim)
}

# Return either simulated data or plot of simulated data
if(return.pdata == TRUE){
  colnames(pdata)[1:2] <- c(iv.var, dv.var)
  return(pdata)
} else {
return(p)
}
}

