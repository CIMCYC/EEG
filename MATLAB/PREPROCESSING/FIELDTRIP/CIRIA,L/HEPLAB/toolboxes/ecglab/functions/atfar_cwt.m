function [cwtpower,period] = atfar_cwt(csastruct,params);

fs = params.fsRR;
Ts = 1/fs;
tempo = csastruct.tksplines;
xlim=[params.janela_inicio params.janela_fim];
RR = csastruct.RRsplines;
sst = RR;

% Normaliza com a Variância
variance = std(sst)^2;
sst = (sst - mean(sst))/sqrt(variance);
 
% Comprimento da série temporal
n = length(sst);

% Período de amostragem dt = 1/Fa
dt = 1/fs; 

time = [0:length(sst)-1]*dt;  % duração do sinal
pad = 1;      % faz o padding da série temporal com zeros
dj = 1/64; %0.0625;  % 0.25 faz 4 sub-oitavas por oitava
j1 = 7/dj;    % Faz 7 potências de 2 com dj sub-oitavas cada

% s0 é a menor escala. 
% Pode-se começar com uma escala de 2*dt 
s0 = 2.0*dt;  

% Não mexer aqui !
lag1 = 0.72;  % autocorrelação lag-1 para background com red noise, 0.72

% Escolha da Wavelet mãe
%mother = 'Morlet';
mother = 'DOG';
%mother = 'Paul';
 
%----------------- Computação numérica ----------------% 

% Transformada Wavelet:
[wave,period,scale,coi] = waveletszn(sst,dt,pad,dj,s0,j1,mother);

% computa o espectro de potência da wavelet
cwtpower = (abs(wave)).^2;