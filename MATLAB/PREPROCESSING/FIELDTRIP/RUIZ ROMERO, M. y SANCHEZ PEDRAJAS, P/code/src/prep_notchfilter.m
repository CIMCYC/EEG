function data = prep_notchfilter(conf,data)
%% PREP_NOTCHFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function returns the notch-filtered version of the input dataset.
 
% Notch filter:
    
fprintf('\n<strong> > Applying notch filter...</strong>\n\n');

cfg.dftfreq = conf.dftfreq;
cfg.bpfilter = conf.bpfilter; 
cfg.bpfreq = conf.bpfreq;

data = ft_preprocessing (cfg, data);

% Save data if needed:
if conf.notchfilter.save

   save_subject_data(conf,data,conf.notchfilter.sdir);
   
end

end

