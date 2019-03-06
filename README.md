QuickCoefPlot
================
Sondre U. Solstad

Easy Effect Size Plots with options in R
========================================

QuickEffectSize is an easy interface for effect size plots in R. Using the Zelig package and ggplot2, it simulates and visualizes effect sizes for any zelig model.

By default the plot shows 100 simulations for 100 values of the selected independent variable, which varies from one standard deviation above to one standard deviation below its mean.

Written by Sondre U. Solstad, Princeton University (<ssolstad@princeton.edu>). Send me an email if you find this package useful or want to suggest an improvement or feature.

Installation instructions:

``` r
library(devtools)
install_github("sondreus/QuickEffectSize")
```

Example:
--------

``` r
library(QuickEffectSize)
library(Zelig)

dat <- data.frame(y = rnorm(100), x1 = rnorm(100), x2 = rnorm(100))
dat$x3 <- dat$y + rnorm(100)
qes(zelig(y ~ x1 + x2 + x3, data = dat, model = "normal"), iv.var = "x3", xlab = "Using qes", ylab = "Productivity", progress = FALSE)
```

How to cite this model in Zelig: R Core Team. 2008. normal: Normal Regression for Continuous Dependent Variables in Christine Choirat, Christopher Gandrud, James Honaker, Kosuke Imai, Gary King, and Olivia Lau, "Zelig: Everyone's Statistical Software," <http://zeligproject.org/>

