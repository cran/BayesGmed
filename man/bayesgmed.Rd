% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bayesgmed.R
\name{bayesgmed}
\alias{bayesgmed}
\title{Estimate a causal mediation effects}
\usage{
bayesgmed(
  outcome,
  mediator,
  treat,
  covariates = NULL,
  dist.y = "continuous",
  dist.m = "continuous",
  link.y = "identity",
  link.m = "identity",
  data,
  priors = NULL,
  ...
)
}
\arguments{
\item{outcome}{a character string indicating the name of the outcome variable.}

\item{mediator}{a character string indicating the name of the mediator variable.}

\item{treat}{a character string indicating the name of the treatment variable. The treatment variable is considered binary and should be coded as 0 for control and 1 for treated.}

\item{covariates}{a character vector indicating the name of the confounding variables.}

\item{dist.y}{a character string indicating the family distribution of the outcome.  E.g., dist.y = "bernoulli" will fit
a logistic regression for the outcome.}

\item{dist.m}{a character string indicating the family distribution of the mediator, E.g., dist.m = "bernoulli" will fit
a logistic regression model for the mediator}

\item{link.y}{a character string indicating the link function to be used for the outcome model.}

\item{link.m}{a character string indicating the link function to be used for the mediator model.}

\item{data}{A \code{data.frame} or a \code{tibble} object.}

\item{priors}{A list of named values for the prior scale parameters. See details.}

\item{...}{Other optional parameters passed to \code{rstan::stan()}.}
}
\value{
An object of 'S4' class 'stanfit',  with all its available methods.
}
\description{
Estimates various quantities for causal mediation analysis using 'Stan'.
}
\details{
This is the main function for estimating causal mediation effects
from several types of data within the Bayesian framework. We followed the potential
outcome framework for effects definition and the package uses the 'rstan' utility functions
for exploring the posterior distribution.
\subsection{priors}{

Users may pass a list of named values for the priors argument. The values will be used to define
the scale parameter of the respective prior distributions. This list may specify some or all of the
following parameters:
priors <- list(
scale_m = 2.5\emph{diag(P_m) scale_y = 2.5}diag(P_y),
location_m = rep(0, P_m) location_y = rep(0, P_y),
scale_sd_y = 2.5, scale_sd_m = 2.5)
where P_m is the number of regression parameters (including the intercept) in the mediator model and
P_y is the number of regression parameters in the outcome model.
}
}
\examples{
\donttest{
## Run example using the example_data
data(example_data)
fit1 <- bayesgmed(outcome = "Y", mediator =  "M", treat = "A", covariates = c("Z1", "Z2"),
 dist.y = "binary", dist.m = "binary", link.y = "logit", link.m = "logit", data = example_data)
bayesgmed_summary(fit1)

# With priors
P <- 3 # number of covariates plus the intercept term 
priors <- list(scale_m = 2.5*diag(P+1), scale_y = 2.5*diag(P+2), 
location_m = rep(0, P+1), location_y = rep(0, P+2))
fit1 <- bayesgmed(outcome = "Y", mediator =  "M", treat = "A", covariates = c("Z1", "Z2"), 
dist.y = "binary", dist.m = "binary", link.y = "logit", link.m = "logit", priors = priors,  
data = example_data)
bayesgmed_summary(fit1)
}
}
\references{
\enumerate{
\item McCandless, L.C. and J.M. Somers, \emph{Bayesian sensitivity analysis for unmeasured confounding in causal mediation analysis.} Statistical Methods in Medical Research, 2019. (28)(2): p. 515-531.
\item Comment, L., Coull, B. A., Zigler, C., and Valeri, L. (2019). Bayesian data fusion for unmeasured confounding. arXiv preprint arXiv:1902.10613.
}
}
\author{
Belay Birlie Yimer \email{belaybirlie.yimer@manchester.ac.uk}
}
