function [data,load_subject] = load_subject_data(cfg,subject,steps,nsteps)
%% LOAD_SUBJECT_DATA
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function returns the eeglab data structure for the specified
% subject.

fprintf(['\n<strong> > Loading subject: ' subject.id '</strong>\n\n']);

% Search .set file:
if nsteps==1
    file = dir([subject.dir filesep 'sub*.set']);
    if size(file,1)
       % Load subject data:
       data = pop_loadset('filename',file(1).name,...
             'filepath',subject.dir);
    else
       % Send warning:
       exit([subject.id ' - File not found!']);
    end
        
    % Add subject information to data structure:
    [~,file,~] = fileparts(file(1).name);
    subject.filename = file;
    data.subject = subject;

    % Rename events if needed:
    if cfg.rename 
        data.event = prep_rename_events(data.event); 
    end

else
    load_dir = [cfg.datapath filesep 'derivatives' filesep subject.id  ...
         filesep 'eeg'];
    files = dir([load_dir filesep subject.id '_' 'task-' cfg.taskname '_' cell2mat(steps(nsteps-1)) '_eeg' '.set']);
    file_name = files(1).name;

    % Importa data:
    data = pop_loadset('filename',file_name,'filepath',load_dir);

end

load_subject = 1;

end



