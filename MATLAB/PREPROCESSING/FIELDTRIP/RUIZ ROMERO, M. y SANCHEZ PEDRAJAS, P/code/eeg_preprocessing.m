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
% - Fieldtrip should be installed to execute this script.
% - Amplifier's online cut-off frecuencies: [0.016-250]Hz
% - Lower cut-off frecuency [s]: Time constant = 10s - fc = 1/2*pi*t

%% Automatic EEG preprocessing steps: -
%
%   - Load subject data (rename events, change 'prep_rename_events').
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
%

clear all; clc;
run config;
path(path,'src');
ft_defaults;

%% Preprocessing

% Get the list of subjects to load:
subject_list = get_subject_list(conf);

for sub = 1 : length(subject_list)
    
    for nsteps = 1:numel(steps)    % Indicate in which preprocessing step you want it to start and end.

          if nsteps ==1 || load_subject == 0

            % Select subject id:
            subject = subject_list(sub);
            conf.subject = subject;

            % Load subject data:
            [subject_data, load_subject] = load_subject_data(conf,subject,steps,nsteps);

          end

        actual_step = steps(nsteps);
        actual_step = string(actual_step);

        switch actual_step

            case 'viewsignal'
                % Resample data:
                subject_data = prep_displaysignal(conf,subject_data);

            case 'deletebadtrials'
                % Delete bad trials
                subject_data = prep_deletebadtrials(conf,subject_data);

            case 'resampled'
                % Resample data:
                subject_data = prep_resample(conf,subject_data);

            case 'highpass-filtered'
                % Filter data:
                subject_data = prep_highpassfilter(conf,subject_data);

            case 'lowpass-filtered'
                % Filter data:
                subject_data = prep_lowpassfilter(conf,subject_data);
            
            case 'notch-filtered'
                % Filter data:
                subject_data = prep_notchfilter(conf,subject_data);

            case 'epoched'
                % Generate epochs:
                subject_data = prep_epochdata(conf,subject_data);
   
            case 'icaweights'
                % Compute ICA (Compute Independent Component Analysis):
                [badicas,comp] = prep_computeica(conf,subject_data);

            case 'icapruned'
                % Remove bad components:
                subject_data = prep_remove_components(conf,comp,subject_data,badicas);

            case 'interpoled' 
                % Electrode interpolation:
                [subject_data, neighbours] = prep_electrode_interpol(conf,subject_data);

            case 'rereferenced'
                % Data re-reference:
                subject_data = prep_rereference(conf,subject_data);
    
        end
    end

    load_subject = 0;

    % Extract conditions:
%     reports.conditions(sub,:) = prep_extract_conditions(conf,subject_data);
    
end

