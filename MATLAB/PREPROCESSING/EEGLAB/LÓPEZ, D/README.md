# Eeg-preprocessing
This repository contains a set of preprocessing routines for EEG signals in which you can import raw data or data in BIDS format, only it is necessary to choose the correct destination folder at the beginning of the config script.
Preprocessing data will be store in BIDS format.

**Notes:** 
 - EEGLAB should be installed and running to execute this script.
 - BVA-io plug-in for EEGLAB should be installed in order to load Brain Vision Analyzer EEG raw data files, as well as loadcurry plug-in for EEGLAB to load Neuroscan Curry raw data files.
   (It is better to import your data in BIDS format from the beginning so that it is easier to use the scripts without the possibility of errors appearing due to the extension of the raw data, above all if you have another data extension different from this. You can export your raw data to BIDS format using the script 'bids_export_eeglab.m' https://github.com/CIMCYC/BIDS-MATLAB-EEG).

# Automatic EEG preprocessing steps:

### Preprocessing steps before computing Independent Component Analysis:

 - Rename events.
 - Change sampling rate.
 - Filter data.
 - Generate epoched dataset

### Independent Component Analysis:

 - Compute ICA.
 - Delete bad components.

### Rest of the preprocessing pipeline:

 - Automatic trial rejection.
 - Electrodes interpolation.
 - Recover reference electrode.
 - Compute re-reference.
 - Extract conditions.

