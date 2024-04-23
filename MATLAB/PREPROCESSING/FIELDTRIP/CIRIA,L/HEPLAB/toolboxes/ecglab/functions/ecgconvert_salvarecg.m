function ecgconvert_salvarecg(filename,inicio,fim,ecg,fs);

%global samplerate_ecg

ponto=find(filename=='.');filename=[filename(1:ponto(length(ponto))-1),'.mat']; %adapta a extensao

inicio=round(inicio*fs)+1;
fim=floor(fim*fs)+1;
ecg=ecg(inicio:fim);

save(filename,'ecg','fs');

% ecg=round(resample(ecg,samplerate_ecg,fs));
% 
% ecg=ecg(1:floor((fim-inicio)/fs*samplerate_ecg));
% 
% ecg=ecg-min(ecg);
% ecg=round(4095*ecg/max(ecg));
% 
% fid=fopen(filename,'w');
% fwrite(fid,ecg,'uint16');      
% fclose(fid);