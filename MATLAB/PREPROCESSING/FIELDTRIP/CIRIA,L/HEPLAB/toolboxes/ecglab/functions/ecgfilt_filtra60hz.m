function ecg_sinal=ecgfilt_filtra60hz(ecg_sinal,largura60hz);

global samplerate_ecg

%distancia entre polos e zeros
d=largura60hz/100;

%ganho do filtro
ganho=1;

%angulos de colocacao de polos e zeros
fo=[];
for k=60:60:samplerate_ecg/2,
   fo=[fo;k];
end
theta=fo*pi/(samplerate_ecg/2);

%calcula os polos e zeros
zeros=[exp(j*theta);exp(-j*theta)];
polos=(1-d)*zeros;

%calcula os coeficientes do filtro
[B,A] = zp2tf(zeros,polos,ganho);

%filtra com fase zero
ecg_sinal=filtfilt(B,A,ecg_sinal);

%converte para [-1 1]
ecg_sinal=ecg_sinal-mean(ecg_sinal);
ecg_sinal=ecg_sinal/max(ecg_sinal);

%figure(45343),freqz(B,A,4096,samplerate_ecg)
%figure(453343),zplane(zeros,polos)