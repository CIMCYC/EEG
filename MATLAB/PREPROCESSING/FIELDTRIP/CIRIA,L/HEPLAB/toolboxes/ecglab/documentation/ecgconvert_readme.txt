-----------------------------------------------------
ECGConvert
-----------------------------------------------------
Written by João Luiz Azevedo de Carvalho, Ph.D.
University of Brasilia, Brasilia-DF, Brazil
joaoluiz@gmail.com
http://www.ene.unb.br/~joaoluiz/
-----------------------------------------------------

This Matlab tool reads Physionet ECG data and exports
to a Matlab file.

-----------------------------------------------------

Extract this ZIP file into c:\ecgconvert or any other
folder you want.

Place the .dat, .atr e .hea files all in the same folder,
for example, c:\ecgconvert\signals

Run Matlab. On its command window, type:

cd c:\ecgconvert
ecgconvert

The ECGConvert GUI will pop-up. Use it to open the
.DAT file that you wish to import.

Choose the channel and signal segment you wish
export. Type in the name of the ouput file and
hit SAVE.

-----------------------------------------------------

The files are saved to a .mat file, which containts two
variables: ecg (a vector with ecg samples) and fs (the
sampling rate).

The .mat file can be loaded in matlab using the comand:
load filename.mat

-----------------------------------------------------

You may load and plot the ECG signal in a .MAT file, using
the provided function 'plotecg'. Type 'help plotecg' on
the command window for more information. An example is
provided below:


filename = 'c:\ecglab\signals\103_ch1_000to300.mat';
[ecg,fs,t] = plotecg(filename);

-----------------------------------------------------

A sample ECG signal (103.dat) is attached (from MIT's
arrhythmia database). There are many other databases
and many other signals you can import using this
software, on this page:

http://www.physionet.org/physiobank/database/#ecg