1.00 % - Package: QuickEffectSize - IV: x3 2.00 % - Package: QuickEffectSize - IV: x3 3.00 % - Package: QuickEffectSize - IV: x3 4.00 % - Package: QuickEffectSize - IV: x3 5.00 % - Package: QuickEffectSize - IV: x3 6.00 % - Package: QuickEffectSize - IV: x3 7.00 % - Package: QuickEffectSize - IV: x3 8.00 % - Package: QuickEffectSize - IV: x3 9.00 % - Package: QuickEffectSize - IV: x3 10.00 % - Package: QuickEffectSize - IV: x3 11.00 % - Package: QuickEffectSize - IV: x3 12.00 % - Package: QuickEffectSize - IV: x3 13.00 % - Package: QuickEffectSize - IV: x3 14.00 % - Package: QuickEffectSize - IV: x3 15.00 % - Package: QuickEffectSize - IV: x3 16.00 % - Package: QuickEffectSize - IV: x3 17.00 % - Package: QuickEffectSize - IV: x3 18.00 % - Package: QuickEffectSize - IV: x3 19.00 % - Package: QuickEffectSize - IV: x3 20.00 % - Package: QuickEffectSize - IV: x3 21.00 % - Package: QuickEffectSize - IV: x3 22.00 % - Package: QuickEffectSize - IV: x3 23.00 % - Package: QuickEffectSize - IV: x3 24.00 % - Package: QuickEffectSize - IV: x3 25.00 % - Package: QuickEffectSize - IV: x3 26.00 % - Package: QuickEffectSize - IV: x3 27.00 % - Package: QuickEffectSize - IV: x3 28.00 % - Package: QuickEffectSize - IV: x3 29.00 % - Package: QuickEffectSize - IV: x3 30.00 % - Package: QuickEffectSize - IV: x3 31.00 % - Package: QuickEffectSize - IV: x3 32.00 % - Package: QuickEffectSize - IV: x3 33.00 % - Package: QuickEffectSize - IV: x3 34.00 % - Package: QuickEffectSize - IV: x3 35.00 % - Package: QuickEffectSize - IV: x3 36.00 % - Package: QuickEffectSize - IV: x3 37.00 % - Package: QuickEffectSize - IV: x3 38.00 % - Package: QuickEffectSize - IV: x3 39.00 % - Package: QuickEffectSize - IV: x3 40.00 % - Package: QuickEffectSize - IV: x3 41.00 % - Package: QuickEffectSize - IV: x3 42.00 % - Package: QuickEffectSize - IV: x3 43.00 % - Package: QuickEffectSize - IV: x3 44.00 % - Package: QuickEffectSize - IV: x3 45.00 % - Package: QuickEffectSize - IV: x3 46.00 % - Package: QuickEffectSize - IV: x3 47.00 % - Package: QuickEffectSize - IV: x3 48.00 % - Package: QuickEffectSize - IV: x3 49.00 % - Package: QuickEffectSize - IV: x3 50.00 % - Package: QuickEffectSize - IV: x3 51.00 % - Package: QuickEffectSize - IV: x3 52.00 % - Package: QuickEffectSize - IV: x3 53.00 % - Package: QuickEffectSize - IV: x3 54.00 % - Package: QuickEffectSize - IV: x3 55.00 % - Package: QuickEffectSize - IV: x3 56.00 % - Package: QuickEffectSize - IV: x3 57.00 % - Package: QuickEffectSize - IV: x3 58.00 % - Package: QuickEffectSize - IV: x3 59.00 % - Package: QuickEffectSize - IV: x3 60.00 % - Package: QuickEffectSize - IV: x3 61.00 % - Package: QuickEffectSize - IV: x3 62.00 % - Package: QuickEffectSize - IV: x3 63.00 % - Package: QuickEffectSize - IV: x3 64.00 % - Package: QuickEffectSize - IV: x3 65.00 % - Package: QuickEffectSize - IV: x3 66.00 % - Package: QuickEffectSize - IV: x3 67.00 % - Package: QuickEffectSize - IV: x3 68.00 % - Package: QuickEffectSize - IV: x3 69.00 % - Package: QuickEffectSize - IV: x3 70.00 % - Package: QuickEffectSize - IV: x3 71.00 % - Package: QuickEffectSize - IV: x3 72.00 % - Package: QuickEffectSize - IV: x3 73.00 % - Package: QuickEffectSize - IV: x3 74.00 % - Package: QuickEffectSize - IV: x3 75.00 % - Package: QuickEffectSize - IV: x3 76.00 % - Package: QuickEffectSize - IV: x3 77.00 % - Package: QuickEffectSize - IV: x3 78.00 % - Package: QuickEffectSize - IV: x3 79.00 % - Package: QuickEffectSize - IV: x3 80.00 % - Package: QuickEffectSize - IV: x3 81.00 % - Package: QuickEffectSize - IV: x3 82.00 % - Package: QuickEffectSize - IV: x3 83.00 % - Package: QuickEffectSize - IV: x3 84.00 % - Package: QuickEffectSize - IV: x3 85.00 % - Package: QuickEffectSize - IV: x3 86.00 % - Package: QuickEffectSize - IV: x3 87.00 % - Package: QuickEffectSize - IV: x3 88.00 % - Package: QuickEffectSize - IV: x3 89.00 % - Package: QuickEffectSize - IV: x3 90.00 % - Package: QuickEffectSize - IV: x3 91.00 % - Package: QuickEffectSize - IV: x3 92.00 % - Package: QuickEffectSize - IV: x3 93.00 % - Package: QuickEffectSize - IV: x3 94.00 % - Package: QuickEffectSize - IV: x3 95.00 % - Package: QuickEffectSize - IV: x3 96.00 % - Package: QuickEffectSize - IV: x3 97.00 % - Package: QuickEffectSize - IV: x3 98.00 % - Package: QuickEffectSize - IV: x3 99.00 % - Package: QuickEffectSize - IV: x3 100 % - complete ! - Package: QuickEffectSize - IV: x3 ![](README_files/figure-markdown_github/unnamed-chunk-2-1.png)

Arguments:
----------

-   **zelig.model** - Fitted zelig model
-   **iv.var** - Independent variable. sim.n Number of simulations for each value of iv.var simulated. Defaults to 100.
-   **range.n** - Number of different values of iv.var to simulate. Defaults to 100.
-   **custom.range** - Vector of two values specifying a range within which different values of iv.var should be simulated. (Optional)
-   **return.pdata** - Should the data to construct the plot be returned instead of the plot itself? Defaults to FALSE.
-   **progress** - Should the data to construct the plot be returned instead of the plot itself? Defaults to FALSE. Should progress be reported? (defaults to TRUE)
-   **coord.ylim** - Sets limits on what part of the x.axis to display through ggplots coord\_cartesian() function. (Optional)
-   **set.covar** - Option to specify values of other predictors in simulations. (Optional)
