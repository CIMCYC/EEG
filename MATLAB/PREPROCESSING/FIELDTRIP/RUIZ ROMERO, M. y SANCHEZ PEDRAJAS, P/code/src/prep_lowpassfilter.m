function data = prep_lowpassfilter(conf,data)
%% PREP_LOWFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  This function returns the low-filtered version of the input dataset.

% Low-pass filter:
fprintf('\n<strong> > Applying low-pass filter...</strong>\n\n');

cfg.lpfilter  = conf.lpfilter;   % 'no' or 'yes'  lowpass filter (default = 'no')
cfg.lpfreq    = conf.lpfreq;    
data = ft_preprocessing (cfg, data);

% Save data if needed:
if conf.lowpassfilter.save

   save_subject_data(conf,data,conf.lowpassfilter.sdir);

end

end

