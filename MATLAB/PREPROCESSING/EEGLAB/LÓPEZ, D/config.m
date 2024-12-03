%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (config.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes to export to BIDS format made by:
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% -------------------------------------------------------------------------
% EEG preprocessing configuration file: On this file you can configure all
% the parameters and steps of your preprocessing routine. At the end, preprocessing
% data will be in BIDS' format.
%
%% Path to EEGLAB
addpath(genpath('C:\Users\Usuario\Downloads\eeglab2021.1'))

%% Path to BIDS's compatible folder:
addpath(genpath('C:\Users\Usuario\Documents\EEG\code')) % Replace with your own (folder with src folder, eeg_preproc and config scripts)
cfg.datapathraw = 'C:\Users\Usuario\Documents\EEG\'; % Path of raw data (replace with your own)

% Choose the type of datapath you are going to work with (only one, BIDS or raw data) and comment the other:
% cfg.datapath = 'C:\Users\Usuario\Documents\EEG\BIDS\'; % Path of BIDS data (replace with your own)
cfg.datapath = 'C:\Users\Usuario\Documents\EEG\'; % Path of sourcedata file (replace with your own)
cfg.task = 'task-unnamed'; % Replace with your own

%% 0.1 Subjects to load:
%  By default the preprocessing script loads all the subjects containded in
%  the dataset folder. Add the desired subject ids to the cfg.subjects cell 
%  array to specify the subjects to load.

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
     % 'sub-034';
     % 'sub-035';
     % 'sub-036';
     % 'sub-037';
     % 'sub-038';
     % 'sub-039';
     % 'sub-040';
     % 'sub-041';
    };

%% 0.2 Channels to load.
%  Channel indexes to load. 
%  Empty by default: Load all the channels.

cfg.chantoload = []; 

%% 0.3 Ignored channels
%  Ignored channels for different data preprocesing steps (ICA & trial 
%  rejection). e.g. Ocular channels, noisy channels, etc.

cfg.ignoredchannels = {
     [59,62]; % sub-001
%      [59,62]; % sub-002
%      [59,62]; % sub-003
%      [59,62]; % sub-004
%      [59,62]; % sub-005
%      [59,62]; % sub-006
%      [59,62]; % sub-007
%      [59,62]; % sub-008
%      [59,62]; % sub-009
%      [59,62]; % sub-010
%      [17,59,62]; % sub-011
%      [59,62]; % sub-012
%      [59,62]; % sub-013
%      [59,62]; % sub-014
%      [59,62]; % sub-015 
%      [59,62]; % sub-016
%     [59,62]; % sub-017
%     [59,62]; % sub-018
%     [59,62]; % sub-019
%     [59,62]; % sub-020
%     [59,62]; % sub-021
%     [59,62]; % sub-022
%     [59,62]; % sub-023
%     [59,62]; % sub-024
%     [59,62]; % sub-025
%     [59,62]; % sub-026
%     [59,62]; % sub-027
%     [59,62]; % sub-028
%     [59,62]; % sub-029
%     [59,62]; % sub-030
%     [59,62]; % sub-031
%     [59,62]; % sub-032
%     [59,62]; % sub-033
%     [59,62]; % sub-034
%     [59,62]; % sub-035
%     [59,62]; % sub-036
%     [59,62]; % sub-037
%     [59,62]; % sub-038
%     [59,62]; % sub-039
%     [59,62]; % sub-040
%     [59,62]; % sub-041
     };  % Replace with your own.

%% 1. Resample:
%  According to Nyquist Theorem your sampling frequency should be at least
%  the double of the higher frenquency you are interested in.

% Resampling configuration:
cfg.resample.flag = true;           % Enable/disable resampling.
cfg.resample.freq = 256;            % Desired sampling frequency (Hz).

cfg.resample.save = true;           % Save resampled data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.resample.sdir = [cfg.task '_resampled_eeg']; % Destination folder (not change).

else
    cfg.resample.sdir = 'resampled_eeg'; % Destination folder (not change).

end

%% 2. Filters:

% High-pass filter:
cfg.filter.highpass.flag = true;  	% Enable/disable high-pass filter.
cfg.filter.highpass.order = [];    	% Filter order: [] = default.
cfg.filter.highpass.fcutoff = 0.1;	% Cut-off frequency (Hz).

% Low-pass filter:
cfg.filter.lowpass.flag = true;     % Enable/disable low-pass filter.
cfg.filter.lowpass.order = [];      % Filter order: [] = default.
cfg.filter.lowpass.fcutoff = 126;	% Cut-off frequency (Hz).

% Notch filter:
cfg.filter.notch.flag = true;    	% Enable/disable notch filter.
cfg.filter.notch.order = [];    	% Filter order: [] = default.
cfg.filter.notch.fnull = [      	% Main freq and its harmonics.
    49 51;
    99 101
    ];

% Plot filter frequency response.
cfg.filter.plotfreqresp = false;    % Enable/disable.

cfg.filter.save = true;             % Save filtered data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.filter.sdir = [cfg.task '_filtered_eeg']; % Destination folder (not change).

else
    cfg.filter.sdir = 'filtered_eeg'; % Destination folder (not change).

end

