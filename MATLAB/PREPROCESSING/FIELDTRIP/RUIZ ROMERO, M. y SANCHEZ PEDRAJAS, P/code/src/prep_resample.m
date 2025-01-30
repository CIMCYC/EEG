function data = prep_resample(conf,data)
%% PREP_RESAMPLE
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function returns and saves the resampled data if needed.

fprintf('\n<strong> > Resampling data...</strong>\n\n');
cfg.resamplefs = conf.resamplefs;

data = ft_resampledata(cfg, data);

% Save data if needed:
if conf.resample.save

    save_subject_data(conf,data,conf.resample.sdir);

end

end

