clc;clear;close all;
%% DEMO script for DL (SGK) based denoising
%
% Key reference:
% Chen, Y., 2017, Fast dictionary learning for noise attenuation of multidimensional seismic data, Geophysical Journal International, 209, 21-31.
% Chen, Y., W. Huang, D. Zhang, and W. Chen, 2016, An open-source Matlab code package for improved rank-reduction 3D seismic data denoising and reconstruction, Computers & Geosciences, 95, 59-66.
% 
% More References:
% Chen, Y., S. Fomel, 2015, Random noise attenuation using local signal-and-noise orthogonalization, Geophysics, 80, WD1-WD9.
% Chen, Y., J. Ma, and S. Fomel, 2016, Double-sparsity dictionary for seismic noise attenuation, Geophysics, 81, V17-V30.
% Siahsar, M. A. N., Gholtashi, S., Kahoo, A. R., W. Chen, and Y. Chen, 2017, Data-driven multi-task sparse dictionary learning for noise attenuation of 3D seismic data, Geophysics, 82, V385-V396.
% Siahsar, M. A. N., V. Abolghasemi, and Y. Chen, 2017, Simultaneous denoising and interpolation of 2D seismic data using data-driven non-negative dictionary learning, Signal Processing, 141, 309-321.
% Chen, Y., M. Zhang, M. Bai, and W. Chen, 2019, Improving the signal-to-noise ratio of seismological datasets by unsupervised machine learning, Seismological Research Letters, 90, 1552-1564.
% Chen, Y., S. Zu, W. Chen, M. Zhang, and Z. Guan, 2019, Learning the blending spikes using sparse dictionaries, Geophysical Journal International, 218, 1379?1397. 
% Wang, H., Q. Zhang, G. Zhang, J. Fang, and Y. Chen, 2020, Self-training and learning the waveform features of microseismic data using an adaptive dictionary, Geophysics, 85, KS51?KS61.
% Zu, S., H. Zhou, R. Wu, M. Jiang, and Y. Chen, 2019, Dictionary learning based on dip patch selection training for random noise attenuation, Geophysics, 84, V169?V183.
% Zu, S., H. Zhou, R. Wu, and Y. Chen, 2019, Hybrid-sparsity constrained dictionary learning for iterative deblending of extremely noisy simultaneous-source data, IEEE Transactions on Geoscience and Remote Sensing, 57, 2249-2262.
% etc. 
%% denoise using SGK %when K=3, SGK is even better than KSVD (13.23 dB)
% the computational difference is larger when T is larger
param=struct('T',3,'niter',10,'mode',1,'K',64);
mode=1;l1=4;l2=4;l3=4;s1=2;s2=2;s3=2;perc=1;
d = load("C:\Users\22362\Desktop\reproducible_research\pstm_150_400_40_noise_snr0.mat").data;
dc = load("C:\Users\22362\Desktop\reproducible_research\pstm_150_400_40_clear.mat").data;
size(d)
tic
[d1,D,G,D0]=yc_sgk_denoise(d,mode,[l1,l2,l3],[s1,s2,s3],perc,param);
toc
yc_snr(dc,d1,2) %12.89 dB

s_cplot(squeeze(d1(:,:,4)));

%% benchmark with KSVD
% tic
% [d2,D2,G2,D02]=yc_ksvd_denoise(d,mode,[l1,l2,l3],[s1,s2,s3],perc,param);
% toc
% s_cplot(squeeze(d2(:,:,4)));

%% SNR
% yc_snr(dc,d,2)  %-0.01 dB
% yc_snr(dc,d1,2) %12.89 dB
% yc_snr(dc,d2,2) %13.33 dB


% %% benchmark with FXYMSSA %SNR=12.77 dB
% flow=0;fhigh=125;dt=0.004;N=3;verb=0;
% d2=fxymssa(d,flow,fhigh,dt,N,verb); 
% figure;imagesc([dc(:,:,10),d(:,:,10),d2(:,:,10),d(:,:,10)-d2(:,:,10)]);colormap(seis);
% yc_snr(dc,d2,2) %12.771 dB



