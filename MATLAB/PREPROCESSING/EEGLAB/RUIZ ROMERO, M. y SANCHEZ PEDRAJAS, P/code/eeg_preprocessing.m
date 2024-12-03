%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (eeg_preproc.m)
% -------------------------------------------------------------------------
% María Ruiz Romero and María del Pilar Sánchez Pedrajas
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
%% File format
% It is necessary that data will be in BIDS format to run this script.
% You can get the code to export to BIDS' format in CIMCYC's github
% 'https://github.com/CIMCYC/BIDS-MATLAB-EEG'.

%% Notes:
%
% - Run this script.
% - EEGLAB should be installed and running to execute this script.
% - Amplifier's online cut-off frecuencies: [0.016-250]Hz
% - Lower cut-off frecuency [s]: Time constant = 10s - fc = 1/2*pi*t

%% Automatic EEG preprocessing steps:
%
%   - Load subject data (rename events is done inside, change 'prep_rename_events').
%   - Change sampling rate.
%   - Filter data.
%   - Generate epoched dataset
%   - Compute ICA.
%   - Delete bad components.
%   - Automatic trial rejection.
%   - Electrodes interpolation.
%   - Recover reference electrode.
%   - Compute re-reference.
%   - Extract conditions.

clear all; clc;
run config;
path(path,'src');

%% Preprocessing
% Get the list of subjects to load:
subject_list = get_subject_list(cfg);

for sub = 1 : length(subject_list)

    for nsteps = 1 : numel(steps)  % Indicate in which preprocessing step you want it to start and end.
        
        % Select subject id:
        subject = subject_list(sub);
        
        if nsteps == 1 || load_subject==0
            % Load subject data:
            [subject_data, load_subject] = load_subject_data(cfg,subject,steps,nsteps);
        end

        actual_step = steps(nsteps);
        actual_step = string(actual_step);

        switch actual_step

            case 'deletebadchannels'
                % Delete channels:
                subject_data = prep_deletebadchannels(cfg,subject_data);

            case 'resampled'
                % Resample data:
                subject_data = prep_resample(cfg,subject_data);

            case 'highpass-filtered'
                % Filter data:
                subject_data = prep_highpassfilter(cfg,subject_data);

            case 'lowpass-filtered'
                % Filter data:
                subject_data = prep_lowpassfilter(cfg,subject_data);

            case 'notch-filtered'
                % Filter data:
                subject_data = prep_notchfilter(cfg,subject_data);

            case 'epoched'
                % Generate epochs:
                subject_data = prep_epochdata(cfg,subject_data);
   
            case 'icaweights'
                % Compute ICA (Compute Independent Component Analysis):
                prep_computeica(cfg,subject_data);

            case 'icapruned'
                % Remove bad components:
                subject_data = prep_remove_components(cfg,subject_data);

            case 'trialpruned'
                % Automatic trial rejection:
                [subject_data,reports.trirej{sub}] = prep_trial_rejection(...
                 cfg,subject_data);

            case 'interpoled' 
                % Electrode interpolation:
                subject_data = prep_electrode_interpol(cfg,subject_data);

            case 'rereferenced'
                % Data re-reference:
                subject_data = prep_rereference(cfg,subject_data);
    
        end
    end

    load_subject = 0;

    % Extract conditions:
    reports.conditions(sub,:) = prep_extract_conditions(cfg,subject_data);
    
end

% Generate reports:
% prep_reports(cfg,reports);


