# Deep Non-Blind Deconvolution via Generalized Low-Rank Approximation

In this paper, we present a deep convolutional neural network to capture the inherent properties of image degradation, which can handle different kernels and saturated
pixels in a unified framework. The proposed neural network is motivated by the low-rank property of pseudo-inverse kernels. We first compute a generalized lowrank approximation for a large number of blur kernels, and then use separable
filters to initialize the convolutional parameters in the network. Our analysis shows that the estimated decomposed matrices contain the most essential information of
the input kernel, which ensures the proposed network to handle various blurs in a unified framework and generate high-quality deblurring results. Experimental
results on benchmark datasets with noise and saturated pixels demonstrate that the proposed algorithm performs favorably against state-of-the-art methods.


# Setup
Please refer [Caffe](https://github.com/BVLC/caffe) for installation details.  
Basically, you need to first modify the [MATLAB_DIR](https://github.com/BVLC/caffe/issues/4510) in Makefile.config and then run the demo_test.m for a successful compilation:


# Scripts and pre-trained models
The pre-trained model can be found in models/snapshot.      
Users can use demo_test to generate the results of any images.  
