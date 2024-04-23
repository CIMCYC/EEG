% ------------------------------------------------------------------------------------------
% Tutorial HEP Donostia 2023
% Luis Ciria
% lciria@ugr.es
% ------------------------------------------------------------------------------------------
% Extracts the ECG signal from the EEG raw data file and detects heartbeats
% ------------------------------------------------------------------------------------------
clear
close all
clc

addpath('/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/toolboxes/fieldtrip'); %fieldtrip
addpath(genpath('/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/toolboxes/ecglab')); %ecglab
addpath(genpath('/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/toolboxes/ecgDeli')); %ecgDeli

ft_defaults; % sets some general fieldtrip settings 

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data';             % Data location
cd(datapath)

%% load the EEG file
load('ENT_1_raw.mat');

% to visualise the ECG signal you can use:
chan = 65;
plot(data_eeg.time{1}, data_eeg.trial{1}(chan, :))
xlabel('time (s)')
ylabel('amplitude (uV)')
legend(data_eeg.label(chan))

%% extract ECG signal from EEG dataset
ecgout = data_eeg.trial{1}(chan, :); 

% filter the ECG signal using the ecg_filt function (Butterworth filter: 0.5 - 50 Hz)
ecg = ecg_filt(double(ecgout),data_eeg.fsample);

% ---------------------------------------------------------------------
%% prepare ECG .mat file for R or T peaks detection
% Two different toolboxes for detecting R (or T) ECG peaks: 1) ecglabRR 2) EEG-Deli
% ---------------------------------------------------------------------

%  ---------------------------- ecglabRR  ----------------------------
% Save ecg and fs variables (semi-automatic, slow but accurate) 
ecg = ecg'; % ecg must be an Nx1 vector
fs  = data_eeg.fsample; % sampling frequency
save ('ENT_1_ecg.mat','ecg','fs');

% Next step ---> load the ecg.mat file called ENT_1_ecg.mat to ecglabRR
% use the ecglabRR GUI to generate the file with the heartbeat latencies for each participant


%% ------------------------------ ECG-Deli ------------------------------
% Do NOT need to save variables in advance (automatic and fast but check for accuracy). It also detect other ECG waves (e.g., T peak) 

[FPT_MultiChannel,FPT_Cell]=Annotate_ECG_Multi(ecg,fs); % R and T peaks detection (column 6 = R peaks; column 11 = T peaks)

rr = FPT_MultiChannel(:,6);   % r peak latencies in samples
tt = FPT_MultiChannel(:,11);  % t peak latencies in samples

% visualize ecg signal, r peaks and t peaks 
figure; 
plot(ecg(:,1));
hold on; 
scatter(rr,ecg(rr), 'r', 'filled');
scatter(tt,ecg(tt), 'g', 'filled');
title('Filtered ECG');
xlabel('samples'); ylabel('voltage');
legend({'ECG signal', 'R waves', 'T waves'});

% save variables (in seconds)
rr = rr/fs;
tt = tt/fs;

save ('ENT_1_ecg_rr_tt.mat','ecg','fs','rr','tt');
