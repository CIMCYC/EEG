function ecg_sinal=ecgfilt_filtraEMG(ecg_sinal,corteEMG)
%usage: ecg_sinal=ecgfilt_filtraEMG(ecg_sinal,corteEMG);

global samplerate_ecg

ganho=1;
ordem=2;

[B,A] = butter(ordem,corteEMG/(samplerate_ecg/2));

ecg_sinal=filtfilt(B,A,ecg_sinal);

ecg_sinal=ecg_sinal-mean(ecg_sinal);
ecg_sinal=ecg_sinal/max(ecg_sinal);


%[H,F]=freqz(B,A,4096,samplerate_ecg);
%figure(56453),plot(F,abs(H).^2),grid