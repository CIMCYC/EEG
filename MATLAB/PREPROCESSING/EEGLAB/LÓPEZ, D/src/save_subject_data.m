function save_subject_data(cfg,data,sdir)
%% SAVE_SUBJECT_DATA
%  This function saves an EEG dataset in the specified folder and format.

fname = [data.subject.filename '_' sdir];
sdir = [cfg.datapath filesep 'derivatives' filesep  data.subject.id filesep 'eeg' filesep];
mkdir(sdir);
newname = regexprep(fname,'_eeg_', '_');

if strcmp(cfg.saveformat,'set') || strcmp(cfg.saveformat,'both')

    data = pop_saveset(data, 'filename',newname,'filepath', sdir);
    
end
    
if strcmp(cfg.saveformat,'mat') || strcmp(cfg.saveformat,'both')
    
    save([sdir filesep newname],'data');
    
end
    
end
