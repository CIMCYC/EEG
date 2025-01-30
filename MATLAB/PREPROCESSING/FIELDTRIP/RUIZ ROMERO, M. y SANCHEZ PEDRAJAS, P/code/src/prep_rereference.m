function data = prep_rereference(conf,data)
%% PREP_REREFERENCE
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%

% Baseline correction
fprintf('\n<strong> > Recovering reference electrode...</strong>\n\n');
cfg.demean = conf.demean;
cfg.baselinewindow = conf.baselinewindow;

data = ft_preprocessing(cfg,data);

% Rereferencing
cfg.reref = conf.reref;
cfg.refchannel = conf.refchannel;
cfg.refmethod = conf.refmethod;

data = ft_preprocessing(cfg,data);

% Save data if needed:
if conf.rereference.save

    save_subject_data(conf,data,conf.rereference.sdir);

end

end

