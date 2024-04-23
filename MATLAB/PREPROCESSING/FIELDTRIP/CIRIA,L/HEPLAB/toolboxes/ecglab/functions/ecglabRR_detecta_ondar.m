function [ecg_ondar,ebs_indices]=ecglabRR_detecta_ondar(ecg_sinal,algoritmo)
%usage: [ecg_ondar,ebs_indices]=ecglabRR_detecta_ondar(ecg_sinal,algoritmo);
%
% ebs_indices é a posicao no tempo dos batimentos ectopicos
%

global samplerate_ecg

%filtra em 17Hz
	ecg_filtrado=ecglabRR_filtra17hz(ecg_sinal,3,1.2); %filtra17hz(sinal,Q,ganho)
   
%deriva
	%ecg_filtrado=1/8*filter([2 1 -1 -2],1,ecg_filtrado); %[1 -1]; %esta equacao esta errada

%derivada
	ecg_filtrado=filter([1 -1],1,ecg_filtrado);
%passa baixas 30 Hz (para nao enriquecer ruido)
	[B,A]=butter(8,30/(samplerate_ecg/2));
   ecg_filtrado=filter(B,A,ecg_filtrado);
   ecg_filtrado = ecg_filtrado /max(abs(ecg_filtrado)); %ganho

%eleva ao quadrado
	ecg_filtrado=ecg_filtrado.^2;


%integrador (janela movel)
	N=round(0.150*samplerate_ecg); ecg_filtrado=1/N*filter(ones(1,N),1,ecg_filtrado);
   
%localiza, dentro das picos do sinal integrado, o ponto de maximo do sinal ecg   
if algoritmo=='1',
   ecg_ondar=ecglabRR_marca_ondar1(ecg_sinal,ecg_filtrado);
else
   ecg_ondar=ecglabRR_marca_ondar2(ecg_sinal,ecg_filtrado);
end

% segundos=(length(ecg_sinal)+1)/samplerate_ecg;
% %clear('ecg_sinal')
% %clear('ecg_filtrado')
% 
% [intervaloRR, tempoRR]=calcula_IRR(ecg_ondar,segundos);
% ebs_indices=ectopics_marcaebs(intervaloRR,tempoRR);
% tRR_ebs=round(tempoRR(ebs_indices)*1000);
% ebs_indices=[];
% t=round((0:1/samplerate_ecg:segundos-1/samplerate_ecg)'*1000);
% for k=1:length(tRR_ebs),
%    ebs_indices=[ebs_indices;find(t==tRR_ebs(k))];
% end,
ebs_indices=[];

%ecg_eventos=1/10000*ecg_filtrado; 
%begin=92.6;x=begin*500+1:begin*500+1*500;t=x/500;hand=gcf;figure(17),
%ecg_sinal=ecg_sinal(x)/max(abs(ecg_sinal(x)));ecg_filtrado=ecg_filtrado(x)/max(abs(ecg_filtrado(x)));
%plot(t,ecg_sinal,'b-',t,ecg_filtrado,'g-'),axis([min(t) max(t) min(ecg_sinal) max(ecg_sinal)]),figure(hand)
%,t,ecg_ondar(x)
   
