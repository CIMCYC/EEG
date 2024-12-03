function save_subject_data(cfg,data,sdir)
%% SAVE_SUBJECT_DATA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%  This function saves an EEG dataset in the specified folder and format.

fname = [data.subject.filename '_' sdir];
sdir = [cfg.datapath filesep 'derivatives' filesep  data.subject.id filesep 'eeg'];
mkdir(sdir);
newname = [regexprep(fname,'_eeg', '') '_eeg'];

if strcmp(cfg.saveformat,'set') || strcmp(cfg.saveformat,'both')

    data = pop_saveset(data, 'filename',newname,'filepath', sdir);
    
end
    
if strcmp(cfg.saveformat,'mat') || strcmp(cfg.saveformat,'both')
    
    save([sdir filesep newname],'data');
    
end
    
end
