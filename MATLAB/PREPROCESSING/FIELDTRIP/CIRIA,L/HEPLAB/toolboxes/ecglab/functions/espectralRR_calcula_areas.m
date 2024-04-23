function [aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf,lf,hf)
%usage: 
% INPUTS
%	PSD: espectro do intervalo R-R (DFT ou AR)
%	F: eixo das frequencias
%	maxF: frequencia maxima (fs/2)
%	vlf: limite das frequencias muito baixas
%	lf: limite das frequencias baixas
%	hf: limite das frequencias altas
%
% OUTPUTS
%	aavlf: area absoluta das frequencias muito baixas
%	aalf: area absoluta das frequencias baixas
%	aahf: area absoluta das frequencias altas
%  aatotal: area absoluta total
%  avlf: area relativa (%) das freq. muito baixas
%  alf: area relativa (%) das freq. baixas
%  ahf: area relativa (%) das freq. altas
%  rlfhf: razao BF/AF
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% busca os indices dos valores de frequencia
%

%calcula o numero de pontos do espectro
N=length(PSD);

%calcula a frequencia maxima
maxF=F(2)*N;

%
if hf>F(end),
   hf=F(end);
	if lf>hf,
      lf=F(end-1);
      if vlf>lf,
   		vlf=F(end-2);
		end
	end
end

%calcula o ponto de limite de cada banda
indice_vlf=round(vlf*N/maxF)+1;
indice_lf=round(lf*N/maxF)+1;
indice_hf=round(hf*N/maxF)+1;
if indice_hf>N,indice_hf=N;end

% calcula a energia total (de 0 a hf2) em ms^2
aatotal=F(2)*sum(PSD(1:indice_hf-1));

%calcula a energia de freq. muito baixas (de 0 a vlf2)
aavlf=F(2)*sum(PSD(1:indice_vlf-1));

%calcula a area de baixas frequencias (de vlf2 a lf2)
aalf=F(2)*sum(PSD(indice_vlf:indice_lf-1));

%calcula a area de altas frequencias (de lf2 a hf2)
aahf=F(2)*sum(PSD(indice_lf:indice_hf-1));

%calcula as areas relativas (%) e a razao BF/AF
avlf=aavlf/aatotal;
alf=aalf/aatotal;
ahf=aahf/aatotal;
rlfhf=aalf/aahf;

%calcula as areas normalizadas
anlf=aalf/(aalf+aahf);
anhf=aahf/(aalf+aahf);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%limita as casas decimais
%

% porcentagem, com 3 casas decimal
avlf=round(avlf*100000)/1000;
alf=round(alf*100000)/1000;
ahf=round(ahf*100000)/1000;
anlf=round(anlf*100000)/100000;
anhf=round(anhf*100000)/100000;

% 4 casas decimais
rlfhf=round(rlfhf*10000)/10000;