%% 3. Extract epochs:
cfg.epochs.flag = true;             % Enable/disable data epoching.
cfg.epochs.bounds = [-.2 7.0];         % Trial boundaries in seconds (s).

% Specify the trigger id to load.
% Empty by default: Load the complete dataset.
cfg.epochs.names = {'Inst_1_SEL_ANIM_C_13','Inst_1_SEL_ANIM_S_13', ...
                    'Inst_1_SEL_INAN_C_13','Inst_1_SEL_INAN_S_13', ...
                    'Inst_1_INT_ANIM_C_13','Inst_1_INT_ANIM_S_13', ...
                    'Inst_1_INT_INAN_C_13','Inst_1_INT_INAN_S_13', ...
                    'Inst_1_SEL_ANIM_C_14','Inst_1_SEL_ANIM_S_14', ...
                    'Inst_1_SEL_INAN_C_14','Inst_1_SEL_INAN_S_14', ...
                    'Inst_1_INT_ANIM_C_14','Inst_1_INT_ANIM_S_14', ...
                    'Inst_1_INT_INAN_C_14','Inst_1_INT_INAN_S_14', ...
                    'Inst_1_SEL_ANIM_C_23','Inst_1_SEL_ANIM_S_23', ...
                    'Inst_1_SEL_INAN_C_23','Inst_1_SEL_INAN_S_23', ...
                    'Inst_1_INT_ANIM_C_23','Inst_1_INT_ANIM_S_23', ...
                    'Inst_1_INT_INAN_C_23','Inst_1_INT_INAN_S_23', ...
                    'Inst_1_SEL_ANIM_C_24','Inst_1_SEL_ANIM_S_24', ...
                    'Inst_1_SEL_INAN_C_24','Inst_1_SEL_INAN_S_24', ...
                    'Inst_1_INT_ANIM_C_24','Inst_1_INT_ANIM_S_24', ...
                    'Inst_1_INT_INAN_C_24','Inst_1_INT_INAN_S_24', ...
                    'error_Inst_1_SEL_ANIM_C_13','error_Inst_1_SEL_ANIM_S_13', ...
                    'error_Inst_1_SEL_INAN_C_13','error_Inst_1_SEL_INAN_S_13', ...
                    'error_Inst_1_INT_ANIM_C_13','error_Inst_1_INT_ANIM_S_13', ...
                    'error_Inst_1_INT_INAN_C_13','error_Inst_1_INT_INAN_S_13', ...
                    'error_Inst_1_SEL_ANIM_C_14','error_Inst_1_SEL_ANIM_S_14', ...
                    'error_Inst_1_SEL_INAN_C_14','error_Inst_1_SEL_INAN_S_14', ...
                    'error_Inst_1_INT_ANIM_C_14','error_Inst_1_INT_ANIM_S_14', ...
                    'error_Inst_1_INT_INAN_C_14','error_Inst_1_INT_INAN_S_14', ...
                    'error_Inst_1_SEL_ANIM_C_23','error_Inst_1_SEL_ANIM_S_23', ...
                    'error_Inst_1_SEL_INAN_C_23','error_Inst_1_SEL_INAN_S_23', ...
                    'error_Inst_1_INT_ANIM_C_23','error_Inst_1_INT_ANIM_S_23', ...
                    'error_Inst_1_INT_INAN_C_23','error_Inst_1_INT_INAN_S_23', ...
                    'error_Inst_1_SEL_ANIM_C_24','error_Inst_1_SEL_ANIM_S_24', ...
                    'error_Inst_1_SEL_INAN_C_24','error_Inst_1_SEL_INAN_S_24', ...
                    'error_Inst_1_INT_ANIM_C_24','error_Inst_1_INT_ANIM_S_24', ...
                    'error_Inst_1_INT_INAN_C_24','error_Inst_1_INT_INAN_S_24', ...
                    'catch_Inst_1_SEL_ANIM_C_13','catch_Inst_1_SEL_ANIM_S_13', ...
                    'catch_Inst_1_SEL_INAN_C_13','catch_Inst_1_SEL_INAN_S_13', ...
                    'catch_Inst_1_INT_ANIM_C_13','catch_Inst_1_INT_ANIM_S_13', ...
                    'catch_Inst_1_INT_INAN_C_13','catch_Inst_1_INT_INAN_S_13', ...
                    'catch_Inst_1_SEL_ANIM_C_14','catch_Inst_1_SEL_ANIM_S_14', ...
                    'catch_Inst_1_SEL_INAN_C_14','catch_Inst_1_SEL_INAN_S_14', ...
                    'catch_Inst_1_INT_ANIM_C_14','catch_Inst_1_INT_ANIM_S_14', ...
                    'catch_Inst_1_INT_INAN_C_14','catch_Inst_1_INT_INAN_S_14', ...
                    'catch_Inst_1_SEL_ANIM_C_23','catch_Inst_1_SEL_ANIM_S_23', ...
                    'catch_Inst_1_SEL_INAN_C_23','catch_Inst_1_SEL_INAN_S_23', ...
                    'catch_Inst_1_INT_ANIM_C_23','catch_Inst_1_INT_ANIM_S_23', ...
                    'catch_Inst_1_INT_INAN_C_23','catch_Inst_1_INT_INAN_S_23', ...
                    'catch_Inst_1_SEL_ANIM_C_24','catch_Inst_1_SEL_ANIM_S_24', ...
                    'catch_Inst_1_SEL_INAN_C_24','catch_Inst_1_SEL_INAN_S_24', ...
                    'catch_Inst_1_INT_ANIM_C_24','catch_Inst_1_INT_ANIM_S_24', ...
                    'catch_Inst_1_INT_INAN_C_24','catch_Inst_1_INT_INAN_S_24', ...
                    'LOC_ITI','LOC_PROBE_instr_0_7','LOC_PROBE_instr_0_8',...
                    'LOC_PROBE_instr_1_7','LOC_PROBE_instr_1_8','LOC_PROBE_mammal_0_1',...
                    'LOC_PROBE_mammal_0_2','LOC_PROBE_mammal_1_1','LOC_PROBE_mammal_1_2',...
                    'LOC_PROBE_tool_0_5','LOC_PROBE_tool_0_6','LOC_PROBE_tool_1_5',...
                    'LOC_PROBE_tool_1_6','LOC_PROBE_sea_0_3','LOC_PROBE_sea_0_4',...
                    'LOC_PROBE_sea_1_3','LOC_PROBE_sea_1_4','LOC_PROBE_FIX_instr_0_7',...
                    'LOC_PROBE_FIX_instr_0_8','LOC_PROBE_FIX_instr_1_7',...
                    'LOC_PROBE_FIX_instr_1_8','LOC_PROBE_FIX_mammal_1_1',...
                    'LOC_PROBE_FIX_mammal_1_2','LOC_PROBE_FIX_mammal_0_1',...
                    'LOC_PROBE_FIX_mammal_0_2','LOC_PROBE_FIX_tool_0_5',...
                    'LOC_PROBE_FIX_tool_0_6','LOC_PROBE_FIX_tool_1_5',...
                    'LOC_PROBE_FIX_tool_1_6','LOC_PROBE_FIX_sea_0_3',...
                    'LOC_PROBE_FIX_sea_0_4','LOC_PROBE_FIX_sea_1_3',...
                    'LOC_PROBE_FIX_sea_1_4','error_LOC_ITI',...
                    'error_LOC_PROBE_instr_0_7','error_LOC_PROBE_instr_0_8',...
                    'error_LOC_PROBE_instr_1_7','error_LOC_PROBE_instr_1_8','error_LOC_PROBE_mammal_0_1',...
                    'error_LOC_PROBE_mammal_0_2','error_LOC_PROBE_mammal_1_1','error_LOC_PROBE_mammal_1_2',...
                    'error_LOC_PROBE_tool_0_5','error_LOC_PROBE_tool_0_6','error_LOC_PROBE_tool_1_5',...
                    'error_LOC_PROBE_tool_1_6','error_LOC_PROBE_sea_0_3','error_LOC_PROBE_sea_0_4',...
                    'error_LOC_PROBE_sea_1_3','error_LOC_PROBE_sea_1_4','error_LOC_PROBE_FIX_instr_0_7',...
                    'error_LOC_PROBE_FIX_instr_0_8','error_LOC_PROBE_FIX_instr_1_7',...
                    'error_LOC_PROBE_FIX_instr_1_8','error_LOC_PROBE_FIX_mammal_1_1',...
                    'error_LOC_PROBE_FIX_mammal_1_2','error_LOC_PROBE_FIX_mammal_0_1',...
                    'error_LOC_PROBE_FIX_mammal_0_2','error_LOC_PROBE_FIX_tool_0_5',...
                    'error_LOC_PROBE_FIX_tool_0_6','error_LOC_PROBE_FIX_tool_1_5',...
                    'error_LOC_PROBE_FIX_tool_1_6','error_LOC_PROBE_FIX_sea_0_3',...
                    'error_LOC_PROBE_FIX_sea_0_4','error_LOC_PROBE_FIX_sea_1_3',...
                    'error_LOC_PROBE_FIX_sea_1_4'
                    }; % Replace with your own.

