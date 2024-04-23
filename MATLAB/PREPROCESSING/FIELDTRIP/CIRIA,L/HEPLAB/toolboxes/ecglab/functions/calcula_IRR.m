function [intervaloRR, tempoRR]=calcula_IRR(ecg_ondar,segundos_sinal)
%usage: [intervaloRR, tempoRR]=calcula_IRR(ecg_ondar,segundos_sinal);

global samplerate_ecg

tempoRR=0;
intervaloRR=0;

if length(ecg_ondar)>1,

	%cria o eixo do tempo
   tempo=0:1/samplerate_ecg:segundos_sinal-1/samplerate_ecg;

   %transforma as marcacoes em msec
   tempoRR=round(1000*tempo(ecg_ondar));
      
   %calcula os intervalos R-R
   RR=tempoRR(1:length(tempoRR)-1);
   RR1=tempoRR(2:length(tempoRR));
   intervaloRR=RR1-RR;
   
   %transforma em segundos (a primeira marcacao nao é intervalo)
	tempoRR=tempoRR(2:length(tempoRR))/1000;
   
   %arredonda os intervalos R-R
   intervaloRR=round(intervaloRR);

else   
   intervaloRR=-1;
   tempoRR=-1;
end

