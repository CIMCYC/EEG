% WAVELETSZN  Transformada de Wavelet
%
%   [WAVE,PERIOD,SCALE,COI] = waveletszn(Y,DT,PAD,DJ,S0,J1,MOTHER,PARAM)
%
%   Computa a transformada wavelet do vetor Y (comprimento N),
%   com taxa de amostragem DT.
%
%   Por default, a wavelet de Morlet (k0=6) eh usada.
%   A base da wavelet eh normalizada de maneira a que a energia total seja 1 em todas as escalas.
%
%
% ENTRADAS:
%
%    Y = a serie temporal de comprimento N.
%    DT = intervalo de tempo entre cada valor de Y, isto eh, o periodo de amostragem.
%
% SAIDAS:
%
%    WAVE eh a transformada WAVELET de Y. Esta eh uma matriz complexa
%    de dimensoes (N,J1+1). FLOAT(WAVE) nos dah a amplitude da WAVELET,
%    ATAN(IMAGINARY(WAVE),FLOAT(WAVE) nos dah a fase da WAVELET.
%    O espectro de potencia da WAVELET eh ABS(WAVE)^2.
%    Suas unidades sao sigma^2 (a variancia da serie temporal).
%
%
% ENTRADAS OPCIONAIS:
% 
% *** Nota *** definindo qualquer uma das seguintes variaveis como -1 farah com que 
%               o valor default seja usado.
%
%    PAD = se definido como 1 (o default eh 0), faz o padding da serie temporal com zeros suficientes 
%         para obter N ateh a proxima potencia de 2. Isto evita o wraparound
%         do final da serie temporal com o comeco, e tambem
%         acelera a FFT usada para o calculo da transormada wavelet.
%         Isto nao elimina todos os artefatos (veja o COI abaixo).
%
%    DJ = espaco entre escalas discretas. O default eh 0.25.
%         Um numero menor dara melhor resolucao escalar, mas sera mais lenta para plotar.
%
%    S0 = a menor escala da wavelet.  O default eh 2*DT.
%
%    J1 = o numero de escalas menos 1. Escalas variam de S0 ateh S0*2^(J1*DJ),
%        o que da um total de (J1+1) escalas. O default eh J1 = (LOG2(N DT/S0))/DJ.
%
%    MOTHER = a wavelet mae.
%             As opcoes sao 'MORLET', 'PAUL', e 'DOG'
%
%    PARAM = o parametro da wavelet mae.
%            Para 'MORLET' eh k0 (wavenumber), o default eh 6.
%            Para 'PAUL' eh m (order), o default eh 4.
%            Para 'DOG' eh m (m-esima derivada), default eh 2.
%
%
% SAIDAS OPCIONAIS:
%
%    PERIOD = o vetor de periodos "Fourier" (em unidades de tempo) que corresponde as escalas
%
%    SCALE = o vetor de indices de escala, dados por S0*2^(j*DJ), j=0...J1
%            onde J1+1 eh o numero total de escalas.
%
%    COI = se especificado, retorna o Cone-of-Influence, que eh um vetor
%        de N pontos que contem o periodo maximo de informacao util
%        num instante em particular.
%        Periodos maiores que isso estao sujeitoa a artifatos.
%
%----------------------------------------------------------------------------
function [wave,period,scale,coi] = ...
	waveletszn(Y,dt,pad,dj,s0,J1,mother,param);

if (nargin < 8), param = -1;, end
if (nargin < 7), mother = -1;, end
if (nargin < 6), J1 = -1;, end
if (nargin < 5), s0 = -1;, end
if (nargin < 4), dj = -1;, end
if (nargin < 3), pad = 0;, end
if (nargin < 2)
	error('A entrada deve conter um vetor Y e o periodo de amostragem DT')
end

n1 = length(Y);

if (s0 == -1), s0=2*dt;, end
if (dj == -1), dj = 1./4.;, end
if (J1 == -1), J1=fix((log(n1*dt/s0)/log(2))/dj);, end
if (mother == -1), mother = 'MORLET';, end

%....constroi a serie temporal para analise, faz o padding se for preciso
x(1:n1) = Y - mean(Y);
if (pad == 1)
	base2 = fix(log(n1)/log(2) + 0.4999);    % potencia de 2 mais proxima de N
	x = [x,zeros(1,2^(base2+1)-n1)];
end
n = length(x);

%....constroi matriz de wavenumber usada na transformada 
k = [1:fix(n/2)];
k = k.*((2.*pi)/(n*dt));
k = [0., k, -k(fix((n-1)/2):-1:1)];

%....calcula a FFT de serie temporal com padding
f = fft(x);    

%....constroi matriz SCALE e limpa as matrizes PERIOD & WAVE
scale = s0*2.^((0:J1)*dj);
period = scale;
wave = zeros(J1+1,n);  % define a matriz wavelet
wave = wave + i*wave;  % passa para complexo

% Faz o loop em todas as escalas e computa a transformada
for a1 = 1:J1+1
	[daughter,fourier_factor,coi,dofmin] = wave_bases(mother,k,scale(a1),param);	
	wave(a1,:) = ifft(f.*daughter);  % transformada wavelet
end

period = fourier_factor*scale;
coi = coi*dt*[1E-5,1:((n1+1)/2-1),fliplr((1:(n1/2-1))),1E-5];  % COI
wave = wave(:,1:n1);  % retira o padding antes de retornar

return