cfg.epochs.save = true;             % Save epoched data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.epochs.sdir = [cfg.task '_epoched_eeg']; % Destination folder (not change).

else
    cfg.epochs.sdir = 'epoched_eeg'; % Destination folder (not change).

end

%% 4. Independent Component Analysis (ICA):
% This algorithm is computed ignoring the channel indexes included in
% cfg.ignoredchannels. This is useful to compute the ICAs ignoring bad 
% channels that will be removed later.

cfg.ica.flag = true;            % Enable/disable ICA decomposition
cfg.ica.method = 'runica';      % ICA algorithm to use for decomposition.
cfg.ica.extended = true;        % Recommended.
cfg.ica.source=step(4-1);
cfg.ica.save = true;            % Save ICA weights.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.ica.sdir = [cfg.task '_icaweights_eeg']; % Destination folder (not change).

else
    cfg.ica.sdir = 'icaweights_eeg'; % Destination folder (not change).

end

%% 5. Bad components:
%  After computing the ICA decomposition the identified artifactual
%  components per subjects should be specified here.

cfg.ica.badcomponents.flag = true;  % Enable/dis. remove artifactual comp.
cfg.ica.badcomponents.delete = {     % Indexes to remove per subject.
    []; % sub-001
%     [1,2,9,13]; % sub-002
%     [2,6,17]; % sub-003
%     [3,8,11,17]; % sub-004
%     [1]; % sub-005
%     [1,4,17]; % sub-006
%     [1,20]; % sub-007
%     [2,13]; % sub-008
%     [1,4,5]; % sub-009
%     [1,6,8,10]; % sub-010
%     [1,5]; % sub-011
%     [1,6,12]; % sub-012
%     [1,8,16]; % sub-013
%     [1,2,7,11,19]; % sub-014
%     [1,8,16,18]; % sub-015
%     []; % sub-016
%     [1,6]; % sub-017
%     [1,5,18]; % sub-018
%     [2,15]; % sub-019
%     [2,4,12]; % sub-020
%     [1,7,17]; % sub-021
%     [1,8,10,19]; % sub-022
%     []; % sub-023
%     [1]; % sub-024
%     [1,6]; % sub-025
%     [1,13,18]; % sub-026
%     [1,3,9]; % sub-027
%     [1,5,6,7]; % sub-028
%     [1,6,12]; % sub-029
%     [1,2]; % sub-030
%     [1]; % sub-031
%     [1,5,6,9]; % sub-032
%     [1,2,3,6,18]; % sub-033
%     [3,20]; % sub-034
%     [4,7,18]; % sub-035
%     [1,10]; % sub-036
%     [1,2,5]; % sub-037
%     [1,15]; % sub-038
%     [1]; % sub-039
%     [1,4,16,18]; % sub-040
%     [1,6,12]; % sub-041
    };

