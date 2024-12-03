function [data] = prep_remove_components(cfg,data)
%% PREP_REMOVE_COMPONENTS 
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function removes the identified artifactual components after ICA
% decomposition:

if cfg.ica.badcomponents.flag
    
    % Select subject idx:
    subject_idx = str2double(data.subject.id(end-2:end));
    
    fprintf('\n<strong> > Removing artifuactual ICA components...</strong>\n\n');
    
    % Delete bad components:
    data = pop_subcomp(data,cfg.ica.badcomponents.delete{subject_idx},0);
    
end  

% Save data if needed:
if cfg.ica.badcomponents.save
    save_subject_data(cfg,data,cfg.ica.badcomponents.sdir);
end
    
end

