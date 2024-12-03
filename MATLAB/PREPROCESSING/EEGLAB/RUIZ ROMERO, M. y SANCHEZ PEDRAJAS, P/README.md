# GENERAL EEG PREPROCESSING
This repository provides a flexible framework for preprocessing routines for EEG signals in which you have to import your data in BIDS format, only it is necessary to choose the correct destination folder at the beginning of the config script.
If your EEG data is not already in BIDS format, you can use the BIDS-MATLAB-EEG repository (https://github.com/CIMCYC/BIDS-MATLAB-EEG) to convert your raw EEG data. This ensures seamless compatibility with the preprocessing scripts in this repository.
The preprocessing pipeline is highly customizable, allowing users to define the order of the preprocessing steps according to their specific needs. This flexibility is configured in the config.m file, where users can enable or disable steps such as filtering, epoching, Independent Component Analysis (ICA), and artifact rejection, and control the sequence of these operations.
Preprocessing data will be store in BIDS format.

**Notes:** 
 - EEGLAB should be installed and running to execute this script.
 - BVA-io plug-in for EEGLAB should be installed in order to load Brain Vision Analyzer EEG raw data files, as well as loadcurry plug-in for EEGLAB to load Neuroscan Curry raw data files.
   (It is better to import your data in BIDS format from the beginning so that it is easier to use the scripts without the possibility of errors appearing due to the extension of the raw data, above all if you have another data extension different from this. You can export your raw data to BIDS format using the script 'bids_export_eeglab.m' https://github.com/CIMCYC/BIDS-MATLAB-EEG).

## Key Files
- eeg_preprocessing.m: Handles the preprocessing of raw EEG data, including filtering, artifact removal, and epoching.
- config.m: Contains configuration parameters for EEG analysis, including file paths, preprocessing steps, subject details, and preprocessing settings.
- /code/ folder: 
	- Contains modular scripts that handle individual preprocessing tasks.
	- Each script in the /code/ folder is designed to perform a specific preprocessing step and is called automatically within eeg_preprocessing.m. Users do not need to modify these scripts, except for prep_rename_events.m, where you will need to customize the event renaming logic to match your dataset's specific event codes.


# Preprocessing steps:

 - Rename events.
 - Change sampling rate.
 - Filter data.
 - Generate epoched dataset
 - Compute ICA.
 - Delete bad channels.
 - Delete bad components.
 - Automatic trial rejection.
 - Electrodes interpolation.
 - Recover reference electrode.
 - Extract conditions.