cfg.ica.badcomponents.save = true;              % Save ICA pruned data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.ica.badcomponents.sdir = [cfg.task '_icapruned_eeg']; % Destination folder (not change).

else
    cfg.ica.badcomponents.sdir = 'icapruned_eeg'; % Destination folder (not change).

end

%% 6. Trial rejection:
%  Select the automatic trial rejection processes to compute:

cfg.trialrej.abspect.flag = true;   % Enable/disable: Abnormal spectra.
cfg.trialrej.impdata.flag = true;   % Enable/disable: Improbable data.
cfg.trialrej.extrval.flag = true;   % Enable/disable: Extreme values.

cfg.trialrej.type = 1;              % Data type (1=electrods|0=components).
cfg.trialrej.report = true;         % Enable/disable rejection report.

% Abnormal spectra configuration:
cfg.trialrej.abspect.threshold = [-50 50;-100 25];  % Threshold lim. in dB.
cfg.trialrej.abspect.freqlimits = [0 2;20 40];      % Freq. limits in Hz.
cfg.trialrej.abspect.method = 'fft';                % Method(fft|multitap).
cfg.trialrej.abspect.eegplotreject = 0;

% Improbable data configuration:
cfg.trialrej.impdata.loclim = 6;        % Local limit(s) (in std. dev.)
cfg.trialrej.impdata.globlim = 6;       % Global limit(s) (in std. dev.)    

% Extreme values configuration:
cfg.trialrej.extrval.uplim = 150;       % Upper voltage limit.
cfg.trialrej.extrval.lolim = -150;      % Lower voltage limit

cfg.trialrej.save = true;               % Save trial pruned data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.trialrej.sdir = [cfg.task '_trialpruned_eeg']; % Destination folder (not change).

else
    cfg.trialrej.sdir = 'trialpruned_eeg'; % Destination folder (not change).

end

%% 7. Electrodes to interpole:
%  Cell array of electrodes to interpole for each subject must be specified
%  in cfg.interpole.channels.

cfg.interpole.flag = true;              % Enable/disable interpolation.
cfg.interpole.metohd = 'spherical';     % Interpolation method.

cfg.interpole.channels = {
    [1 2 3]; % sub-001
%     []; % sub-002
%     []; % sub-003
%     []; % sub-004
%     []; % sub-005
%     []; % sub-006
%     []; % sub-007
%     []; % sub-008
%     []; % sub-009
%     []; % sub-010
%     [17]; % sub-011
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
%     []; % sub-034
%     []; % sub-035
%     []; % sub-036
%     []; % sub-037
%     []; % sub-038
%     []; % sub-039
%     []; % sub-040
%     []; % sub-041
    }; % Replace with your own.

cfg.interpole.save = true;              % Save interpoled data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.interpole.sdir = [cfg.task '_interpoled_eeg']; % Destination folder (not change).

else
    cfg.interpole.sdir = 'interpoled_eeg'; % Destination folder (not change).

end

%% 8. Reference electrode and re-reference:
%  Recover the reference electrode manually and compute re-reference.

% Recover reference electrode:
cfg.refelec.flag = true;        % Enable/disable ref. electrode recovery.

cfg.refelec.chan  = 64;         % Channel number.
cfg.refelec.label = 'FCz';      % Channel label.
cfg.refelec.type  = 'REF';      % Channel type.

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
cfg.reref.flag = true;          % Enable/disable data re-reference.
cfg.reref.chan = [];            % New reference electrore - [] = average.

cfg.reref.save = true;                  % Save re-referenced data.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.reref.sdir = [cfg.task '_rereferenced_eeg']; % Destination folder (not change).

