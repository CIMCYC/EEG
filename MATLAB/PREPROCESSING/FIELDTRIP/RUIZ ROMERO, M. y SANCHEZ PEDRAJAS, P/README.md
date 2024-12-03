# GENERAL EEG PREPROCESSING FieldTrip
This repository provides scripts for EEG analysis using the FieldTrip toolbox, offering a flexible workflow for preprocessing and statistical analysis of EEG data.
To ensure compatibility, EEG data must be in BIDS format. Simply specify the appropriate destination folder at the beginning of the config.m script.
If your data is not already in BIDS format, you can convert it using the BIDS-MATLAB-EEG (https://github.com/CIMCYC/BIDS-MATLAB-EEG) repository. This will facilitate smooth integration with the preprocessing scripts provided here.
The preprocessing pipeline is highly customizable. Users can define the order of operations and select which steps to include by configuring the config.m file.
Processed data will be saved in BIDS format for consistency and ease of further analysis.

**Notes:** 
 - Ensure that FieldTrip is properly installed and configured in your MATLAB environment.

## Key Files
- eeg_preprocessing.m: The main preprocessing script that calls a series of sub-scripts located in the /code/ folder to perform preprocessing steps.
- config.m: This script configures the analysis workflow, allowing users to set paths, parameters, and the order of preprocessing and analysis steps.
- /code/ folder: 
	- Contains modular scripts that handle individual preprocessing tasks.
	- Each script in the /code/ folder is designed to perform a specific preprocessing step and is called automatically within eeg_preprocessing.m. Users do not need to modify these scripts, except:
		- prep_rename_events.m, where you will need to customize the event renaming logic to match your dataset's specific event codes.
		- badicas.m, modify this script if you need to customize how ICA components are visualized and selected for removal.
		- badtrials.m, adjust this script if you need to define how individual trials are visualized and flagged for rejection.


# EEG preprocessing steps:

 - Display signal.
 - Rename events.
 - Change sampling rate.
 - Filter data.
 - Generate epoched dataset
 - Compute ICA.
 - Delete bad components.
 - Automatic trial rejection.
 - Electrodes interpolation.
 - Recover reference electrode.
 - Extract conditions.

