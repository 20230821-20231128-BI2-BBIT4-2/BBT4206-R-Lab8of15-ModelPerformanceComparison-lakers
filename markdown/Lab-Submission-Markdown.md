Business Intelligence Project
================
Lakers
6th November 2023

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [STEP 1. Install and Load the Required Packages
  —-](#step-1-install-and-load-the-required-packages--)
- [Load necessary libraries](#load-necessary-libraries)
- [Load the Iris dataset (this dataset is included in
  R)](#load-the-iris-dataset-this-dataset-is-included-in-r)
  - [LDA —-](#lda--)
  - [1. Table Summary —-](#1-table-summary--)
  - [2. Box and Whisker Plot —-](#2-box-and-whisker-plot--)
  - [3. Dot Plots —-](#3-dot-plots--)
  - [4. Scatter Plot Matrix —-](#4-scatter-plot-matrix--)
  - [5. Pairwise xyPlots —-](#5-pairwise-xyplots--)
  - [6. Statistical Significance Tests
    —-](#6-statistical-significance-tests--)

# Student Details

|                                                                                                                                                                                                                                   |                                                              |     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|-----|
| **Student ID Numbers and Names of Group Members** \| \| \| 1. 134780 - C - Trevor Okinda \| \| \| \| 2. 132840 - C - Sheila Wangui \| \| \| \| 3. 131749 - C - Teresia Nungari \| \| \| 4. 135203 - C - Tom Arnold \| \| \| \| \| |                                                              |     |
| **GitHub Classroom Group Name**                                                                                                                                                                                                   | Lakers                                                       |     |
| **Course Code**                                                                                                                                                                                                                   | BBT4206                                                      |     |
| **Course Name**                                                                                                                                                                                                                   | Business Intelligence II                                     |     |
| **Program**                                                                                                                                                                                                                       | Bachelor of Business Information Technology                  |     |
| **Semester Duration**                                                                                                                                                                                                             | 21<sup>st</sup> August 2023 to 28<sup>th</sup> November 2023 |     |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# STEP 1. Install and Load the Required Packages —-

\#Load the language server first

``` r
if (require("languageserver")) {
  require("languageserver")
} else {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: languageserver

``` r
## mlbench ----
if (require("mlbench")) {
  require("mlbench")
} else {
  install.packages("mlbench", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: mlbench

``` r
## caret ----
if (require("caret")) {
  require("caret")
} else {
  install.packages("caret", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: caret

    ## Loading required package: ggplot2

    ## Loading required package: lattice

``` r
## kernlab ----
if (require("kernlab")) {
  require("kernlab")
} else {
  install.packages("kernlab", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: kernlab

    ## 
    ## Attaching package: 'kernlab'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     alpha

``` r
## randomForest ----
if (require("randomForest")) {
  require("randomForest")
} else {
  install.packages("randomForest", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
```

    ## Loading required package: randomForest

    ## randomForest 4.7-1.1

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

# Load necessary libraries

library(caret) library(e1071) library(randomForest) library(kernlab)
library(rpart)

# Load the Iris dataset (this dataset is included in R)

data(iris)

\#Train the models \# Define train control train_control \<-
trainControl(method = “repeatedcv”, number = 10, repeats = 3)

### LDA —-

set.seed(7) iris_model_lda \<- train(Species ~ ., data = iris, method =
“lda”, trControl = train_control) \### CART —- set.seed(7)
iris_model_cart \<- train(Species ~ ., data = iris, method = “rpart”,
trControl = train_control) \### KNN —- set.seed(7) iris_model_knn \<-
train(Species ~ ., data = iris, method = “knn”, trControl =
train_control) \### SVM —- set.seed(7) iris_model_svm \<- train(Species
~ ., data = iris, method = “svmRadial”, trControl = train_control) \###
Random Forest —- set.seed(7) iris_model_rf \<- train(Species ~ ., data =
iris, method = “rf”, trControl = train_control) \## Call the `resamples`
Function —- results \<- resamples(list(LDA = iris_model_lda, CART =
iris_model_cart, KNN = iris_model_knn, SVM = iris_model_svm, RF =
iris_model_rf))

## 1. Table Summary —-

summary(results)

## 2. Box and Whisker Plot —-

scales \<- list(x = list(relation = “free”), y = list(relation =
“free”)) bwplot(results, scales = scales)

## 3. Dot Plots —-

dotplot(results, scales = scales)

## 4. Scatter Plot Matrix —-

splom(results)

## 5. Pairwise xyPlots —-

xyplot(results, models = c(“LDA”, “SVM”)) xyplot(results, models =
c(“SVM”, “CART”))

## 6. Statistical Significance Tests —-

diffs \<- diff(results)

summary(diffs)
