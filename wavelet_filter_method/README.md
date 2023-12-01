# README for Wavelet Filter

This folder contains the development for the wavelet filter method.

A wavelet filter is not really a filter, it is more of a filter bank, or a collection of filters. Wavelets involve running an image through a high-filter and a low-pass filter. Each stage of a wavelet filter yields 2n images, where n is the index of the stage. The number of stages is up to the engineer/designer. After the wavelet transform is applied, a threshold is applied. Then the inverse wavelet transform is applied to yield a denoised image. The parameters that can be modified are the number of stages and the values of the threshold. There is also a hard threshold or soft threshold that can be applied.
