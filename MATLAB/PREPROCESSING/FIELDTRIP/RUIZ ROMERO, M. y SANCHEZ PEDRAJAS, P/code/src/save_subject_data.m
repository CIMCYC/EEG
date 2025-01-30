function save_subject_data(conf,data,sdir)
%% SAVE_SUBJECT_DATA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%  This function saves an EEG dataset in the specified folder and format.

fname = [conf.subject.id '_' conf.taskname '_' sdir];
sdir = [conf.datapath filesep 'derivatives' filesep  conf.subject.id filesep 'eeg'];
mkdir(sdir);
newname = [regexprep(fname,'_eeg', '') '_eeg'];

% Save data
save([sdir filesep newname],'data');
    
end

% You can use this function to read data from one format, filter it, and
% write it to disk in another format. The reading is done either as one
% long continuous segment or in multiple trials. This is achieved by
%   cfg.export.dataset    = string with the output file name
%   cfg.export.dataformat = string describing the output file format, see FT_WRITE_DATA