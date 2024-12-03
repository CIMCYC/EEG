function prep_computeica(cfg,data)
%% PREP_COMPUTEICA
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  Compute ICA decomposition if needed:

if cfg.ica.flag

    % Exclude bad channels:
    total_channels = (1 : length(data.chanlocs));
    subject_idx = str2double(data.subject.id(end-2:end));
    ignoredchannels = cfg.ignoredchannels{subject_idx};
    channels = setdiff(total_channels, ignoredchannels);
    
    fprintf('\n<strong> > Computing ICA decomposition...</strong>\n\n');
    
    % Compute ICA:
    data = pop_runica(data,'icatype',cfg.ica.method,...
        'extended',cfg.ica.extended,'chanind',channels);
    
end

% Save data if needed:
if cfg.ica.save
    save_subject_data(cfg,data,cfg.ica.sdir);
end

end

