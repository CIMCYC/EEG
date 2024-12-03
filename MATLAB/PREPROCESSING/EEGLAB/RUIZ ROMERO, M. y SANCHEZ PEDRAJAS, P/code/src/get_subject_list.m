function [subject_list] = get_subject_list(conf)
%% GET_SUBJECT_LIST 
%  If the subject array is not empty, return the original subject array.
%  If the subject array is empty, return all the subjects containded in the
%  BIDS compatible folder.

if isempty(conf.subjects)
    
    folders = dir([conf.datapath filesep 'sub*']);
    
    for i = 1 : length(folders)
        subject_list(i).id =  folders(i).name;
        subject_list(i).dir =  [folders(i).folder filesep ...
            folders(i).name filesep 'eeg'];
    end
    
else
    
    for i = 1 : length(conf.subjects)
        subject_list(i).id = conf.subjects{i};
        subject_list(i).dir = [ conf.datapath filesep ...
            conf.subjects{i} filesep 'eeg'];
    end
    
end

end

