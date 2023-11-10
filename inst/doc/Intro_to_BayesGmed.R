## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation, eval= FALSE------------------------------------------------
#  devtools::install_gitlab(belayb/BayesGmed)

## ----setup--------------------------------------------------------------------
library(BayesGmed)

## ----data---------------------------------------------------------------------
head(example_data)

## ----prior, eval= FALSE-------------------------------------------------------
#  P <- 3 # number of covariates plus the intercept term
#  priors <- list(scale_m = 2.5*diag(P+1),
#                 scale_y = 2.5*diag(P+2),
#                 location_m = rep(0, P+1),
#                 location_y = rep(0, P+2))

## ----model--------------------------------------------------------------------
fit1 <- bayesgmed(outcome = "Y", mediator =  "M", treat = "A", covariates = c("Z1", "Z2"), dist.y = "binary",
dist.m = "binary", link.y = "logit", link.m = "logit", data = example_data)

bayesgmed_summary(fit1)

