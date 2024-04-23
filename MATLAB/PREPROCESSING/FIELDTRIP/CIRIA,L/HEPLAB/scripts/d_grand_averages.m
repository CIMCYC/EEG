% -----------------
% Tutorial HEP Donostia 2023
% Luis Ciria
% lciria@ugr.es
% ------------------------------------------------------------------------------------------
% HEP Grand averages + Plot
% ------------------------------------------------------------------------------------------
clear
clc
close all

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data/clean'; % Data location
cd(datapath)                                                      % Open data folder

datasets = dir('*.mat*'); %List of participants (***.mat) in the folder: AC = Active participants; IN = Inactive participants

%% Load each participant and computes single-subject ERP average
count_active   = 1; %Counters to arrange the data in variables according to the group
count_inactive = 1;
for i=1:length(datasets)
    
    load(datasets(i).name);  % load the EEG file
    cfg         = [];
    cfg.dataset = datasets(i).name;
    cfg.demean          = 'yes';
    cfg.baselinewindow  = [-0.2 0];
    data = ft_preprocessing(cfg,data);
    %save (datasets(i).name,'data');
    
    hepdata     = ft_timelockanalysis(cfg, data); % compute single-subject ERP average
    
    % Arrange the data in variables according to the group
    group = datasets(i).name(1:2); %takes the first 2 letters from the name to identify the group
    if group == 'AC' %ACTIVE
        data_active{count_active}     = hepdata;
        count_active                  = count_active+1;
    elseif group == 'IN' %INACTIVE
        data_inactive{count_inactive} = hepdata;
        count_inactive                = count_inactive+1;
    else
    end
end

% save group data
save Data_active_group_timelocked data_active
save Data_inactive_group_timelocked data_inactive

%% ERPs grand averages - Groups
cfg           = [];
cfg.channel   = 'all';
cfg.latency   = 'all';
cfg.parameter = 'avg';
hep_inactive  = ft_timelockgrandaverage(cfg, data_inactive{:});
hep_active    = ft_timelockgrandaverage(cfg, data_active{:});
 
save hep_active hep_active
save hep_inactive hep_inactive

%% Plot HEP grand averages - Groups
h                 = figure;
cfg               = [];
cfg.fontsize      = 5;
cfg.layout        = 'biosemi64.lay';
cfg.xlim          = [-0.1 1];
cfg.ylim          = [-1.5 1.5];
cfg.channel       = {'FC5','FC3','FC1','FC6','FC4','FC2','FCz'};
cfg.showlocations = 'yes';
cfg.layouttopo    = 'biosemi64.lay';
cfg.figure        = h;

subplot(2,1,1) % create a figure with two sections (in vertical)
ft_singleplotER(cfg,hep_active,hep_inactive);
ylabel('Volatage (?V)')
xlabel('Time (seconds)')
%xline(0,'--');
legend('Active group','Inactive group')
title('HEP','FontSize',12)

% Plot ECG grand averages - Groups
cfg = [];
cfg.fontsize = 5;
cfg.layout   = 'biosemi64.lay';
cfg.xlim     = [-0.1 1];
cfg.ylim     = [-300 600];
cfg.channel  = {'ecg'};
cfg.figure   = h;
title('HEP','FontSize',12)
subplot(2,1,2)
ft_singleplotER(cfg,hep_active,hep_inactive);
xlabel('Time (seconds)')
ylabel('Volatage (?V)')
%xline(0,'--');
legend('Active group','Inactive group')
title('ECG','FontSize',12)
