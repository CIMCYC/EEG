function [ecg_sinal, ecg_eventos, ecg_ondar,ebs_indices,...
      ecg_totalsamples,segundos_sinal, janelas]=ecglabRR_abrir(filename,segundos_janela);

global samplerate_ecg

% tenta abrir o arquivo .mat
ponto=find(filename=='.');filenamemat=[filename(1:ponto(length(ponto))-1),'.mat']; %adapta a extensao
load(filenamemat,'ecg','fs');
if exist('ecg')==1 & exist('fs')==1, %o arquivo .mat deve conter um sinal chamado ecg e a taxa amostragem (fs)
    ecg_sinal = double(ecg);
    ecg_totalsamples = length(ecg);
    ecg_eventos = [];
    samplerate_ecg = double(fs);
    ecg_sinal = ecg_sinal - mean(ecg_sinal);
    ecg_sinal = ecg_sinal/max(abs(ecg_sinal));
else,
    %tenta abrir o arquivo de ECG
    [ecg_sinal, ecg_eventos, ecg_totalsamples]=le_sinal(filename);
end;
    
%se conseguir abrir
if ecg_totalsamples>=0,
   
   %a ser apagado (fins de teste)
   %ecg_eventos=[ecg_eventos;4.05;56.002;105.7;205.8]
   
   %salva os eventos no disco
	salva_eventos(ecg_eventos,filename);
   
   %calcula o tempo de sinal e o numero de janelas
   segundos_sinal=length(ecg_sinal)/samplerate_ecg;
   janelas=ceil(segundos_sinal/segundos_janela);
   
   %tenta abrir o arquivo .onr (com as marcacoes R-R)
   ecg_ondar=le_ondar(filename);
   
   %le batimentos ectopicos marcados
   ebs_indices=ecglabRR_le_ebs(filename,segundos_sinal);
   
%se nao conseguir abrir o arquivo ECG, atribui -1 as demais variaveis
elseif ecg_totalsamples==-1,
   segundos_sinal=-1;
   janelas=-1;   
   ecg_ondar=[];
   ebs_indices=[];
end,

