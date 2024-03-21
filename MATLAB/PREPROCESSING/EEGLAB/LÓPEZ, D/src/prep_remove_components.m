function prep_remove_components(cfg,subject)
%% PREP_REMOVE_COMPONENTS 
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes to export to BIDS format made by:
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% -------------------------------------------------------------------------
% This function removes the identified artifactual components after ICA
% decomposition:

if cfg.ica.badcomponents.flag
    
    fprintf(['\n<strong> > Loading subject: ' subject.id '</strong>\n\n']);
    
    % Directory to load data:
    load_dir = [cfg.datapath filesep 'derivatives' filesep  subject.id  ...
        filesep 'eeg'];
    if (strcmp(cfg.datapath, cfg.datapathraw))
        files = dir([load_dir filesep subject.id '_' cfg.ica.sdir '.set']);
        file_name = files(1).name;

    else
        files = dir([load_dir filesep subject.id '_' cfg.task '_' cfg.ica.sdir '.set']);
        file_name = files(1).name;
        
    end
    
    % Select subject idx:
    subject_idx = str2double(subject.id(end-2:end));
    
    % Importa data:
    data = pop_loadset('filename',file_name,'filepath',load_dir);
    
    fprintf('\n<strong> > Removing artifuactual ICA components...</strong>\n\n');
    
    % Delete bad components:
    data = pop_subcomp(data,cfg.ica.badcomponents.delete{subject_idx},0);
    
    % Save data if needed:
    if cfg.ica.badcomponents.save
        save_subject_data(cfg,data,cfg.ica.badcomponents.sdir);
    end
end  

end

