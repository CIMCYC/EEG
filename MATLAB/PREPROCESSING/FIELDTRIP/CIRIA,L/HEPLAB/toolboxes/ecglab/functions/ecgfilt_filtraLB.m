function ecg_sinal=ecgfilt_filtraLB(ecg_sinal,fo)
%usage: ecg_sinal=ecgfilt_filtraLB(ecg_sinal,corteLB);

global samplerate_ecg

ganho=1;
ordem=2;

[B,A] = butter(ordem,fo/(samplerate_ecg/2),'high');

ecg_sinal=filtfilt(B,A,ecg_sinal);

ecg_sinal=ecg_sinal-mean(ecg_sinal);
ecg_sinal=ecg_sinal/max(ecg_sinal);