%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (config.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes made by: María Ruiz and María del Pilar Sánchez
% (mariaruizromero@ugr.es, pilarsanpe@ugr.es)
% -------------------------------------------------------------------------
% EEG preprocessing configuration file: On this file you can configure all
% the parameters and steps of your preprocessing routine.

%% Path to EEGLAB
addpath(genpath('C:\Users\Usuario\Downloads\eeglab2021.1'));

%% Path to BIDS's compatible folder:
addpath(genpath('C:\Users\Usuario\Documents\EEG\BIDS\code'));  % Replace with your own (folder with src folder, eeg_preproc and config scripts)
cfg.datapath = 'C:\Users\Usuario\Documents\EEG\BIDS\';         % Path of BIDS data (replace with your own)

%% Task name
cfg.taskname = 'unnamed';  % Replace with your own

%% Steps to preprocess
% We recommend to follow these steps. DO NOT CHANGE NAMES. 
%
% step1 = 'resampled'; 
% step2 = 'highpass-filtered';
% step3 = 'lowpass-filtered';
% step4 = 'notch-filtered';
% step5 = 'epoched';
% step6 = 'icaweights';
% step7 = 'deletebadchannels'; 
% step8 = 'icapruned';
% step9 = 'trialpruned'; 
% step10 = 'interpoled'; 
% step11 = 'rereferenced';
%
% However, you can change with your own, according to your subsequent analysis. Also, you
% can repeat steps according with your preprocessing add them. If it is
% necessary to add different steps from these, please contact with us.

step1 = '';  % Replace with your own
step2 = ''; 
step3 = '';
step4 = '';
step5 = ''; 
step6 = ''; 
step7 = ''; 
step8 = ''; ...

steps = {step1,step2,step3,step4,step5,step6,step7,step8}; % Order by your own

%% Subjects to load:
%  By default the preprocessing script loads all the subjects containded in
%  the dataset folder. Add the desired subject ids to the cfg.subjects cell 
%  array to specify the subjects to load.   
load_subject = 0;  % Inicializate variable
cfg.subjects = {
     'sub-001';
%      'sub-002';
%      'sub-003';
%      'sub-004';
%      'sub-005';
%      'sub-006';
%      'sub-007';
%      'sub-008';
%      'sub-009';
%      'sub-010';
%      'sub-011';
%      'sub-012';
%      'sub-013';
%      'sub-014';
%      'sub-015';
%      'sub-016';
%      'sub-017';
%      'sub-018';
%      'sub-019';
%      'sub-020';
%      'sub-021';
%      'sub-022';
%      'sub-023';
%      'sub-024';
%      'sub-025';
%      'sub-026';
%      'sub-027';
%      'sub-028';
%      'sub-029';
%      'sub-030';
%      'sub-031';
%      'sub-032';
%      'sub-033';
    };

%% Channels to load.
%  Channel indexes to load. 
%  Empty by default: Load all the channels.
cfg.chantoload = []; 

%% Deleted channels
%  Delete bad channels (recommended after ICA). 
%  (e.g. Ocular channels, noisy channels, etc).
%  This step is manual, you have to look at signal or the ICAs in eeglab in order to
%  delete bad channels. 
cfg.deletechannels.flag = true;                      % Enable/disable delete channels.

cfg.deletechannels.save = true;                      % Save delete channels.
cfg.deletechannels.sdir = 'deletedbadchannels_eeg';  % Destination folder.

cfg.deletechannels.names = {                         % In numbers (example: eogs electrodes)
     []; % sub-001
%     []; % sub-002
%     []; % sub-003
%     []; % sub-004
%     []; % sub-005
%     []; % sub-006
%     []; % sub-007
%     []; % sub-008
%     []; % sub-009
%     []; % sub-010
%     []; % sub-011
%     []; % sub-012
%     []; % sub-013
%     []; % sub-014
%     []; % sub-015
%     []; % sub-016
%     []; % sub-017
%     []; % sub-018
%     []; % sub-019
%     []; % sub-020
%     []; % sub-021
%     []; % sub-022
%     []; % sub-023
%     []; % sub-024
%     []; % sub-025
%     []; % sub-026
%     []; % sub-027
%     []; % sub-028
%     []; % sub-029
%     []; % sub-030
%     []; % sub-031
%     []; % sub-032
%     []; % sub-033
    };

%% Ignored channels
%  Ignored channels for different data preprocesing steps (ICA & trial 
%  rejection). e.g. Ocular channels, noisy channels, etc.
cfg.ignoredchannels = {
    []; % sub-001
%     []; % sub-002
%     []; % sub-003
%     []; % sub-004
%     []; % sub-005
%     []; % sub-006
%     []; % sub-007
%     []; % sub-008
%     []; % sub-009
%     []; % sub-010
%     []; % sub-011
%     []; % sub-012
%     []; % sub-013
%     []; % sub-014
%     []; % sub-015
%     []; % sub-016
%     []; % sub-017
%     []; % sub-018
%     []; % sub-019
%     []; % sub-020
%     []; % sub-021
%     []; % sub-022
%     []; % sub-023
%     []; % sub-024
%     []; % sub-025
%     []; % sub-026
%     []; % sub-027
%     []; % sub-028
%     []; % sub-029
%     []; % sub-030
%     []; % sub-031
%     []; % sub-032
%     []; % sub-033
    };

%% Resample:
%  According to Nyquist Theorem your sampling frequency should be at least
%  the double of the higher frenquency you are interested in.
% Resampling configuration:
cfg.resample.flag = true;             % Enable/disable resampling.
cfg.resample.freq = 256;              % Desired sampling frequency (Hz).

cfg.resample.save = true;             % Save resampled data.
cfg.resample.sdir = 'resampled_eeg';  % Destination folder.

%% Filters:
% Replace or change parameters according with your experiment.
% High-pass filter:
cfg.filter.highpass.flag = true;                    % Enable/disable high-pass filter.
cfg.filter.highpass.order = [];                     % Filter order: [] = default.
cfg.filter.highpass.fcutoff = 0.1;                  % Cut-off frequency (Hz).

cfg.highpassfilter.save = true;                     % Save filtered data.
cfg.highpassfilter.sdir = 'highpass-filtered_eeg';  % Destination folder.

% Low-pass filter:
cfg.filter.lowpass.flag = true;                     % Enable/disable low-pass filter.
cfg.filter.lowpass.order = [];                      % Filter order: [] = default.
cfg.filter.lowpass.fcutoff = 126;                   % Cut-off frequency (Hz).

cfg.lowpassfilter.save = true;                      % Save filtered data.
cfg.lowpassfilter.sdir = 'lowpass-filtered_eeg';    % Destination folder.

% Notch filter:
cfg.filter.notch.flag = true;                       % Enable/disable notch filter.
cfg.filter.notch.order = [];                        % Filter order: [] = default.
cfg.filter.notch.fnull = [                          % Main freq and its harmonics.
    49 51;
    99 101
    ];

cfg.notchfilter.save = true;                        % Save filtered data.
cfg.notchfilter.sdir = 'notch-filtered_eeg';        % Destination folder.

%% Extract epochs:
cfg.epochs.flag = true;             % Enable/disable data epoching.
cfg.epochs.bounds = [-1 2];         % Trial boundaries in seconds (s).

% Specify the trigger id to load.
% Empty by default: Load the complete dataset.
cfg.epochs.names = {                % Trial names to extract.
    };

cfg.epochs.save = true;             % Save epoched data.
cfg.epochs.sdir = 'epoched_eeg';    % Destination folder.

%% Independent Component Analysis (ICA):
% This algorithm is computed ignoring the channel indexes included in
% cfg.ignoredchannels. This is useful to compute the ICAs ignoring bad 
% channels that will be removed later. After compute ICA you can see them in
% eeglab (Inspect/Label components by map).
cfg.ica.flag = true;              % Enable/disable ICA decomposition
cfg.ica.method = 'runica';        % ICA algorithm to use for decomposition.
cfg.ica.extended = true;          % Recommended.

cfg.ica.save = true;              % Save ICA weights.
cfg.ica.sdir = 'icaweights_eeg';  % Destination folder.

%% Bad components:
%  After computing the ICA decomposition the identified artifactual
%  components per subjects should be specified here. 
%  This step is manual, you have to look at the ICAs in eeglab in order to
%  ignore bad components. You can do it automatically in eeglab instead (eg. ADJUST tools, eeglab extension)
cfg.ica.badcomponents.flag = true;      % Enable/dis. remove artifactual comp.
cfg.ica.badcomponents.delete = {        % Indexes to remove per subject.
    [1 2 3]; % sub-001
    []; % sub-002
    []; % sub-003
    []; % sub-004
    []; % sub-005
    []; % sub-006
    []; % sub-007
    []; % sub-008
    []; % sub-009
    []; % sub-010
    []; % sub-011
    []; % sub-012
    []; % sub-013
    []; % sub-014
    []; % sub-015
    []; % sub-016
    []; % sub-017
    []; % sub-018
    []; % sub-019
    []; % sub-020
    []; % sub-021
    []; % sub-022
    []; % sub-023
    []; % sub-024
    []; % sub-025
    []; % sub-026
    []; % sub-027
    []; % sub-028
    []; % sub-029
    []; % sub-030
    []; % sub-031
    []; % sub-032
    []; % sub-033
    };

cfg.ica.badcomponents.save = true;               % Save ICA pruned data.
cfg.ica.badcomponents.sdir = 'icapruned_eeg';    % Destination folder.

%% Trial rejection:
%  Select the automatic trial rejection processes to compute:
cfg.trialrej.abspect.flag = true;                   % Enable/disable: Abnormal spectra.
cfg.trialrej.impdata.flag = true;                   % Enable/disable: Improbable data.
cfg.trialrej.extrval.flag = true;                   % Enable/disable: Extreme values.

cfg.trialrej.type = 1;                              % Data type (1=electrods|0=components).
cfg.trialrej.report = true;                         % Enable/disable rejection report.

% Abnormal spectra configuration:
cfg.trialrej.abspect.threshold = [-50 50;-100 25];  % Threshold lim. in dB.
cfg.trialrej.abspect.freqlimits = [0 2;20 40];      % Freq. limits in Hz.
cfg.trialrej.abspect.method = 'fft';                % Method(fft|multitap).
cfg.trialrej.abspect.eegplotreject = 0;

% Improbable data configuration:
cfg.trialrej.impdata.loclim = 6;                    % Local limit(s) (in std. dev.)
cfg.trialrej.impdata.globlim = 6;                   % Global limit(s) (in std. dev.)    

% Extrme values configuration:
cfg.trialrej.extrval.uplim = 150;                   % Upper voltage limit.
cfg.trialrej.extrval.lolim = -150;                  % Lower voltage limit


cfg.trialrej.save = true;                           % Save trial pruned data.
cfg.trialrej.sdir = 'trialpruned_eeg';              % Destination folder.

%% Electrodes to interpole:
%  Cell array of electrodes to interpole for each subject must be specified
%  in cfg.interpole.channels.
cfg.interpole.flag = true;               % Enable/disable interpolation.
cfg.interpole.metohd = 'spherical';      % Interpolation method.

cfg.interpole.channels = {
    [1 2 3]; % sub-001
    []; % sub-002
    []; % sub-003
    []; % sub-004
    []; % sub-005
    []; % sub-006
    []; % sub-007
    []; % sub-008
    []; % sub-009
    []; % sub-010
    []; % sub-011
    []; % sub-012
    []; % sub-013
    []; % sub-014
    []; % sub-015
    []; % sub-016
    []; % sub-017
    []; % sub-018
    []; % sub-019
    []; % sub-020
    []; % sub-021
    []; % sub-022
    []; % sub-023
    []; % sub-024
    []; % sub-025
    []; % sub-026
    []; % sub-027
    []; % sub-028
    []; % sub-029
    []; % sub-030
    []; % sub-031
    []; % sub-032
    []; % sub-033
    };


cfg.interpole.save = true;                % Save interpoled data.
cfg.interpole.sdir = 'interpoled_eeg';    % Destination folder.

%% Reference electrode and re-reference:
% Recover the reference electrode manually and compute re-reference.
cfg.refelec.flag = true;                 % Enable/disable ref. electrode recovery.

cfg.refelec.chan  = 64;                  % Channel number. Replace by your own
cfg.refelec.label = 'FCz';               % Channel label. Replace by your own
cfg.refelec.type  = 'REF';               % Channel type.

% Polar coordinates:
cfg.refelec.theta  = 0;
cfg.refelec.radius = 0.125; 

% Cartesian coordinates:
cfg.refelec.X  = 0.38268;				 
cfg.refelec.Y  = 0;
cfg.refelec.Z  = 0.92388;

% Spherical coordinates:
cfg.refelec.sph_theta  = 0;
cfg.refelec.sph_phi  = 67.5;
cfg.refelec.sph_radius  = 1;

% Compute data re-reference:
cfg.reref.flag = true;                   % Enable/disable data re-reference.
cfg.reref.chan = [];                     % New reference electrore - [] = average.


cfg.reref.save = true;                   % Save re-referenced data.
cfg.reref.sdir = 'rereferenced_eeg';     % Destination folder.

%% Extract conditions:
%  Condition to extract:

cfg.conditions.flag = true;              % Enable/disable cond. extraction.
cfg.conditions.baseline.flag = true;     % Enable/disable baseline correction.
cfg.conditions.baseline.w = [-199 0];    % Baseline boundaries in milisec. The baseline cannot be exactly the bound of the trial(200).

cfg.conditions.report = true;            % Enable/disable conditions report.

% Specify condition names to extrac (Replace by your own): 
cfg.conditions.names{1} = 'target-congruent-correct'; 
cfg.conditions.names{2} = '';
cfg.conditions.names{3} = ''; % ...


% Each condition could contain different triggers:

cfg.conditions.triggers{1} = {           % Triggers to extract for condition 1
    ''
    ''
    ''
    ''
    ''
    ''
    ''
    ''
    };

cfg.conditions.triggers{2} = {           % Triggers to extract for condition 2
    ''
    ''
    ''
    ''
    };

cfg.conditions.triggers{3} = {           % Triggers to extract for condition 3
    ''
    ''
    }; ...

cfg.conditions.save = true;              % Save extracted conditions.
cfg.conditions.sdir = 'conditions_eeg';  % Destination folder.

%% Other parameters:
cfg.rename = true;           % Rename events (Script: prep_rename_events)

cfg.saveformat = 'both';     % Output data format: 'mat'-'set'-'both'
