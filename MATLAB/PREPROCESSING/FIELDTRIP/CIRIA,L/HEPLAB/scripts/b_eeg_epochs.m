% -----------------
% Tutorial HEP Donostia 2023
% Luis Ciria
% lciria@ugr.es
% ------------------------------------------------------------------------------------------
% mergeRR - % creates new events (heartbeats) in the EEG continuous signal
% ------------------------------------------------------------------------------------------
clear
clc
close all

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data';             % Data location
cd(datapath)

trial_window = [-0.2 0.8]; % epoch in seconds

% load the EEG file 
load('ENT_1_raw.mat');

% load the RR-ECG file or RR and TT file 
%load('ENT_1_ecg_rr.mat');       %rr from ecglab            (use supporting file if necessary)
load('ENT_1_ecg_rr_tt.mat');    %rr and tt from ECG-Deli    (use supporting file if necessary)

% create a variable (trl) with epochs info (in samples): when does each epoch starts and ends based on heartbeats
p = 1; %for R wave set peak = 1; for T wave set peak = 2
if p == 1
    trig = rr;
elseif p == 2
    trig = tt;
else
end

trl = [];
trl(:,1)    = trig*data_eeg.fsample - round(abs(trial_window(1)*data_eeg.fsample)); %  onset (in samples) of each epoch (adjust sampling rate if necessary)
trl(:,2)    = trig*data_eeg.fsample + round(trial_window(2)*data_eeg.fsample);      %  offset (in samples) of each epoch (adjust sampling rate if necessary)
trl(:,3)    = round(trial_window(1)*data_eeg.fsample);                              %  onset (in samples) of each epoch with respect to R peak (timepoint 0). (adjust sampling rate if necessary)
trl(end,:)  = []; % remove the last (or first) trial if necessary

%% Add new events (R or T peaks) to the EEG matrix
cfg = [];
cfg.dataset = 'ENT_1_raw.set';
cfg.trl     = trl; 
data        = ft_preprocessing (cfg);
 
% Save new dataset
cd (datapath) 
save 'ENT_1_rawEEG_newEvents.mat' data
