% -----------------
% Tutorial HEP Donostia 2023
% Luis Ciria
% lciria@ugr.es
% ------------------------------------------------------------------------------------------
% EEG preprocessing for HEP (use your own steps - no particular specifications apart from CFA)
% For example: filtering ---> bad channels removal ---> ICA ---> bad channels interpolation ---> bad trials rejection --->
%baseline correction ---> re-referencing
% ------------------------------------------------------------------------------------------
clear
clc
close all

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data';             % Data location
cd(datapath)                                                      % Open data folder

% load the raw EEG file
load('ENT_1_rawEEG_newEvents.mat'); % (use supporting file if necessary)

% basic EEG preprocessing for fast plot
cfg           = [];
channs        = data.cfg.channel;
channs(end)   = []; %remove ecg channels for preprocessing
cfg.channel   = channs;
cfg.dftfreq   = [50 100 150];   %line noise frequencies in Hz for DFT filter (similar to notch filter)
cfg.hpfilter  = 'yes';
cfg.hpfilter  = 0.1;
cfg.lpfilter  = 'yes';
cfg.lpfreq    = 40;            % low pass frequency
data_filt     = ft_preprocessing (cfg, data);

% Rereferencing
cfg            = [];
cfg.demean     = 'yes';
cfg.reref      = 'yes';
cfg.refchannel = 'all'; % average reference
data_filt_ref  = ft_preprocessing(cfg,data_filt);

% Baseline correction
cfg                =[];
cfg.demean         = 'yes';
cfg.baselinewindow = [-0.2 0];
data_filt_reref_bl = ft_preprocessing (cfg, data_filt_ref);

% %% Save clean data
% cd ([datapath 'Dat_EEG\' suj])
% save cleandata   cleandata

%% Compute ERPs (HEP)
cfg     = [];
hepdata = ft_timelockanalysis(cfg, data_filt_reref_bl);

%% Fast preprocessing for plotting ECG channel
cfg           = [];
cfg.channel   = 'EXG1';
cfg.hpfilter  = 'yes';
cfg.hpfilter  = 0.5;    % high pass frequency
cfg.lpfilter  = 'yes';
cfg.lpfreq    = 50;     % low pass frequency
data_ecg_filt = ft_preprocessing (cfg, data);

% Baseline correction
cfg                =[];
cfg.demean         = 'yes';
cfg.baselinewindow = [-0.2 0];
data_ecg_filt_bl = ft_preprocessing (cfg, data_ecg_filt);

cfg     = [];
ecg_erp = ft_timelockanalysis(cfg, data_ecg_filt_bl); %Compute ERPs for ECG channel

%% plot HEP
h                 = figure;
cfg               = [];
cfg.fontsize      = 5;
cfg.layout        = 'biosemi64.lay';
cfg.xlim          = [-0.1 1];
cfg.ylim          = [-3 3];
cfg.channel       = {'FC5','FC3','FC1','FC6','FC4','FC2','FCz'};
cfg.showlocations = 'yes';
cfg.layouttopo    = 'biosemi64.lay';
cfg.figure        = h;

subplot(2,1,1) % create a figure with two sections (in vertical)
ft_singleplotER(cfg, hepdata);
ylabel('Volatage (?V)')
%xline(0,'--');
title('HEP','FontSize',12)

cfg           = [];
cfg.fontsize  = 5;
cfg.layout    = 'biosemi64.lay';
cfg.xlim      = [-0.1 1];
cfg.channel   = {'EXG1'};
cfg.linecolor = 'r';
cfg.figure    = h;

subplot(2,1,2) % create a figure with two sections (in vertical)
ft_singleplotER(cfg, ecg_erp);
ylabel('Volatage (?V)')
%xline(0,'--');
xlabel ('Time (seconds)')
title('ECG','FontSize',12)

%% Plot HEP in each electrode
cfg = [];
cfg.layout   = 'biosemi64.lay';
figure; ft_multiplotER(cfg, hepdata);
title('ECG','FontSize',12)


%% ------------------------------------------------------------------------------------------
% Visualization of the component time courses (after ICA) to remove cardiac field artifact (CFA)
% ------------------------------
clear
clc
close all

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data/CFA';             % Data location
cd(datapath)                                                      % Open data folder

% load the weighted (voltage + components) EEG file
load('SED_23.mat');

% Prepare layout which needs to be rotated because of bug
cfg            = [];
cfg.layout     = ft_prepare_layout(cfg, data); % specify the layout file that should be used for plotting
theta          = -90; %rotate by 90 degrees counterclockwise
R              = [cosd(theta) -sind(theta); sind(theta) cosd(theta)]; %rotation matrix
cfg.layout.pos = cfg.layout.pos*R; %rotate layout
cfg.channel    = 5:12; % components to be plotted
cfg.viewmode   = 'component';
data           = ft_databrowser(cfg, data); % Visualise components
