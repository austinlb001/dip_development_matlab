# README for the Overall Project

Students in the Georgia Institute of Technology (GA Tech) ECE 6258 class, are tasked with evaluating the performance of at least two image denoising or enhancement methods. Students will then measure the performance of the denoising or enhancement techniques using Image Quality Assessment (IQA) metrics.

A step-by-step baseline plan for completing this project has been developed and the team has chosen the datasets and denoising methods that will be used.  It has been decided that the five datasets listed in the project prompt (CURE-OR, CURE-TSR, CURE-TSD, SSID, and Set-12) will be used. Three methods for image denoising were chosen which include two “traditional” methods and one state-of-the-art neural network technique. The traditional methods that will be analyzed are the median filter and wavelet filter. The team is still researching a neural network technique to use.

Analysis techniques and processes have been decided. The required IQA metrics (PSNR, SSIM, SW-SSIM, MS-UNIQUE, CSV, and SUMMER) will be calculated for the noise-reduced images.  The team will then decide how to improve the image denoising methods to decrease the statistical deviation of challenge metrics to the ground-truth metrics.

The team gathered background information on each of the traditional methods. Traditional methods of image processing offer low-cost algorithms for denoising and enhancing images. There are many traditional methods, some of which are: gaussian filters, mean filters, median filters, and Wiener filters.  The median filter is a filter that applies a window (typically 3x3) on an image.  The window slides over the image and forms a new image by taking the median value in the window after each slide.  Median filters are appropriate for denoising and edge preservation.  The plan is to test this method by adjusting the window size.

A wavelet filter is not really a filter, it is more of a filter bank, or a collection of filters.  Wavelets involve running an image through a high-filter and a low-pass filter.  Each stage of a wavelet filter yields 2n images, where n is the index of the stage.  The number of stages is up to the engineer/designer.  After the wavelet transform is applied, a threshold is applied.  Then the inverse wavelet transform is applied to yield a denoised image.  The parameters that can be modified are the number of stages and the values of the threshold.  There is also a hard threshold or soft threshold that can be applied. 

The team’s next steps are to find a neural network technique with a pre-trained model that can be utilized for denoising, establish a GitHub repository for software development collaboration, and perform the first round of analysis using the three techniques listed in this report.

Individual’s work: Caitrin Duffy-Deno led the work on the project plan/outline, Austin Barber led the work researching recent advanced denoising techniques both researched traditional methods.
