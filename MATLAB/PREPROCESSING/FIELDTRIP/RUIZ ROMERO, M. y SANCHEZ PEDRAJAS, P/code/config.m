%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (config.m)
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% EEG preprocessing configuration file: On this file you can configure all
% the parameters and steps of your preprocessing routine. It is a very
% basic preprocessing script. If you need or want to include any variable
% that don't appear here you have to write it in their 'prep' function or
% talk with us.

%% Path to FIELDTRIP
addpath(genpath('C:\Users\Usuario\Documents\GitHub\fieldtrip'));

%% Path to BIDS's compatible folder:
addpath(genpath('C:\Users\Usuario\Documents\EEG\BIDS\code')); % Replace with your own (folder with src folder, eeg_preproc and config scripts)
addpath(genpath('C:\Users\Usuario\Documents\EEG\BIDS'));

conf.datapath = 'C:\Users\Usuario\Documents\EEG\BIDS';        % Path of BIDS data (replace with your own)
conf.extension = '.vhdr';

%% Task name 
conf.taskname = 'task-';  % Replace with your own 'unnamed', do not change 'task-'.

%% Steps to preprocess
% We recommend to follow these steps. DO NOT CHANGE NAMES. 
%
% step1 = 'viewsignal';
% step2 = 'resampled'; 
% step3 = 'highpass-filtered';
% step4 = 'lowpass-filtered';
% step5 = 'notch-filtered'; % notch filter or band-pass filter
% step6 = 'epoched';
% step7 = 'icaweights';
% step8 = 'icapruned';
% step9 = 'trialpruned'; 
% step10 = 'interpoled'; 
% step11 = 'rereferenced'; % And baselinecorrection
%
% However, you can change with your own, according to your subsequent analysis. Also, you
% can repeat steps according with your preprocessing add them. If it is
% necessary to add different steps from these, please contact with us.
% 
% step1 = ''; % Replace with your own
% step2 = ''; 
% step3 = '';
% step4 = '';
% step5 = ''; 
% step6 = ''; 
% step7 = ''; 
% step8 = ''; ...
% 
% steps = {step1,step2,step3,step4,step5,step6,step7,step8...}; % Replace with your own

% We recommend to follow these steps. However, you can change with your own.
step1 = ''; 
step2 = ''; 
step3 = ''; 
step4 = ''; 
step5 = ''; 
step6 = ''; 
step7 = ''; 
step8 = ''; 
step9 = ''; 

% Preprocessing steps, add more steps if you need:
steps = {step1,step2,step3,step4,step5,step6,step7,step8,step9};


%% Subjects to load:
%  By default the preprocessing script loads all the subjects containded in
%  the dataset folder. Add the desired subject ids to the cfg.subjects cell 
%  array to specify the subjects to load.   

load_subject = 0;  % Inicializate variable

