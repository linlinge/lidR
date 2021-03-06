% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lasmergespatial.r
\name{lasmergespatial}
\alias{lasmergespatial}
\title{Merge a point cloud with a source of spatial data}
\usage{
lasmergespatial(las, source, attribute = NULL)
}
\arguments{
\item{las}{An object of class \code{LAS}}

\item{source}{An object of class \code{SpatialPolygonsDataFrame} or \code{RasterLayer} or a
\code{RasterStack} or \code{RasterBrick} with RGB colors.}

\item{attribute}{character. The name of an attribute in the table of attributes of the shapefile or
the name of a new column in the LAS object. Not relevant for RGB colorization.}
}
\value{
An object of the class \code{LAS}.
}
\description{
Merge a point cloud with a source of spatial data. It adds an attribute along each point based on
a value found in the spatial data. Sources of spatial data can be a \code{SpatialPolygonsDataFrame})
or a \code{RasterLayer}.\cr
\itemize{
\item{\code{SpatialPolygonsDataFrame}: it checks if the points belongs within each polygon. If
the parameter \code{attribute} is the name of an attribute in the table of attributes of the shapefile,
it assigns to the points the values of that attribute. Otherwise it classifies the points as boolean.
TRUE if the points are in a polygon, FALSE otherwise.}
\item{\code{RasterLayer}: it attributes to each point the value found in each pixel of the \code{RasterLayer}}.
\item{\code{RasterStack} or \code{RasterBrick} must have 3 channels for RGB colors. It colorizes the
point cloud with RGB values.}
}
}
\examples{
LASfile <- system.file("extdata", "Megaplot.laz", package="lidR")
shp     <- system.file("extdata", "lake_polygons_UTM17.shp", package = "lidR")

las   <- readLAS(LASfile)
lakes <- shapefile(shp)

# The attribute "inlake" does not exist in the shapefile.
# Points are classified as TRUE if in a polygon
las    <- lasmergespatial(las, lakes, "inlakes")     # New attribute 'inlakes' is added.
forest <- lasfilter(las, inlakes == FALSE)
plot(las)
plot(forest)

# The attribute "LAKENAME_1" exists in the shapefile.
# Points are classified with the values of the polygons
las <- lasmergespatial(las, lakes, "LAKENAME_1")     # New column 'LAKENAME_1' is added.
}
