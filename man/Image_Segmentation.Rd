% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/px_utils.R
\docType{class}
\name{Image_Segmentation}
\alias{Image_Segmentation}
\title{Segmentation of images based on Superpixels, Affinity propagation and Kmeans clustering}
\format{An object of class \code{R6ClassGenerator} of length 24.}
\usage{
# init <- Image_Segmentation$new()
}
\arguments{
\item{input_image}{a 3-dimensional input image (the range of the pixel values should be preferably in the range 0 to 255)}

\item{method}{a character string specifying the superpixel method. It can be either "slic" or "slico"}

\item{superpixel}{a numeric value specifying the number of superpixels}

\item{kmeans_method}{a character string specifying the kmeans method. If not empty ("") then it can be either "kmeans" or "mini_batch_kmeans"}

\item{AP_data}{a boolean. If TRUE then the affinity propagation image data will be computed and returned}

\item{use_median}{a boolean. If TRUE then the median will be used rather than the mean value for the inner computations}

\item{minib_kmeans_batch}{the size of the mini batches}

\item{kmeans_num_init}{number of times the algorithm will be run with different centroid seeds}

\item{kmeans_max_iters}{the maximum number of clustering iterations}

\item{minib_kmeans_init_fraction}{percentage of data to use for the initialization centroids (applies if initializer is \emph{kmeans++} or \emph{optimal_init}). Should be a float number between 0.0 and 1.0.}

\item{kmeans_initializer}{the method of initialization. One of, \emph{optimal_init}, \emph{quantile_init}, \emph{kmeans++} and \emph{random}. See details for more information}

\item{colour_type}{a character string specifying the colour type. It can be one of "RGB", "LAB" or "HSV"}

\item{compactness_factor}{a numeric value specifying the compactness parameter in case that \emph{method} is "slic"}

\item{adjust_centroids_and_return_masks}{a boolean. If TRUE and the \emph{kmeans_method} parameter is NOT empty ("") then the centroids will be adjusted and image-masks will be returned. This will allow me to plot the masks using the \emph{spixel_masks_show} method.}

\item{sim_normalize}{a boolean. If TRUE then the constructed similarity matrix will be normalised to have unit p-norm (see the armadillo documentation for more details)}

\item{sim_wL}{a numeric value specifying the weight for the \emph{"L"} channel of the image (see the details section for more information)}

\item{sim_wA}{a numeric value specifying the weight for the \emph{"A"} channel of the image (see the details section for more information)}

\item{sim_wB}{a numeric value specifying the weight for the \emph{"B"} channel of the image (see the details section for more information)}

\item{sim_color_radius}{a numeric value specifying the \emph{colorradius} (see the details section for more information)}

\item{delay_display_seconds}{a numeric value specifying the seconds to delay the display of the next image (It displays the images consecutively). This parameter applies only if the \emph{display_all} is set to FALSE (spixel_masks_show method)}

\item{display_all}{a boolean. If TRUE then all images will be displayed in a grid  (spixel_masks_show method)}

\item{margin_btw_plots}{a float number specifying the margins between the plots if the \emph{display_all} parameter is set to TRUE  (spixel_masks_show method)}

\item{verbose}{a boolean. If TRUE then information will be printed in the console  (spixel_masks_show method)}
}
\description{
Segmentation of images based on Superpixels, Affinity propagation and Kmeans clustering
}
\details{
\emph{sim_wL}, \emph{sim_wA}, \emph{sim_wB} are the weights of the three channels. They keep balance so as to be consistent with human perception.

The quantity \emph{colorradius} adjusts the number of clusters, and if its value is low, the number of targets would increase, which leads to more detailed segmentation results.

If the \emph{adjust_centroids_and_return_masks} parameter is set to FALSE then the output \emph{kmeans_image_data} will be an RGB image, otherwise it will be a black-and-white image.

\emph{colour_type} parameter: RGB (Red-Green-Blue), LAB (Lightness, A-colour-dimension, B-colour-dimension) or HSV (Hue, Saturation, Value) colour.

Higher resolution images give better results.

The \emph{affinity propagation} algorithm is used here with default parameter values.

By setting the \emph{sim_normalize} parameter to TRUE, the affinity propagation algorithm requires less iterations to complete. However, the \emph{colorradius} parameter does not have an
effect if the similarity matrix is normalized.


---------------kmeans initializers----------------------

\strong{optimal_init}   : this initializer adds rows of the data incrementally, while checking that they do not already exist in the centroid-matrix

\strong{quantile_init}  : initialization of centroids by using the cummulative distance between observations and by removing potential duplicates

\strong{kmeans++}       : kmeans++ initialization. Reference : http://theory.stanford.edu/~sergei/papers/kMeansPP-soda.pdf AND http://stackoverflow.com/questions/5466323/how-exactly-does-k-means-work

\strong{random}         : random selection of data rows as initial centroids
}
\section{Methods}{


\describe{
 \item{\code{Image_Segmentation$new()}}{}

 \item{\code{--------------}}{}

 \item{\code{spixel_segmentation()}}{}

 \item{\code{--------------}}{}

 \item{\code{spixel_masks_show()}}{}

 \item{\code{--------------}}{}
 }
}

\examples{

library(SuperpixelImageSegmentation)

path = system.file("images", "BSR_bsds500_image.jpg", package = "SuperpixelImageSegmentation")

im = OpenImageR::readImage(path)

init = Image_Segmentation$new()

spx = init$spixel_segmentation(input_image = im, superpixel = 600, AP_data = TRUE,
                               use_median = TRUE, sim_color_radius = 10)

# plt_im = init$spixel_masks_show(display_all = TRUE)

}
\references{
https://pdfs.semanticscholar.org/6533/654973054b742e725fd433265700c07b48a2.pdf , "Image Segmentation using SLIC Superpixels and Affinity Propagation Clustering", Bao Zhou, 2013, International Journal of Science and Research (IJSR)
}
\keyword{datasets}
