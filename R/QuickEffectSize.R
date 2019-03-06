#' QuickEffectSize (qes)
#'
#' This package visualizes effect sizes. It relies on the Zelig package
#' @param zelig.model Fitted zelig model
#' @param iv.var Independent variable. 
#' @param sim.n Number of simulations for each value of iv.var simulated. Defaults to 100. 
#' @param range.n Number of different values of iv.var to simulate. Defaults to 100. 
#' @param custom.range Vector of two values specifying a range within which different values of iv.var should be simulated. (Optional)
#' @param return.pdata Should the data to construct the plot be returned instead of the plot itself? Defaults to FALSE.
#' @param coord.ylim Sets limits on what part of the x.axis to display through ggplots coord_cartesian() function. (Optional)
#' @param set.covar Option to specify values of other predictors in simulations. (Optional) 
#' @keywords qes QuickEffectSize effect Zelig plot
#' @aliases qes
#' @export
#' @examples
#' cat_function()


QuickEffectSize <- qes <- function(zelig.model, iv.var, sim.n = 100, range.n = 100, custom.range, return.pdata = FALSE, xlab = "IV", ylab = "DV", coord.ylim, set.covar = NULL, ...){

  library(Zelig)
  library(ggplot2)
  
# Fitting model - you would naturally use your model and data here
model <- zelig.model

# If iv.var not specified, use first listed
if(missing(iv.var)){
  iv.var <- names(coef(model)[2])
}

dv.var <- model$formula[[2]]

if(missing(xlab)){
  xlab <- iv.var
}

if(missing(ylab)){
  ylab <- dv.var
}

# If specifying covariance structure further, then add ", " else leave this as empty string
if(!is.null(set.covar)){
  set.covar <- paste0(", ", set.covar)
} else {
  set.covar <- ""
}


# Set number of simulations
e <- data.frame(model$data)

# Get range of iv to plot for
range <- as.numeric(sort(e[, iv.var]))

# Setting range to smaller number of unique values (if not, the script uses all unique values)
range <- seq(mean(range)-sd(range), mean(range)+sd(range), length.out = range.n)

if(!missing(custom.range)){
  range <- seq(custom.range[1], custom.range[2], length.out = range.n)
}

pdata <- data.frame(matrix(ncol = length(range), nrow = sim.n))
colnames(pdata) <- range

index <- 0
for(i in 1:length(range)){
  
  
  # Set level of IV  
  setx.with.custom.iv <- paste0("setx(model, ", iv.var, " = ", range[i], set.covar, ")")
  model.fit <- eval(parse(text = setx.with.custom.iv))
  
  # set.seed(112358)
  # model.fit <- setx(model, size_from_year = range[i])

  # Simulate quantities of interest
  sim   <- sim(model, x = model.fit, num = sim.n)
  
  # Get and save expected values
  pdata[, i] <- unlist(sim$get_qi(qi = "ev", xvalue = "x"))
  
  index <- index + 1
  cat(paste("\r", ifelse(index == length(range), paste(100, "%  -  complete !"), paste(sprintf("%.2f", round(index/length(range), 4)*100), "%")), " -  Package: QuickEffectSize  -  IV:", iv.var))
  
}

cat("\n")

values <- c(unlist(pdata[, 1:length(range)]))

pdata <- data.frame(my.iv = sort(rep(range, sim.n)), ev = values, name = rep(iv.var, length(values)))
rownames(pdata) <- 1:nrow(pdata)

if(max(pdata$my.iv, na.rm = TRUE) > 1){
  pdata$my.iv <- pdata$my.iv / 20
}

p <- ggplot(pdata, aes(x=my.iv, y=ev))+geom_point(alpha = max(1/sim.n, 0.05), col = "skyblue")+theme_classic()+stat_smooth(col = "skyblue")+xlab(xlab)+ylab(ylab)

if(!missing(ylim)){
  p <- p+coord_cartesian(ylim = coord.ylim)
}

colnames(pdata)[1:2] <- c(iv.var, dv.var)
if(return.pdata == TRUE){
  return(pdata)
} else {
return(p)
}
}