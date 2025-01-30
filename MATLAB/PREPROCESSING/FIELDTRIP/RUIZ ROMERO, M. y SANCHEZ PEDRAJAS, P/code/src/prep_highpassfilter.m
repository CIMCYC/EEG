function data = prep_highpassfilter(conf,data)
%% PREP_HIGHFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function returns the high-filtered version of the input dataset.

% High-pass filter:
fprintf('\n<strong> > Applying high-pass filter...</strong>\n\n');

cfg.hpfilter  = conf.hpfilter;      % 'no' or 'yes'  highpass filter (default = 'no')
cfg.hpfreq  = conf.hpfreq;          % High pass frequency in Hz
cfg.hpfiltord  = conf.hpfiltord;    % High pass order

data = ft_preprocessing (cfg, data);

% Save data if needed:
if conf.highpassfilter.save

    save_subject_data(conf,data,conf.highpassfilter.sdir);

end

end

