function saveecg(filename,ecg,fs)
% USAGE: saveecg(filename,ecg,fs);
%
% Saves ECG data into a Matlab-format (.mat) file.
%
% INPUTS:
% filename: full path to a .mat file where ECG data will be saved
% ecg: a column vector containing ecg samples.
% fs: the ECG sampling rate, in Hz.
%
% EXAMPLE OF USE:
% samplingrate = 360; % Hz
% saveecg('c:\ecglab\signals\myecg.mat',myecg,samplingrate);
%
% Written by Joao L A Carvalho <joaoluiz@gmail.com>
% 2008-10-22

save(filename,'ecg','fs');