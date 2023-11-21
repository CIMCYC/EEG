function data = load_subject_data(cfg,subject)
%% LOAD_SUBJECT_DATA
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%  This function returns the eeglab data structure for the specified
%  subject.

fprintf(['\n<strong> > Loading subject: ' subject.id '</strong>\n\n']);
%

% Search the .vhdr file:
file = dir([subject.raw_dir filesep 'sub*.vhdr']);
cont=0;

% If vhdr file is found, load subject data:
if size(file,1)
    
    % Load subject data:
    first_sample_to_read = 1;
    data = pop_loadbv(subject.raw_dir, file(1).name, first_sample_to_read,...
        cfg.chantoload);
%
elseif cont==0
    % Search the .dap file:
    file=dir([subject.raw_dir filesep 'sub*.dap']);

    if  [ize(file,1) & (file.name=='sub*.dap')]
        % Load subject data:
        first_sample_to_read = 1;
        data = pop_loadcurry([subject.raw_dir filesep file(1).name]);

    else
    % Search .set file:
        file = dir([subject.raw_dir filesep 'sub*.set']);
    
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

%% Add subject information to data structure:

[~,file,~] = fileparts(file(1).name);
subject.filename = file;
data.subject = subject;

%% Rename events if needed:
if cfg.rename; data.event = prep_rename_events(data.event); end


end

