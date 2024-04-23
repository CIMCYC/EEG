function [ecg,fs,t] = plotecg(filename)
% USAGE: [ecg,fs,t] = plotecg(filename);
%
% Loads and plots ECG data save in a Matlab-format (.mat) file.
%
% INPUTS:
% filename: full path to the .mat file where ECG data is stored
%
% OUTPUTS:
% ecg: vector with ECG samples
% fs: sampling rate, in Hz
% t: time axis, in seconds
%
% EXAMPLE OF USE:
% [ecg,fs,t] = plotecg('c:\ecglab\signals\103_ch1_000to300.mat');
%
% Written by Joao L A Carvalho <joaoluiz@gmail.com>
% 2008-10-22

load(filename)

N = length(ecg);

t = (0:(N-1))'/fs;

figure,
plot(t,ecg,'b-')
xlabel('time (s)')
ylabel('normalized amplitude')
