function data = load_subject_data(cfg,subject)
%% LOAD_SUBJECT_DATA
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% Some changes made by:
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% -------------------------------------------------------------------------
% This function returns the eeglab data structure for the specified
% subject.

fprintf(['\n<strong> > Loading subject: ' subject.id '</strong>\n\n']);

% Search the .vhdr file:
file = dir([subject.raw_dir filesep 'sub*.vhdr']);

% If vhdr file is found, load subject data:
if size(file,1)
    
    % Load subject data:
    first_sample_to_read = 1;
    data = pop_loadbv(subject.raw_dir, file(1).name, first_sample_to_read,...
        cfg.chantoload);

elseif isempty(file)

    % Search the .dap file:
    file=dir([subject.raw_dir filesep 'sub*.dap']);
    subj=[subject.id '.dap'];

    % If dap file is found, load subject data:
    if (size(file,1) && strcmp(file.name, subj))

        % Load subject data:
        first_sample_to_read = 1;
        data = pop_loadcurry([subject.raw_dir filesep file(1).name]);

    else

        % Search .set file:
        file = dir([subject.raw_dir filesep 'sub*.set']);
        subj=[subject.id '.set'];

        if (size(file,1) && strcmp(file.name, subj))
    
        % If set file is found, load subject data:
            if size(file,1)

                % Load subject data:
                data = pop_loadset('filename',file(1).name,...
                'filepath',subject.raw_dir);

            end

        else

            file = dir([subject.raw_dir filesep subject.id '_' cfg.task '_eeg.set']);

            if size(file,1)

                % Load subject data:
                data = pop_loadset('filename',file(1).name,...
                'filepath',subject.raw_dir);

            else
                % Send warning:
                exit([subject.id ' - File not found!']);
                
            end

        end
    end
end

%% Add subject information to data structure:

[~,file,~] = fileparts(file(1).name);
subject.filename = file;
data.subject = subject;

%% Rename events if needed:
if cfg.rename; data.event = prep_rename_events(data.event); end


end

