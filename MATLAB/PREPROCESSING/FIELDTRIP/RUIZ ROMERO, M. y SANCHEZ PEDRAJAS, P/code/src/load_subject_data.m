function [data,load_subject] = load_subject_data(conf,subject,steps,nsteps)
%% LOAD_SUBJECT_DATA
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes made by: María Ruiz and María del Pilar Sánchez
% (mariaruizromero@ugr.es, pilarsanpe@ugr.es)
% -------------------------------------------------------------------------
%  This function returns the fieltrip data structure for the specified
%  subject.

fprintf(['\n<strong> > Loading subject: ' subject.id '</strong>\n\n']);

% Search .vhdr file:
    
if nsteps==1

    file = dir([subject.dir filesep 'sub*.vhdr']);

    if size(file,1)

            % Load subject data:
            file_name = file(1).name;
            data.hdr  = ft_read_header([subject.dir filesep file_name]);

    else
            % Send warning:
            exit([subject.id ' - File not found!']);

    end
        
    %% Add subject information to data structure:

    [~,file,~] = fileparts(file(1).name);
    subject.filename = file;
    data.subject = subject;

    % Rename events if needed:
%     if conf.rename; data.event = prep_rename_events(data.event); end

else
    
    load_dir = [conf.datapath filesep 'derivatives' filesep subject.id  ...
      filesep 'eeg'];
    files = dir([load_dir filesep subject.id '_' conf.taskname '_' cell2mat(steps(nsteps-1)) '_eeg' '.mat']);
    file_name = files(1).name;

    cd(load_dir);
    load (file_name, '-mat');

end

load_subject = 1;

end