else
    cfg.reref.sdir = 'rereferenced_eeg'; % Destination folder (not change).

end

%% 9. Extract conditions:
%  Condition to extract:

cfg.conditions.flag = true;           % Enable/disable cond. extraction.
cfg.conditions.baseline.flag = true;  % Enable/disable baseline correction.
cfg.conditions.baseline.w = [-199 0]; % Baseline boundaries in milisec.

cfg.conditions.report = true;         % Enable/disable conditions report.

cfg.conditions.names{1} = 'SEL_CAT';
cfg.conditions.names{2} = 'SEL_DOG';
cfg.conditions.names{3} = 'SEL_JELLYFISH';
cfg.conditions.names{4} = 'SEL_OCTOPUS';
cfg.conditions.names{5} = 'SEL_HAMMER';
cfg.conditions.names{6} = 'SEL_DRILL';
cfg.conditions.names{7} = 'SEL_GUITAR';
cfg.conditions.names{8} = 'SEL_VIOLIN';
cfg.conditions.names{9} = 'INT_CAT';
cfg.conditions.names{10} = 'INT_DOG';
cfg.conditions.names{11} = 'INT_JELLYFISH';
cfg.conditions.names{12} = 'INT_OCTOPUS';
cfg.conditions.names{13} = 'INT_HAMMER';
cfg.conditions.names{14} = 'INT_DRILL';
cfg.conditions.names{15} = 'INT_GUITAR';
cfg.conditions.names{16} = 'INT_VIOLIN';
cfg.conditions.names{17} = 'PROBE_LOC_CAT';
cfg.conditions.names{18} = 'PROBE_LOC_DOG';
cfg.conditions.names{19} = 'PROBE_LOC_JELLYFISH';
cfg.conditions.names{20} = 'PROBE_LOC_OCTOPUS';
cfg.conditions.names{21} = 'PROBE_LOC_HAMMER';
cfg.conditions.names{22} = 'PROBE_LOC_DRILL';
cfg.conditions.names{23} = 'PROBE_LOC_GUITAR';
cfg.conditions.names{24} = 'PROBE_LOC_VIOLIN';
cfg.conditions.names{25} = 'TASK_CAT';
cfg.conditions.names{26} = 'TASK_DOG';
cfg.conditions.names{27} = 'TASK_JELLYFISH';
cfg.conditions.names{28} = 'TASK_OCTOPUS';
cfg.conditions.names{29} = 'TASK_HAMMER';
cfg.conditions.names{30} = 'TASK_DRILL';
cfg.conditions.names{31} = 'TASK_GUITAR';
cfg.conditions.names{32} = 'TASK_VIOLIN'; % Replace with your own.


cfg.conditions.triggers{1} = { % Triggers to extract for condition 1
     'Inst_1_SEL_ANIM_C_13_CAT','Inst_1_SEL_ANIM_S_13_CAT', ...
     'Inst_1_SEL_ANIM_C_14_CAT','Inst_1_SEL_ANIM_S_14_CAT', ...
     'Inst_1_SEL_ANIM_C_23_CAT','Inst_1_SEL_ANIM_S_23_CAT', ...
     'Inst_1_SEL_ANIM_C_24_CAT','Inst_1_SEL_ANIM_S_24_CAT', ...
};

cfg.conditions.triggers{2} = {
      'Inst_1_SEL_ANIM_C_13_DOG','Inst_1_SEL_ANIM_S_13_DOG', ...
      'Inst_1_SEL_ANIM_C_14_DOG','Inst_1_SEL_ANIM_S_14_DOG', ...
      'Inst_1_SEL_ANIM_C_23_DOG','Inst_1_SEL_ANIM_S_23_DOG', ...
      'Inst_1_SEL_ANIM_C_24_DOG','Inst_1_SEL_ANIM_S_24_DOG', ...
};

cfg.conditions.triggers{3} = {
      'Inst_1_SEL_ANIM_C_13_JELLYFISH','Inst_1_SEL_ANIM_S_13_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_14_JELLYFISH','Inst_1_SEL_ANIM_S_14_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_23_JELLYFISH','Inst_1_SEL_ANIM_S_23_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_24_JELLYFISH','Inst_1_SEL_ANIM_S_24_JELLYFISH', ...
};

cfg.conditions.triggers{4} = {
      'Inst_1_SEL_ANIM_C_13_OCTOPUS','Inst_1_SEL_ANIM_S_13_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_14_OCTOPUS','Inst_1_SEL_ANIM_S_14_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_23_OCTOPUS','Inst_1_SEL_ANIM_S_23_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_24_OCTOPUS','Inst_1_SEL_ANIM_S_24_OCTOPUS', ...
};

cfg.conditions.triggers{5} = {
      'Inst_1_SEL_INAN_C_13_HAMMER','Inst_1_SEL_INAN_S_13_HAMMER', ...
      'Inst_1_SEL_INAN_C_14_HAMMER','Inst_1_SEL_INAN_S_14_HAMMER', ...
      'Inst_1_SEL_INAN_C_23_HAMMER','Inst_1_SEL_INAN_S_23_HAMMER', ...
      'Inst_1_SEL_INAN_C_24_HAMMER','Inst_1_SEL_INAN_S_24_HAMMER', ...                  
};

