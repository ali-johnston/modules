#' @title Model module: LogisticRegression
#'
#' @description Model module to fit a simple logistic regression model
#'
#' @param .df \strong{Internal parameter, do not use in the workflow function}. \code{.df} is data frame that combines the occurrence data and covariate data. \code{.df} is passed automatically in workflow from the process module(s) to the model module(s) and should not be passed by the user.
#'
#' @seealso \code{\link{glm}}
#'
#' @author ZOON Developers, \email{zoonproject@@gmail.com}
#' @section Version: 1.0
#' @section Date submitted: 2015-11-13
#' @section Data type: presence/absence
#' @name LogisticRegression
#' @family model

LogisticRegression <- function(.df){
  #if (!all(df$type %in% c('presence', 'absence', 'background'))) {
  #  stop ('only for presence/absence or presence/background data')
  #}
  
  covs <- as.data.frame(.df[, 6:ncol(.df)])
  names(covs) <- names(.df)[6:ncol(.df)]
  m <- glm(.df$value ~ .,
           data = covs,
           family = 'binomial')
  
  # create a ZoonModel object and return it
  ZoonModel(model = m,
            code = {
              stats::predict.glm(model,
                                 newdata,
                                 type = 'response')
            },
            packages = 'stats')
}
