% -----------------
% Tutorial HEP Donostia 2023
% Luis Ciria
% lciria@ugr.es
% ------------------------------------------------------------------------------------------
% HEP stats - Cluster-based non-parametric permutation tests
% IMPORTANT: How NOT to interpret results from a cluster-based permutation (check this link: https://www.fieldtriptoolbox.org/faq/how_not_to_interpret_results_from_a_cluster-based_permutation_test/#how-not-to-interpret-results-from-a-cluster-based-permutation-test
% ------------------------------------------------------------------------------------------
clear
clc
close all

datapath = '/Users/luisciria/Desktop/CuttingEEG-Donostia HEP Tutorial/heplab/data/clean'; % Data location
cd(datapath)                                                      % Open data folder

% load HEP data 
load('Data_active_group_timelocked.mat');   % Active participants   - (use supporting file if necessary)
load('Data_inactive_group_timelocked.mat'); % Inactive participants - (use supporting file if necessary)

% Define study design (between groups for this "experiment". 10 participants per group)
participants_g1 = 10; 
participants_g2 = 10;
design = [ones(1,participants_g1) ones(1,participants_g2)*2]; % create the stats design

%% configure analysis's parameters
cfg                     = [];
cfg.design              = design;
cfg.channel             = data_active{1}.cfg.channel(1:64); % chanlocs(elecs); remove the ECG channel for the stats
cfg.latency             = 'all'; % 'all';
cfg.method              = 'montecarlo'; % Monte Carlo Method for significance prob.
cfg.statistic           = 'ft_statfun_indepsamplesT';
cfg.correctm            = 'cluster';
cfg.clusterstatistic    = 'maxsum'; 
cfg.minnbchan           = 2;
cfg.numrandomization    = 4000;
cfg.tail                = 0; % -1, 1 or 0 (default = 0); one-sided or two-sided test
cfg.clustertail         = 0;
cfg.alpha               = 0.025;  
cfg.ivar                = 1;
cfg.elecfile            = 'biosemi64.lay';
cfg.neighbours          = 'biosemi64_neighb.mat';

% run analysis
[stat]                  = ft_timelockstatistics(cfg, data_active{:}, data_inactive{:});

save (['HEP_stats_' date '.mat'],'stat'); %save analysis

%% check statistically significat clusters (use supporting file if necessary [HEP_stats.mat])
% extract positive clusters
if isfield(stat,'posclusters') % check if there are positive clusters (regardless of their significance)
    sig_clus=find([stat.posclusters(:).prob] < stat.cfg.alpha);  % check how many clusters were "statiscally significant"
    if isempty(sig_clus)
    else
        for c=1:size(sig_clus,2) % extract channels and time for each cluster
            cluster            = ismember(stat.posclusterslabelmat, sig_clus(c)); % create a matrix (channels x time) with cluster parameters
            [chan,time]        = find(cluster == 1);
            chan_pos{c}        = unique(chan); % cluster's channels (numbers)
            chan_pos_labels{c} = stat.label(unique(chan)); % cluster's channels (labels)
            time_pos {c}       = unique(time); % cluster's time points
        end
    end
else
end

% extract negative clusters
if isfield(stat,'negclusters')
    sig_clus=find([stat.negclusters(:).prob] < stat.cfg.alpha);
    if isempty(sig_clus)
    else
        for c=1:size(sig_clus,2)
            cluster            = ismember(stat.negclusterslabelmat, sig_clus(c));
            [chan,time]        = find(cluster == 1);
            chan_neg{c}        = unique(chan);
            chan_neg_labels{c} = stat.label(unique(chan));
            time_neg {c}       = unique(time);
        end
    end
else
end
  
%% Cluster plot
% load grand averages
load hep_active     % (use supporting file if necessary)
load hep_inactive   % (use supporting file if necessary)

%% Plot HEP grand averages - Groups
cluster_valence    = 'positive'; % cluster to plot ('positive' or 'negative') 
cluster_number     = 1; % cluster to plot (it is possible to have serveral ('statistically significant') clusters)

if cluster_valence == 'negative'
    chan_labels  = chan_neg_labels {1,cluster_number};
    time_cluster = time_neg {1,cluster_number};
elseif cluster_valence == 'positive'
    chan_labels  = chan_pos_labels {1,cluster_number};
    time_cluster = time_pos {1,cluster_number};
else
end

h                 = figure;
cfg               = [];
cfg.fontsize      = 5;
cfg.layout        = 'biosemi64.lay';
cfg.xlim          = [-0.1 1];
cfg.ylim          = [-1.5 1.5];
cfg.channel       = chan_labels;
cfg.showlocations = 'yes';
cfg.layouttopo    = 'biosemi64.lay';
cfg.figure        = h;

subplot(2,1,1) % create a figure with two sections (in vertical)
ft_singleplotER(cfg,hep_active,hep_inactive);
ylabel('Volatage (?V)')
%xline(0,'--');
hold on
gr = [0.5 0.5 0.5];
fillhandle = fill ([time_cluster(1)/1000 time_cluster(end)/1000 time_cluster(end)/1000 time_cluster(1)/1000],[-4 -4 8 8], gr);
set(fillhandle,'EdgeColor','none','FaceAlpha',0.3,'EdgeAlpha',0);
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

subplot(2,1,2)
ft_singleplotER(cfg,hep_active,hep_inactive);
xlabel('Time (seconds)')
ylabel('Volatage (?V)')
%xline(0,'--');
legend('Active group','Inactive group')
title('ECG','FontSize',12)