cfg.conditions.triggers{6} = {
       'Inst_1_SEL_INAN_C_13_DRILL','Inst_1_SEL_INAN_S_13_DRILL', ...
       'Inst_1_SEL_INAN_C_14_DRILL','Inst_1_SEL_INAN_S_14_DRILL', ...
       'Inst_1_SEL_INAN_C_23_DRILL','Inst_1_SEL_INAN_S_23_DRILL', ...
       'Inst_1_SEL_INAN_C_24_DRILL','Inst_1_SEL_INAN_S_24_DRILL', ...    
};

cfg.conditions.triggers{7} = {
       'Inst_1_SEL_INAN_C_13_GUITAR','Inst_1_SEL_INAN_S_13_GUITAR', ...
       'Inst_1_SEL_INAN_C_14_GUITAR','Inst_1_SEL_INAN_S_14_GUITAR', ...
       'Inst_1_SEL_INAN_C_23_GUITAR','Inst_1_SEL_INAN_S_23_GUITAR', ...
       'Inst_1_SEL_INAN_C_24_GUITAR','Inst_1_SEL_INAN_S_24_GUITAR', ...    
};

cfg.conditions.triggers{8} = {
       'Inst_1_SEL_INAN_C_13_VIOLIN','Inst_1_SEL_INAN_S_13_VIOLIN', ...
       'Inst_1_SEL_INAN_C_14_VIOLIN','Inst_1_SEL_INAN_S_14_VIOLIN', ...
       'Inst_1_SEL_INAN_C_23_VIOLIN','Inst_1_SEL_INAN_S_23_VIOLIN', ...
       'Inst_1_SEL_INAN_C_24_VIOLIN','Inst_1_SEL_INAN_S_24_VIOLIN', ...    
};

cfg.conditions.triggers{9} = { % Triggers to extract for condition 1
     'Inst_1_INT_ANIM_C_13_CAT','Inst_1_INT_ANIM_S_13_CAT', ...
     'Inst_1_INT_ANIM_C_14_CAT','Inst_1_INT_ANIM_S_14_CAT', ...
     'Inst_1_INT_ANIM_C_23_CAT','Inst_1_INT_ANIM_S_23_CAT', ...
     'Inst_1_INT_ANIM_C_24_CAT','Inst_1_INT_ANIM_S_24_CAT', ...
};

cfg.conditions.triggers{10} = {
      'Inst_1_INT_ANIM_C_13_DOG','Inst_1_INT_ANIM_S_13_DOG', ...
      'Inst_1_INT_ANIM_C_14_DOG','Inst_1_INT_ANIM_S_14_DOG', ...
      'Inst_1_INT_ANIM_C_23_DOG','Inst_1_INT_ANIM_S_23_DOG', ...
      'Inst_1_INT_ANIM_C_24_DOG','Inst_1_INT_ANIM_S_24_DOG', ...
};

cfg.conditions.triggers{11} = {
      'Inst_1_INT_ANIM_C_13_JELLYFISH','Inst_1_INT_ANIM_S_13_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_14_JELLYFISH','Inst_1_INT_ANIM_S_14_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_23_JELLYFISH','Inst_1_INT_ANIM_S_23_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_24_JELLYFISH','Inst_1_INT_ANIM_S_24_JELLYFISH', ...
};

cfg.conditions.triggers{12} = {
      'Inst_1_INT_ANIM_C_13_OCTOPUS','Inst_1_INT_ANIM_S_13_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_14_OCTOPUS','Inst_1_INT_ANIM_S_14_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_23_OCTOPUS','Inst_1_INT_ANIM_S_23_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_24_OCTOPUS','Inst_1_INT_ANIM_S_24_OCTOPUS', ...
};

cfg.conditions.triggers{13} = {
      'Inst_1_INT_INAN_C_13_HAMMER','Inst_1_INT_INAN_S_13_HAMMER', ...
      'Inst_1_INT_INAN_C_14_HAMMER','Inst_1_INT_INAN_S_14_HAMMER', ...
      'Inst_1_INT_INAN_C_23_HAMMER','Inst_1_INT_INAN_S_23_HAMMER', ...
      'Inst_1_INT_INAN_C_24_HAMMER','Inst_1_INT_INAN_S_24_HAMMER', ...                  
};

cfg.conditions.triggers{14} = {
       'Inst_1_INT_INAN_C_13_DRILL','Inst_1_INT_INAN_S_13_DRILL', ...
       'Inst_1_INT_INAN_C_14_DRILL','Inst_1_INT_INAN_S_14_DRILL', ...
       'Inst_1_INT_INAN_C_23_DRILL','Inst_1_INT_INAN_S_23_DRILL', ...
       'Inst_1_INT_INAN_C_24_DRILL','Inst_1_INT_INAN_S_24_DRILL', ...    
};

cfg.conditions.triggers{15} = {
       'Inst_1_INT_INAN_C_13_GUITAR','Inst_1_INT_INAN_S_13_GUITAR', ...
       'Inst_1_INT_INAN_C_14_GUITAR','Inst_1_INT_INAN_S_14_GUITAR', ...
       'Inst_1_INT_INAN_C_23_GUITAR','Inst_1_INT_INAN_S_23_GUITAR', ...
       'Inst_1_INT_INAN_C_24_GUITAR','Inst_1_INT_INAN_S_24_GUITAR', ...    
};

