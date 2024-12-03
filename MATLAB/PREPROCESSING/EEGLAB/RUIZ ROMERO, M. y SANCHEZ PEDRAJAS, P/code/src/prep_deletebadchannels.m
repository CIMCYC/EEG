function data = prep_deletebadchannels(cfg,data)
%% PREP_DELETEBADCHANNELSDATA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function removes bad channels (eg. EOG channels) if needed.

if cfg.deletechannels.flag
    
    fprintf('\n<strong> > Deleting channels...</strong>\n\n');

    total_channels = (1:length(data.chanlocs));
    subject_idx = str2double(data.subject.id(end-2:end));
    deletebadchannels = cfg.deletechannels.names{subject_idx};
    channels = setdiff(total_channels, deletebadchannels);

    data = pop_select(data, 'channel', channels);
    
end

% Save data if needed:
if cfg.deletechannels.save
    save_subject_data(cfg,data,cfg.deletechannels.sdir);
end

end
