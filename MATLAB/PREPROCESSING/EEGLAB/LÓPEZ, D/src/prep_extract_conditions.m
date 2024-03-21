function report = prep_extract_conditions(cfg,data)
%% PREP_EXTRACT_CONDITIONS
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes to export to BIDS format made by:
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% -------------------------------------------------------------------------
% Note:
%  Posible warning if your are re-epoching:
%  Warning: event 308 out of data boundary
%  Explanation: https://sccn.ucsd.edu/pipermail/eeglablist/2008/002092.html

if cfg.conditions.flag
    for i = 1 : length(cfg.conditions.names)
        
        fprintf(['\n<strong> > Extracting trials for condition :' ...
            cfg.conditions.names{i} '</strong>\n\n']);
        
        try
            % Extract epochs
            [data_,idx{i}] = pop_epoch(data,cfg.conditions.triggers{i},...
                cfg.epochs.bounds);
            data_.setname = cfg.conditions.names{i};
            
            report(1,i) = length(idx{i});
            
            % Baseline correction
            if cfg.conditions.baseline.flag
                data_ = pop_rmbase(data_,cfg.conditions.baseline.w);
            end
            
            % Save condition data:
            if cfg.conditions.save
                sdir = [cfg.datapath filesep 'derivatives' filesep  ...
                    data.subject.filename filesep 'conditions_eeg'];
                fname = [data_.subject.filename '_' cfg.conditions.names{i}];
                mkdir(sdir);
                if strcmp(cfg.saveformat,'set') || strcmp(cfg.saveformat,'both')
                    data_ = pop_saveset(data_, 'filename',fname,'filepath', sdir);                    
                end
                if strcmp(cfg.saveformat,'mat') || strcmp(cfg.saveformat,'both')    
                    save([sdir filesep fname],'data_');
                end
            end
            
        catch
            warning(['No epochs found for ' cfg.conditions.names{i}...
                ' condition.'])
            
            report(1,i) = 0; 
        end
    end
end

end