cfg.conditions.triggers{16} = {
       'Inst_1_INT_INAN_C_13_VIOLIN','Inst_1_INT_INAN_S_13_VIOLIN', ...
       'Inst_1_INT_INAN_C_14_VIOLIN','Inst_1_INT_INAN_S_14_VIOLIN', ...
       'Inst_1_INT_INAN_C_23_VIOLIN','Inst_1_INT_INAN_S_23_VIOLIN', ...
       'Inst_1_INT_INAN_C_24_VIOLIN','Inst_1_INT_INAN_S_24_VIOLIN', ...    
};

cfg.conditions.triggers{17} = { % Triggers to extract for condition 17
    'LOC_PROBE_mammal_0_1'};
    
cfg.conditions.triggers{18} = {    
    'LOC_PROBE_mammal_0_2'};

cfg.conditions.triggers{19} = {
    'LOC_PROBE_sea_0_3'};

 cfg.conditions.triggers{20} = {   
    'LOC_PROBE_sea_0_4'};

cfg.conditions.triggers{21} = {
    'LOC_PROBE_tool_0_5'};
    
cfg.conditions.triggers{22} = {
    'LOC_PROBE_tool_0_6'};

cfg.conditions.triggers{23} = { 
    'LOC_PROBE_instr_0_7'};
    
cfg.conditions.triggers{24} = {
    'LOC_PROBE_instr_0_8'};

cfg.conditions.triggers{25} = {
     'Inst_1_SEL_ANIM_C_13_CAT','Inst_1_SEL_ANIM_S_13_CAT', ...
     'Inst_1_SEL_ANIM_C_14_CAT','Inst_1_SEL_ANIM_S_14_CAT', ...
     'Inst_1_SEL_ANIM_C_23_CAT','Inst_1_SEL_ANIM_S_23_CAT', ...
     'Inst_1_SEL_ANIM_C_24_CAT','Inst_1_SEL_ANIM_S_24_CAT', ...
     'Inst_1_INT_ANIM_C_13_CAT','Inst_1_INT_ANIM_S_13_CAT', ...
     'Inst_1_INT_ANIM_C_14_CAT','Inst_1_INT_ANIM_S_14_CAT', ...
     'Inst_1_INT_ANIM_C_23_CAT','Inst_1_INT_ANIM_S_23_CAT', ...
     'Inst_1_INT_ANIM_C_24_CAT','Inst_1_INT_ANIM_S_24_CAT', ...
};

cfg.conditions.triggers{26} = {
      'Inst_1_SEL_ANIM_C_13_DOG','Inst_1_SEL_ANIM_S_13_DOG', ...
      'Inst_1_SEL_ANIM_C_14_DOG','Inst_1_SEL_ANIM_S_14_DOG', ...
      'Inst_1_SEL_ANIM_C_23_DOG','Inst_1_SEL_ANIM_S_23_DOG', ...
      'Inst_1_SEL_ANIM_C_24_DOG','Inst_1_SEL_ANIM_S_24_DOG', ...
      'Inst_1_INT_ANIM_C_13_DOG','Inst_1_INT_ANIM_S_13_DOG', ...
      'Inst_1_INT_ANIM_C_14_DOG','Inst_1_INT_ANIM_S_14_DOG', ...
      'Inst_1_INT_ANIM_C_23_DOG','Inst_1_INT_ANIM_S_23_DOG', ...
      'Inst_1_INT_ANIM_C_24_DOG','Inst_1_INT_ANIM_S_24_DOG', ...
};

cfg.conditions.triggers{27} = {
      'Inst_1_SEL_ANIM_C_13_JELLYFISH','Inst_1_SEL_ANIM_S_13_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_14_JELLYFISH','Inst_1_SEL_ANIM_S_14_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_23_JELLYFISH','Inst_1_SEL_ANIM_S_23_JELLYFISH', ...
      'Inst_1_SEL_ANIM_C_24_JELLYFISH','Inst_1_SEL_ANIM_S_24_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_13_JELLYFISH','Inst_1_INT_ANIM_S_13_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_14_JELLYFISH','Inst_1_INT_ANIM_S_14_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_23_JELLYFISH','Inst_1_INT_ANIM_S_23_JELLYFISH', ...
      'Inst_1_INT_ANIM_C_24_JELLYFISH','Inst_1_INT_ANIM_S_24_JELLYFISH', ...
};

cfg.conditions.triggers{28} = {
      'Inst_1_SEL_ANIM_C_13_OCTOPUS','Inst_1_SEL_ANIM_S_13_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_14_OCTOPUS','Inst_1_SEL_ANIM_S_14_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_23_OCTOPUS','Inst_1_SEL_ANIM_S_23_OCTOPUS', ...
      'Inst_1_SEL_ANIM_C_24_OCTOPUS','Inst_1_SEL_ANIM_S_24_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_13_OCTOPUS','Inst_1_INT_ANIM_S_13_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_14_OCTOPUS','Inst_1_INT_ANIM_S_14_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_23_OCTOPUS','Inst_1_INT_ANIM_S_23_OCTOPUS', ...
      'Inst_1_INT_ANIM_C_24_OCTOPUS','Inst_1_INT_ANIM_S_24_OCTOPUS', ...
};

