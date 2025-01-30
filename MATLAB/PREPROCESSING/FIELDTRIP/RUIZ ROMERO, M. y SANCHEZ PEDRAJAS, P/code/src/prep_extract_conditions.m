function report = prep_extract_conditions(cfg,data)
%% PREP_EXTRACT_CONDITIONS
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%  Note:
%  Posible warning if your are re-epoching:
%  Warning: event 308 out of data boundary
%  Explanation: https://sccn.ucsd.edu/pipermail/eeglablist/2008/002092.html

cfg.conditions.names{1} = conf.conditions.names{1};
cfg.conditions.names{2} = conf.conditions.names{2};
...
cfg.conditions.triggers{1} = conf.conditions.triggers{1};
...
% cfg.epochs.bounds

%
if conf.conditions.flag
    for i = 1 : length(cfg.conditions.names)
        
        fprintf(['\n<strong> > Extracting trials for condition :' ...
            cfg.conditions.names{i} '</strong>\n\n']);
        
        try
            % Extract epochs
%             [data_,idx{i}] = pop_epoch(data,cfg.conditions.triggers{i},...
%                 cfg.epochs.bounds); % change to fieltrip
%             data_.setname = cfg.conditions.names{i};
            
            report(1,i) = length(idx{i});
            
            % Save condition data:
            if conf.conditions.save
                save_dir = [conf.conditions.sdir filesep ...
                    cfg.conditions.names{i}];
                save_subject_data(conf,data_,save_dir);
            end
            
        catch
            warning(['No epochs found for ' cfg.conditions.names{i}...
                ' condition.'])
            
            report(1,i) = 0; 
        end
    end
end

end

