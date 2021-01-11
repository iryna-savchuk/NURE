# Brief Description:
# This file contains some raw pieces of code on Fuzzy Clustering

# install.packages("advclust")

# Loading packages and the iris dataset
library(advclust)
library(datasets) 
data(iris)

# Taking a look at the data
head(iris) 
str(iris) 

# Splitting the data 
iris.input<-iris[,1:4] # will be used for fuzzy clustering 
iris.class<-iris[,"Species"] # actual classes
head(iris.input)
head(iris.class)

#########################################################################
# Fuzzy C-means analysis >> fuzzy.CM()
# To get more info: ?fuzzy.CM 
#########################################################################
fuzzy.CM(X=iris.input, K=3, m=2, 
         max.iteration=100, threshold=1e-5, 
         RandomNumber=1234)->cl_CM

show(cl_CM)

#########################################################################
# Gustafson-Kessel analysis >> fuzzy.GK()
# To get more info: ?fuzzy.GK
#########################################################################
fuzzy.GK(X=iris.input, K = 3, m = 2, 
         max.iteration=100, threshold=1e-5,
         RandomNumber = 1234)->cl_GK

show(cl_GK)

# Comparing with the actual results
# Fuzzy C-Means
table(cl_CM@hard.label)
table(iris.class, cl_CM@hard.label)
# Gustafson-Kessel
table(cl_GK@hard.label)
table(iris.class, cl_GK@hard.label)

# For visualization this package provide biplot and radar plot

# Biplot perform visualization with Principal Component Analysis. 
# Use scale =T when unit of variables on data are different.
biploting(cl_CM, iris.input, scale=T)->biplot_CM
biploting(cl_GK, iris.input, scale=T)->biplot_GK

# Radar Plot
# Radar plot can be used to profilling your cluster result via centroid. 
# Please take attention to axis label. 
# 0 indicates mean of variable, 
# 0.5 indicates mean plus half of standar deviation in realted variable,
# -0.5 indicates mean minus half of standar deviation in related variable, etc.
radar.plotting(cl_CM, iris.input)->radar_CM
radar.plotting(cl_GK, iris.input)->radar_GK

# One more method to perform fuzzy clustering + Consensus Fuzzy Clustering 
# can be found at:
# https://cran.r-project.org/web/packages/advclust/vignettes/advclust.html

# Validation
# The best cluster result can be decided with minimum value of index, except MPC and PC use maximum value.
validation.index(cl_CM)
validation.index(cl_GK)

# One more way to visualize the results
library(cluster)
clusplot(x=iris.input, clus=cl_CM@hard.label, color=T, shade=T, labels=0, lines=0)
clusplot(x=iris.input, clus=cl_GK@hard.label, color=T, shade=T, labels=0, lines=0)
