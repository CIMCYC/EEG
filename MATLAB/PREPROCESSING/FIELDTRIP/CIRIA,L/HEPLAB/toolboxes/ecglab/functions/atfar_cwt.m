function [cwtpower,period] = atfar_cwt(csastruct,params);

fs = params.fsRR;
Ts = 1/fs;
tempo = csastruct.tksplines;
xlim=[params.janela_inicio params.janela_fim];
RR = csastruct.RRsplines;
sst = RR;

% Normaliza com a Vari�ncia
variance = std(sst)^2;
sst = (sst - mean(sst))/sqrt(variance);
 
% Comprimento da s�rie temporal
n = length(sst);

% Per�odo de amostragem dt = 1/Fa
dt = 1/fs; 

time = [0:length(sst)-1]*dt;  % dura��o do sinal
pad = 1;      % faz o padding da s�rie temporal com zeros
dj = 1/64; %0.0625;  % 0.25 faz 4 sub-oitavas por oitava
j1 = 7/dj;    % Faz 7 pot�ncias de 2 com dj sub-oitavas cada

% s0 � a menor escala. 
% Pode-se come�ar com uma escala de 2*dt 
s0 = 2.0*dt;  

% N�o mexer aqui !
lag1 = 0.72;  % autocorrela��o lag-1 para background com red noise, 0.72

% Escolha da Wavelet m�e
%mother = 'Morlet';
mother = 'DOG';
%mother = 'Paul';
 
%----------------- Computa��o num�rica ----------------% 

% Transformada Wavelet:
[wave,period,scale,coi] = waveletszn(sst,dt,pad,dj,s0,j1,mother);

% computa o espectro de pot�ncia da wavelet
cwtpower = (abs(wave)).^2;