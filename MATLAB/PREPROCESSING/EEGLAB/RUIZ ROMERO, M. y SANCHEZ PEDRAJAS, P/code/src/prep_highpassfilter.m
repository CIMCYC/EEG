function data = prep_highpassfilter(cfg,data)
%% PREP_HIGHFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  This function returns the high-filtered version of the input dataset.

% High-pass filter:
if cfg.filter.highpass.flag
    fprintf('\n<strong> > Applying high-pass filter...</strong>\n\n');
    data = pop_eegfiltnew(data,cfg.filter.highpass.fcutoff,[],...
           cfg.filter.highpass.order,0,[],cfg.filter.plotfreqresp);
end

% Save data if needed:
if cfg.highpassfilter.save
    save_subject_data(cfg,data,cfg.highpassfilter.sdir);
end

end

