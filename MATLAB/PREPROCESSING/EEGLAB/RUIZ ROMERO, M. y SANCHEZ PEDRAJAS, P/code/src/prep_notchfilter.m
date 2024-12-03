function data = prep_notchfilter(cfg,data)
%% PREP_NOTCHFILTER
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  This function returns the notch-filtered version of the input dataset.
 
% Notch filter:
    
if cfg.filter.notch.flag
    fprintf('\n<strong> > Applying notch filter...</strong>\n\n');
    for i = 1 : size(cfg.filter.notch.fnull,1)
        data = pop_eegfiltnew(data,...
            cfg.filter.notch.fnull(i,1),cfg.filter.notch.fnull(i,2),...
            cfg.filter.notch.order,1,[],cfg.filter.plotfreqresp);
    end
end

% Save data if needed:
if cfg.notchfilter.save
   save_subject_data(cfg,data,cfg.notchfilter.sdir);
end

end

