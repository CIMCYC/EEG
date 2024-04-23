function sinalout=ecglabRR_filtra17hz(sinal,Q,ganho)
%	usage: sinalout=ecglabRR_filtra17hz(sinal,Q,ganho)

global samplerate_ecg

w0=17.5625*2*pi;
NUM=ganho*w0^2;
DEN=[1,(w0/Q),w0^2];
[B,A] = bilinear(NUM,DEN,samplerate_ecg);

%filtfilt ? um filtro com resposta em frequencia de fase-zero
sinalout = filtfilt(B,A,sinal); 
%sinalout = filter(B,A,sinal);