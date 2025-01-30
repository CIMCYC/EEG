function data = prep_epochdata(conf,data)
%% PREP_EPOCHDATA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function splits the data in epochs if needed.

% Epoch data if needed:

fprintf('\n<strong> > Epoching data...</strong>\n\n');

cd(data.subject.dir);
cfg.dataset  = [data.subject.filename conf.extension];
cfg.trialfun = conf.trialfun;
cfg.trialdef.eventtype  = conf.trialdef.eventtype;
cfg.trialdef.eventvalue = conf.trialdef.eventvalue;
cfg.trialdef.prestim    = conf.trialdef.prestim;
cfg.trialdef.poststim   = conf.trialdef.poststim;   

cfg_events   = ft_definetrial(cfg);

data = ft_preprocessing (cfg_events);  

% Save data if needed:
if conf.epochs.save

    save_subject_data(conf,data,conf.epochs.sdir);

end

end