conf.subjects = {
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

%% Resample:
% According to Nyquist Theorem your sampling frequency should be at least
% the double of the higher frenquency you are interested in.
% Resampling configuration:

conf.resamplefs = 250;                % Frequency at which the data will be resampled.

conf.resample.save = true;            % Save resampled data.
conf.resample.sdir = 'resampled_eeg'; % Destination folder.

%% Filters:
% Replace or change parameters according with your experiment.
% Filtering configuration:

conf.hpfilter  = 'yes';                                % 'no' or 'yes'  highpass filter (default = 'no')
conf.hpfreq  = 0.5;                                    % High pass frequency in Hz.
conf.hpfiltord     = 3;                                % Highpass filter order (default set in low-level function)
conf.lpfilter  = 'yes';                                % 'no' or 'yes'  lowpass filter (default = 'no')
conf.lpfreq    = 50;                                   % Low pass frequency in Hz.
% conf.lpfiltord     =                                 % Highpass filter order (default set in low-level function)
conf.dftfreq   = [50 100 150];                         % Line noise frequencies in Hz for DFT filter (default = [50 100 150])
% conf.bpfilter      =                                 % 'no' or 'yes'  bandpass filter (default = 'no')
% conf.bsfreq        =                                 % Bandstop frequency range, specified as [low high] in Hz (or as Nx2 matrix for notch filter)

conf.highpassfilter.save = true;                       % Save filtered data.
conf.highpassfilter.sdir = 'highpass-filtered_eeg';    % Destination folder.
conf.lowpassfilter.save = true;                        % Save filtered data.
conf.lowpassfilter.sdir = 'lowpass-filtered_eeg';      % Destination folder.
conf.notchfilter.save = true;                          % Save filtered data.
conf.notchfilter.sdir = 'notch-filtered_eeg';          % Destination folder.


%% Extract epochs:
% Epoching configuration:

conf.trialfun = 'ft_trialfun_general'; % String with the function name, see below (default = 'ft_trialfun_general')

% For ft_trialfun_general:

conf.trialdef.eventtype  = 'STATUS';   % String, or cell-array with strings
conf.trialdef.eventvalue = [1 2 3 4];  % Number, string, or list with numbers or strings
conf.trialdef.prestim    = 1;          % Number, latency in seconds
conf.trialdef.poststim   = 1;          % Number, latency in seconds

conf.epochs.save = true;               % Save epoched data.
conf.epochs.sdir = 'epoched_eeg';      % Destination folder.

%% Independent Component Analysis (ICA):
% The configuration should contain:

conf.method.ica = 'runica';            % 'runica', 'fastica', 'binica', 'pca', 'svd', 'jader', 'varimax', 'dss', 'cca', 'sobi', 'white' or 'csp' (default = 'runica')
conf.numcomponent = 50;                % 'all' or number (default = 'all')
conf.channel.ica = {'all' '-Status'};

conf.toilim.ica = [-0.5 0.5];
conf.ylim.ica   = [-20 20];

conf.ica.save = true;                  % Save ICA weights.
conf.ica.sdir = 'icaweights_eeg';      % Destination folder.

%% Bad components:
%  After computing the ICA decomposition the identified artifactual
%  components per subjects should be specified here if you haven't done a 'badicas.mat' file.

% The configuration structure can contain:

%badicas = [badicas 2];                           % To include many badica that you forget deleting or you want to do after.
conf.ica.badcomponents.save = true;               % Save ICA pruned data.
conf.ica.badcomponents.sdir = 'icapruned_eeg';    % Destination folder.

%% Delete bad trials:
% The configuration Inspeccción visual/manual rápida (semiautomatic) contain:

conf.method.deletebadtrials     ='summary';                  % String, describes how the data should be shown, this can be 'summary' show a single number for each channel and trial (default), 'channel' show the data per channel, all trials at once 'trial', show the data per trial, all channels at once
conf.channel.deletebadtrials    = {'all'  '-VEOG'  '-HEOG'}; % Nx1 cell-array with selection of channels (default = 'all'), see FT_CHANNELSELECTION for details

%  Select the delete bad trials mode to compute manually:

conf.toilim.deletebadtrials  = [-0.5 0.5];
conf.ylim.deletebadtrials    = [-100 100];

conf.deletebadtrials.mode = 'manual';                        % Mode to delete bad trials, 'manual', semiautomatic' or 'automatic'.

% badtrials = [badtrials 7];                                 % To include many badtrial that you forget deleting or you want to do after.

conf.deletebadtrials.save = true;                            % Save trial pruned data.
conf.deletebadtrials.sdir = 'deletebadtrials_eeg';           % Destination folder.

%% Electrodes to interpole:
%  If you do Inspeccción visual/manual rápida (semi-automática), you don't have to interpole.

%cfg.template      =                               % Name of the template file, e.g. CTF275_neighb.mat
conf.method.interpole      = 'template';           % 'distance', 'triangulation' or 'template'
conf.layout      = 'EGI128.lay';                   % Filename of the layout, see FT_PREPARE_LAYOUT

conf.badchannels = {'FC1','PO8','O1','Oz','O2'};   % Cell-array, see FT_CHANNELSELECTION for details

conf.elecfile    = 'standard_1005.elc';            % Structure with electrode positions or filename, see FT_READ_SENS

conf.viewmode    = 'vertical'; 

conf.interpole.save = true;                        % Save interpoled data.
conf.interpole.sdir = 'interpoled_eeg';            % Destination folder.

%% Reference electrode and re-reference:
% Recover the reference electrode manually and compute re-reference.

conf.reref      = 'yes';                        % 'no' or 'yes' (default = 'no')
conf.refchannel = 'all';                        % Cell-array with new EEG reference channel(s), this can be 'all' for a common average reference
conf.refmethod     = 'avg';                     % 'avg', 'median', 'rest', 'bipolar' or 'laplace' (default = 'avg')

% Baseline correction:

conf.demean         = 'yes';                    % 'no' or 'yes', whether to apply baseline correction (default = 'no')
conf.baselinewindow = [-0.2 0];                 % [begin end] in seconds, the default is the complete trial (default = 'all')

conf.rereference.save = true;                   % Save re-referenced data.
conf.rereference.sdir = 'rereferenced_eeg';     % Destination folder.

%% Extract conditions: NOT IMPLEMENTED YET (IF YOU WANT INCLUIDE IT YOU HAVE TO CHANGE PREP_EXTRACT_CONDITIONS TOO IF IT WOULD BE NECESSARY)
%  Condition to extract:
% 
% conf.conditions.flag = false;             % Enable/disable cond. extraction.
% 
% % Specify condition names to extrac:
% 
% conf.conditions.names{1} = '';
% conf.conditions.names{2} = '';
% conf.conditions.names{3} = '';            % ...
% 
% % Each condition could contain different triggers:
% 
% conf.conditions.triggers{1} = {           % Triggers to extract for condition 1
%     ''
%     };
% 
% conf.conditions.save = true;              % Save extracted conditions.
% conf.conditions.sdir = 'conditions_eeg';  % Destination folder.

%% Other parameters: NOT IMPLEMENTED YET. (YOU CAN DO IT IF YOU WANT. MODIFIED PREP_RENAME_EVENTS)

% conf.rename = false;                      % Rename events.
