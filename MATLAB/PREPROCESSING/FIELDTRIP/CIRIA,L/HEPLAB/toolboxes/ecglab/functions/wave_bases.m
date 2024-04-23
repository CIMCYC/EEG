% WAVE_BASES  Funcoes Morlet, Paul, e DOG para wavelets
%
%  [DAUGHTER,FOURIER_FACTOR,COI,DOFMIN] = ...
%      wave_bases(MOTHER,K,SCALE,PARAM);
%
%   Calcula a funçao wavelet como uma funçao da frequencia de Fourier,
%   usada na transformada wavelet no espaço de Fourier.
%   (Este programa eh chamado automaticamente por WAVELET)
%
% ENTRADAS:
%
%    MOTHER = um string, igual a 'MORLET' or 'PAUL' or 'DOG'
%    K = um vetor, as frequencias de Fourier nas quais vai-se calcular a wavelet
%    SCALE = a escala wavelet
%    PARAM = o parametro nao-dimensional para a funcao wavelet
%
% SAIDAS:
%
%    DAUGHTER = um vetor, a funçao wavelet
%    FOURIER_FACTOR = a relaçao do periodo de Fourier para a escala
%    COI = o tamanho do cone-of-influence na escala
%    DOFMIN = graus de liberdade para cada ponto no espectro de potencia da wavelet
%             (2 para Morlet e Paul, e 1 para DOG)
%
%----------------------------------------------------------------------------
function [daughter,fourier_factor,coi,dofmin] = ...
	wave_bases(mother,k,scale,param);

mother = upper(mother);
n = length(k);

if (strcmp(mother,'MORLET'))  %-----------------------------------  Morlet
    if (param == -1), param = 6.;, end
	k0 = param;
	expnt = -(scale.*k - k0).^2/2.*(k > 0.);
	norm = sqrt(scale*k(2))*(pi^(-0.25))*sqrt(n);    % energia total=N   
	daughter = norm*exp(expnt);
	daughter = daughter.*(k > 0.);     % Heaviside step function
	fourier_factor = (4*pi)/(k0 + sqrt(2 + k0^2)); % Escala-->Fourier
	coi = fourier_factor/sqrt(2);                  % Cone-of-influence 
	dofmin = 2;                                    % graus de liberdade
elseif (strcmp(mother,'PAUL'))  %--------------------------------  Paul
    if (param == -1), param = 4.;, end
	m = param;
	expnt = -(scale.*k).*(k > 0.);
	norm = sqrt(scale*k(2))*(2^m/sqrt(m*prod(2:(2*m-1))))*sqrt(n);
	daughter = norm*((scale.*k).^m).*exp(expnt);
	daughter = daughter.*(k > 0.);     % Heaviside step function
	fourier_factor = 4*pi/(2*m+1);
	coi = fourier_factor*sqrt(2);
	dofmin = 2;
elseif (strcmp(mother,'DOG'))  %--------------------------------  DOG
    % original, param = 2.
    if (param == -1), param = 10.;, end
	m = param;
	expnt = -(scale.*k).^2 ./ 2.0;
	norm = sqrt(scale*k(2)/gamma(m+0.5))*sqrt(n);
	daughter = -norm*(i^m)*((scale.*k).^m).*exp(expnt);
	fourier_factor = 2*pi*sqrt(2./(2*m+1));
	coi = fourier_factor/sqrt(2);
	dofmin = 1;
else
	error('Mother deve ser MORLET,PAUL ou DOG')
end

return
