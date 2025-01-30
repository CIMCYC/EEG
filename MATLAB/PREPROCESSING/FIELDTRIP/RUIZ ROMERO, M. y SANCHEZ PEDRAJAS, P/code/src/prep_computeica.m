function [badicas,comp] = prep_computeica(conf,data)
%% PREP_COMPUTEICA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  Compute ICA decomposition if needed:

fprintf('\n<strong> > Computing ICA decomposition...</strong>\n\n');

cfg.method = conf.method.ica;
cfg.numcomponent = conf.numcomponent;                                         % indicamos el numero de componentes que queremos
cfg.channel = conf.channel.ica;

comp = ft_componentanalysis(cfg, data);         % descomposición ICA

% Compute ICA:

cfg = [];
cfg.channel = conf.channel.ica;

data = ft_preprocessing(cfg.channel,data);

% Detect:

cfg = [];
cfg.toilim = conf.toilim.ica;
cfg.ylim = conf.ylim.ica;

badicas    = detect_badicas (cfg, data, comp);        % para visualizar los ICs malos (funciona como detect_badtrials)

% Save data if needed:
    
if conf.ica.save

    save_subject_data(conf,data,conf.ica.sdir);

end

end
