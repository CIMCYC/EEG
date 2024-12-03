function data = prep_lowpassfilter(cfg,data)
%% PREP_LOWFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  This function returns the low-filtered version of the input dataset.

% Low-pass filter:
if cfg.filter.lowpass.flag
    fprintf('\n<strong> > Applying low-pass filter...</strong>\n\n');
    data = pop_eegfiltnew(data,[],cfg.filter.lowpass.fcutoff,...
         cfg.filter.lowpass.order,0,[],cfg.filter.plotfreqresp);
end

% Save data if needed:

if cfg.lowpassfilter.save
    save_subject_data(cfg,data,cfg.lowpassfilter.sdir);
end

end

