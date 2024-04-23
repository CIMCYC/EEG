function [ecg2canais, ecg_totalsamples, segundos_sinal, janelas, samplerate]=ecgconvert_abrir(filename,segundos_janela);


ponto=find(filename=='.');
recname=[filename(1:ponto(length(ponto))-1)]; %adapta a extensao

% Reading header information
heasig=readheader([recname '.hea']);

samplerate=heasig.freq;
ecg_totalsamples=heasig.nsamp;


t=[1 ecg_totalsamples];  % time interval [onset offet]
%annot=readannot([recname '.atr'],t); % Reading annotation file
% reading ECG signal file with format 212
if heasig.fmt(1)==212
   ecg2canais=rdsign212([recname '.dat'],heasig.nsig,t(1),t(2));
end

%se conseguir abrir
a=size(ecg2canais);a=a(1);
if a==ecg_totalsamples,
   
   canal1 = ecg2canais(:,1);canal1=canal1-mean(canal1);canal1=canal1/max(abs(canal1));
   canal2 = ecg2canais(:,2);canal2=canal2-mean(canal2);canal2=canal2/max(abs(canal2));
   ecg2canais=[canal1,canal2];
   
   %calcula o tempo de sinal e o numero de janelas
   segundos_sinal=ecg_totalsamples/samplerate;
   janelas=ceil(segundos_sinal/segundos_janela);
   
%se nao conseguir abrir o arquivo ECG, atribui -1 as demais variaveis
else
   ecg_totalsamples=-1,
   segundos_sinal=-1;
   janelas=-1;
end,