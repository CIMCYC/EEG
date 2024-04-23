**********************************************
* ECGLab - last updated on Oct 22nd, 2008    *
**********************************************
* Author: Joao L. A. Carvalho, Ph.D.         *
* Digital Signal Processing Group (GPDS)     *
* Department of Electrical Engineering       *
* 2002/2003 Universidade de Brasilia, Brazil *
* joaoluiz@gmail.com                         *
* http://www.ene.unb.br/~joaoluiz/           *
**********************************************

THIS SOFTWARE REQUIRES MATLAB 6.0 or 6.5
Might not work properly with other versions of Matlab

All rights reserved to the author. This software can be obtained free of
charge for scientific use by contacting the author directly at
joaoluiz@gmail.com. Please, do not distribute without the author's
permission.

As of this version, all modules have been fully translated to English:

Please report bugs and typos to joaoluiz@gmail.com

Instructions of Usage:
----------------------

- unzip all files to c:\ecglab (or somewhere else)

- download any ECG signal (atr,dat & hea files) from Physionet.
  Example:
  * http://www.physionet.org/physiobank/database/mitdb/103.atr
  * http://www.physionet.org/physiobank/database/mitdb/103.dat
  * http://www.physionet.org/physiobank/database/mitdb/103.hea

-------------------------------------------------------

- on the Matlab command window, type:
cd c:\ecglab (to go to the directory where you installed ecglab)
ecgconvert (to execute this module)

- then type the .dat filename and press OPEN to load it.

- select a channel and a time-segment of the signal. A total of 300 seconds
  (5 min) should be ok. look for a segment with few ectopic beats. type in
  the starting (Begin) and ending positions (End). Example: from 0 to 300.

- type the destination filename and press SAVE to export that segment
  into a Matlab format (.mat) file. This file will contain two variables:
  ecg (a vector with ecg samples) and fs (the sampling rate)

- you can load and plot ecg signals from .mat files using the provided
  function 'plotecg'. Type 'help plotecg' on the command window for
  more information.

------------------------------------