cfg.conditions.triggers{29} = {
      'Inst_1_SEL_INAN_C_13_HAMMER','Inst_1_SEL_INAN_S_13_HAMMER', ...
      'Inst_1_SEL_INAN_C_14_HAMMER','Inst_1_SEL_INAN_S_14_HAMMER', ...
      'Inst_1_SEL_INAN_C_23_HAMMER','Inst_1_SEL_INAN_S_23_HAMMER', ...
      'Inst_1_SEL_INAN_C_24_HAMMER','Inst_1_SEL_INAN_S_24_HAMMER', ...                  
      'Inst_1_INT_INAN_C_13_HAMMER','Inst_1_INT_INAN_S_13_HAMMER', ...
      'Inst_1_INT_INAN_C_14_HAMMER','Inst_1_INT_INAN_S_14_HAMMER', ...
      'Inst_1_INT_INAN_C_23_HAMMER','Inst_1_INT_INAN_S_23_HAMMER', ...
      'Inst_1_INT_INAN_C_24_HAMMER','Inst_1_INT_INAN_S_24_HAMMER', ...                  
};

cfg.conditions.triggers{30} = {
       'Inst_1_SEL_INAN_C_13_DRILL','Inst_1_SEL_INAN_S_13_DRILL', ...
       'Inst_1_SEL_INAN_C_14_DRILL','Inst_1_SEL_INAN_S_14_DRILL', ...
       'Inst_1_SEL_INAN_C_23_DRILL','Inst_1_SEL_INAN_S_23_DRILL', ...
       'Inst_1_SEL_INAN_C_24_DRILL','Inst_1_SEL_INAN_S_24_DRILL', ...    
       'Inst_1_INT_INAN_C_13_DRILL','Inst_1_INT_INAN_S_13_DRILL', ...
       'Inst_1_INT_INAN_C_14_DRILL','Inst_1_INT_INAN_S_14_DRILL', ...
       'Inst_1_INT_INAN_C_23_DRILL','Inst_1_INT_INAN_S_23_DRILL', ...
       'Inst_1_INT_INAN_C_24_DRILL','Inst_1_INT_INAN_S_24_DRILL', ...    
};

cfg.conditions.triggers{31} = {
       'Inst_1_SEL_INAN_C_13_GUITAR','Inst_1_SEL_INAN_S_13_GUITAR', ...
       'Inst_1_SEL_INAN_C_14_GUITAR','Inst_1_SEL_INAN_S_14_GUITAR', ...
       'Inst_1_SEL_INAN_C_23_GUITAR','Inst_1_SEL_INAN_S_23_GUITAR', ...
       'Inst_1_SEL_INAN_C_24_GUITAR','Inst_1_SEL_INAN_S_24_GUITAR', ...    
       'Inst_1_INT_INAN_C_13_GUITAR','Inst_1_INT_INAN_S_13_GUITAR', ...
       'Inst_1_INT_INAN_C_14_GUITAR','Inst_1_INT_INAN_S_14_GUITAR', ...
       'Inst_1_INT_INAN_C_23_GUITAR','Inst_1_INT_INAN_S_23_GUITAR', ...
       'Inst_1_INT_INAN_C_24_GUITAR','Inst_1_INT_INAN_S_24_GUITAR', ...    
};

cfg.conditions.triggers{32} = {
       'Inst_1_SEL_INAN_C_13_VIOLIN','Inst_1_SEL_INAN_S_13_VIOLIN', ...
       'Inst_1_SEL_INAN_C_14_VIOLIN','Inst_1_SEL_INAN_S_14_VIOLIN', ...
       'Inst_1_SEL_INAN_C_23_VIOLIN','Inst_1_SEL_INAN_S_23_VIOLIN', ...
       'Inst_1_SEL_INAN_C_24_VIOLIN','Inst_1_SEL_INAN_S_24_VIOLIN', ...    
       'Inst_1_INT_INAN_C_13_VIOLIN','Inst_1_INT_INAN_S_13_VIOLIN', ...
       'Inst_1_INT_INAN_C_14_VIOLIN','Inst_1_INT_INAN_S_14_VIOLIN', ...
       'Inst_1_INT_INAN_C_23_VIOLIN','Inst_1_INT_INAN_S_23_VIOLIN', ...
       'Inst_1_INT_INAN_C_24_VIOLIN','Inst_1_INT_INAN_S_24_VIOLIN', ...    
}; % Replace with your own.

cfg.conditions.save = true;             % Save extracted conditions.
if (strcmp(cfg.datapath, cfg.datapathraw))
    cfg.conditions.sdir = [cfg.task '_conditions_eeg']; % Destination folder (not change).

else
    cfg.conditions.sdir = 'conditions_eeg'; % Destination folder (not change).

end

%% Other parameters:

cfg.rename = true;          % Rename events.
cfg.match  = true;
cfg.saveformat = 'both';     % Outpud data format: 'mat'-'set'-'both'


%% Experimental parameters
cfg.exp.nblocks = 24; % Replace with your own.