- on the Matlab command window, type:
cd c:\ecglab (you don't need to type this again if you already did it)
ecgfilt (to execute this module)

- click on OPEN to load a .MAT OR .ECG file.
- if you want to load ECG data in a different format, write some code
  to open your data file and then save the data into a .mat file containing
  two variables: ecg (a vector with ecg samples) and fs (the sampling rate).
  For this, use the following command: save('filename.mat','ecg','fs');
  E-mail joaoluiz@gmail.com if you need help with this.
- use the notch filter to reduce 60Hz noise
- use the lowpass filter to remove EMG (muscle) signal and high-frequency noise.
- use the highpass filter to remove baseline fluctuations.
- press SAVE to update the .ECG file with the filtered signal.
  The filtered signal will be saved to a .mat file with the same name
  as the original, but the word _filtered will be appended at the end
  of the name of the filename, so your original/unfiltered file is preserved.
- to undo the filtering, reload the previously saved ECG file by
  pressing OPEN again.

-------------------------------------

- on the Matlab command window, type:
cd c:\ecglab (you don't need to type this again if you already did it)
ecglabrr (to execute this module)

- click on OPEN to load a .MAT OR .ECG file.
- if you want to load ECG data in a different format, write some code
  to open your data file and then save the data into a .mat file containing
  two variables: ecg (a vector with ecg samples) and fs (the sampling rate).
  For this, use the following command: save('filename.mat','ecg','fs');
  E-mail joaoluiz@gmail.com if you need help with this.
- on the "R-R Interval" menu, you can:
   * run the automatic qrs detection: You can choose
     between a fast algorithm and a slow algorithm ("lento").
     the fast algorithm is good enough in most cases.
   * Save, clear or restore QRS markings
- run the fast algorithm and wait until the markings are displayed. search
  the signal using the controls and look for misdetections. you may want to
  zoom out by increasing the window length in order to scan
  the entire signal faster. Use the arrows to visually scan the signal.
- if you find something wrong, click on the marking to erase it and then
  click on the right spot for a new marking. to improve your accuracy, you
  may zoom in using by changing the window length to a smaller value.
- if you find and ectopic beat (very short or very long RR interval, or an
  arrhytmia), mark it as an "ectopic beat" by clicking on "Mark Ectopic".
- if you marked a normal interval as being "ectopic", you may unmark
  it by clicking on "Unmark Ectopic".
- When you're done, click on SAVE to save your markings. this will create
  an IRR signal with this info, and also a TXT file with a list of RR interval
  durations.

-------------------------------------------------------

- on the Matlab command window, type:
cd c:\ecglab (you don't need to type this again if you already did it)
ectopicsrr (to execute this module)

- open the IRR file.
- if you want to import a RR interval series into ecglab, you can type it as
  a text file and click on "Open ASCII". ECGLab supports many file formats,
  but each interval value should be in a different line, without skipping lines.
  ECGLab does not recognize decimal values. For example, 670.5 will be read 670.
- intervals marked as ectopic beats will be shown as red dots. normal beats
  are black dots.
- you can run the automatic detection to find this beats, but it is not very
  effective. the best approach is to mark them on the ECG signal using
  the 'ecglabrr' module. sometimes an interval looks like it is an ectopic beat
  when looking at the HRV signal, but if you refer to the ECG you will realize
  it's a normal beat. Also, ectopic beats that can be easily recongized when
  looking   at the ECG may seem normal when looking at the HRV time plot.
- you can also mark/unmark ectopic beats in this module, by clicking on
  "Mark/Unmark". Press "CLEAR" to clear all ectopic beat markings.
- use the arrows to move along the signal or type in the number of the first and
  last beats to be exported. Press "Select Segment" to discard the beats
  outside that range. This should be useful when dealing with very long ECG
  signals. You can run QRS detection in the whole signal, and then select a
  5 minute seriels of RR intervals for HRV analysis.
- press "SAVE" to save your work. This will update (or create) an IRR file,
  which you can use with the HRV analysis modules.
- if you are using ECGLab with TXT files, you are encouraged to run ectopicsrr
  to inspect the signal, make markings, and then export it as an IRR file to be
  used in the analysis modules. Although the analysis modules can import TXT files
  themselves, they do not recognize ectopic beats markings from TXT files!
- after saving the ectopic beat markings, you are encouraged to go back to the
  ecglabrr module and verify if all beats marked as ectopics are really abnormal,
  and that all ectopics beats are marked.

-----------------------------------------------------

- for time-series analysis of the HRV signal, run temporalrr. Type:
cd c:\ecglab (you don't need to type this again if you already did it)
temporalrr (to execute this module)

- open the IRR file.
- use the controls to change the plot axis (zoom-in & zoom-out)
- select whether or not you want the statistical outliers of the interval
  time-series to be displayed as 'x' markings in the boxplot in the bottom
  right corner of the screen.
- select the x-axis: seconds ("Time") or sample index ("Interval Number")
- press "Table of Intervals" to see a table with the RR interval durations
- press "Print Table" to open the TXT file on wordpad for printing or
  viewing purposes.
- you can type in Patient information ("Patient Record") by clickng on "Edit".
  Patient information is saved as a .PRO text file.
- press "View/Update" to read the patient record.
- choose what you want ECGLab to do regarding ectopic beats during temporal analysis:
  * remove beats marked as ectopic
  * remove and interpolate (using cubic splines)
  * don't remove (don't do anything about it, i.e. treat ectopic beats as
    if they were normal beats)
- Press "HTML Report" to generate a HTML report file, which you
  can easily print or use for keeping a record of your work.
- the following statistics are presented on the upper right corner of the screen:
  minimum interval, maximum interval, dynamic range, 25/50/75 percentiles,
  mean, standard deviation, variance coefficient, pNN50, r-MSSD, total number
  of samples and stationarity evaluation.

-----------------------------------------------------

- for frequency domain analysis of HRV, run spectralrr. Type:
cd c:\ecglab (you don't need to type this again if you already did it)
spectralrr (to execute this module)

- open the IRR file.
- the spectrum is divided in three frequency bands: VLF (0-0.04Hz),
  LF (0.04-0.15Hz) and HF (0.15-0.40Hz). You can change those ranges by typing
  in the new values or pressing "Use Mouse" and then clicking on the plot.
- check "Fill" to fill each band with a different color.
- Patient Record can be edited/viewed in this module too.
- Adjust the plot axis
  * "Freq. From:": starting frequency
  * "To": final frequency
  * "Ampl. From": minimum amplitude
  * "To": maximum amplitude
- Choose the auto-regressive (AR) order (if applies)
- Choose the number of samples of the spectrum ("# of Pts"). For DFT,
  zero-padding is used.
- Choose the HRV interpolation sampling rate, in Hz
- Choose between linear, monolog and log-log plots.
- Choose between auto-regressive (AR), Fourier (DFT) or both.
- Choose window type: rectangular, bartlett, hamming, hanning, blackman
- Choose Method (Mateo and Laguna, IEEE Comp Cardiol 27:813-816, 2000):
  * FHPIS (recommended) - Heart period (R-R) interpolated series (uses cubic splines
                          interpolation to deal with non-uniform sampling)
  * FHPc - Heart period corrected series (no interpolation, except for replacing
           ectopic beats with interpolated values)
  * FHP - heart period series, with no interpolation
  * FHRIS, FHRc, FHR - heart rate series, i.e. same as 1/FHPIS, 1/FHPc and 1/FHP
  * LHP, LHR - uses lomb-scargle periodogram to deal with non-uniform sampling.
- Press "Display Signal" for a plot of the HRV signal in time-domain
- Press "HTML Report" to generate a HTML report file.

-----------------------------------------------------


- for Poincaré plot analysis of HRV, run poincarerr. Type:
cd c:\ecglab (you don't need to type this again if you already did it)
poincarerr (to execute this module)

- open the IRR file.
- the table on the right presents the following information:
  * total number of points
  * centroid
  * vertical deviation (SD1) and longitudinal deviation (SD2)
  * SD1/SD2 ratio and area of ellipse
  * correlation coefficient and regression coefficient
  * regression line equation
- you can choose between the regression line or the identity line for evaluation
  of SD1 and SD2 lengths.
- press "Percentile Statistics" for a statistic evaluation of the sub-series at
  each percentile.
- use the controls to adjust the plot axis.
- adjust the percentile resolution (i.e. range of interval durations to be
  considered equal to that of the correspondent percentile), in "Percentile ±"
- check/uncheck boxes do display the SD1/SD2 markings, the regression/identity
  line, and percentile related markings.
- choose what you want ECGLab to do regarding ectopic beats for poincare analysis:
  * remove beats marked as ectopic
  * remove and interpolate (using cubic splines)
  * don't remove (don't do anything about it, i.e. treat ectopic beats as
    if they were normal beats)
- Patient Record can be edited/viewed in this module too.
- Press "Display R-R Signal" for a plot of the HRV signal in time-domain
- press "Table of Intervals" to see a table with the RR interval durations
- press "Print Table" to open the TXT file on wordpad for printing or
  viewing purposes.
- Press "HTML Report" to generate a HTML report file.

-----------------------------------------------------

- for sequential trend analysis of HRV, run trendrr. Type:
cd c:\ecglab (you don't need to type this again if you already did it)
trendrr (to execute this module)

- open the IRR file.
- the table on the upper right corner of the screen presents the total number
  and percentage of points in each quadrant and on each line. The number of
  of points on the origin and the total number of points is also presented.
- "Null Differences" is the total number of points on either the x or y axis
- "Non-Null Differences" is the number of points not on neither the x or y axis
- use the controls to adjust the plot axis ("Plot Limits")
- choose what you want ECGLab to do regarding ectopic beats for trend analysis:
  * remove beats marked as ectopic
  * remove and interpolate (using cubic splines)
  * don't remove (don't do anything about it, i.e. treat ectopic beats as
    if they were normal beats)
- Press "Display R-R Signal" for a plot of the HRV signal in time-domain
- press "Table of Intervals" to see a table with the RR interval durations
- press "Print Table" to open the TXT file on wordpad for printing or
  viewing purposes.
- Patient Record can be edited/viewed in this module too.
- Press "HTML Report" to generate a HTML report file.


-----------------------------------------------------

- for time-frequency analysis of HRV, run timefreqrr. Type:
cd c:\ecglab (you don't need to type this again if you already did it)
timefreqrr (to execute this module)

- open the IRR file.
- adjust the cubic spline interpolation rate (recommend: 2 Hz)
- choose between auto-regressive (AR) and Fourier (DFT) spectrograms and
  adjust AR order (if applies) (recommended: AR with order 12)
- chose window length, in seconds (recommended: 30sec)
- choose window type (recommended: Hanning or Hamming)
- adjust spectrogram sampling. the more samples you use, the better it
  looks, at the cost of processing time (recommended: 512 pts/PSD, 1Hz)
- adjust VLF, LF and HF frequency bands (recommended: 0.04, 0.15, 0.40)
- specify the range of frequencies to be displayed (recommended: 0.5Hz)
- uncheck "Ectopic" if you want to discard intervals marked as ectopic beats.
- ATTENTION: with the exception of the cubic spline interpolation rate, none of
  the above parameters affects the calculation of the wavelet spectrogram.
- Use the pull-down menus to choose which plot to be displayed in each of the
  three windows:
  * time-domain plot of the HRV signal ("RR Signal")
  * time-domain plot using cubic spline interpolation
  * Spectrogram
  * LF/HF ratio as a function of time (with or without colored areas)
  * Absolute Power in VLF, LF or HF frequency ranges (and total power) as a
    function of time
  * Relative Power (%) in VLF, LF or HF frequency ranges as a function of time
  * Power Spectrum Density (frequency-domain)
  * Wavelet Spectrogram (Scalogram)
  * Wavelet Spectrogram in log2 scale along the frequency axis
- ATTENTION: If a plot does not come up properly, it might be necessary to
  adjust the xy axis (read below)
- Press "Display Statistics" for a quantitative time-frequency
  evaluation. No statistics are being calculated from the Wavelet
  Spectrogram at the moment. The statistics are calculated from either the AR or Fourier
  spectrogram, using the current selected parameters.
- Patient Record can be edited/viewed in this module too.
- use controls to zoom-in in a particular segment of time (x-axis) of the
  HRV signal and arrows to move along the signal. Type in the minimum and
  maximum values for full view zoom-out.
- Press "Adjust Y-Axis" and you will be able to adjust the y axis for
  each plot. Press "Auto" for automatic adjusting and then type in different
  values for customizing. Press "Back" to return to the x-axis controls.

---------------------------

References:
(all included in the documents folder)

J.L.A. Carvalho, A.F. Rocha, F.A.O. Nascimento, J. Souza Neto,
L.F. Junqueira Jr (2002), “Development of a Matlab Software for
Analysis of Heart Rate Variability”, 6th International Conference
on Signal Processing: Proceedings, vol. 2, pp. 1488-1491.

J.L.A. Carvalho, A.F. Rocha, L.F. Junqueira Jr, J. Souza Neto,
I. Santos, F.A.O. Nascimento (2003), “A Tool for Time-Frequency
Analysis of Heart Rate Variability”, 25th Annual International
Conference of the IEEE Engineering in Medicine and Biology
Society, pp. 2574-2577.

J.L.A. Carvalho, A.F. Rocha, I. Santos, C. Itiki, L.F. Junqueira Jr,
F.A.O. Nascimento  (2003), “Study on the Optimal Order for the
Auto-Regressive Time-Frequency Analysis of Heart Rate Variability”,
25th Annual International Conference of the IEEE Engineering in
Medicine and Biology Society, pp. 2621-2624.