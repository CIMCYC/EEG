function ecg_ondar=ecglabRR_marca_ondar2(ecg_sinal,ecg_filtrado)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% inicializacao de constantes e variaveis
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% parametros da deteccao

%taxas de amostragem
global samplerate_ecg

%regiao de busca do pico da onda R
%(valor maior da mais imunidade a ruido)
regiao_de_busca=round(0.070*samplerate_ecg);

%nivel em que o ecg filtrado é considerado onda R
ganho_limiar=0.15; 

%periodo de comparacao: 2 segundos
limiar_comparacao=round(2*samplerate_ecg); 

%intervalo minimo entre marcacoes
%antes estava trabalhando com 350ms
salto_entre_pulsos=round(0.350*samplerate_ecg);

%busca ondas R de 10 em 10 msecs
salto_10msec=round(0.01*samplerate_ecg); 

%depois que acha o limiar, volta esse tanto
volta_amostras=round(0.030*samplerate_ecg);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%inicializacoes de variaveis
tamanho=length(ecg_sinal);
n=1;

%inicia ondasr com 'empty'
ondasr=[];
ecg_ondar=[];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Localiza as regioes onde estao as ondas R
%

%repete para cada onda R
while n<tamanho,
   
   %calcula o limiar para a onda R atual, baseado nos proximos 2 segundos
   %com ganho de 0.2 nao sao marcadas algumas ondas R no
   %sinal 124, posicao 300-336
   if (n+limiar_comparacao)<=tamanho,
		limiar=ganho_limiar*max(abs(ecg_filtrado(n:n+limiar_comparacao)));
   else
  	   limiar=ganho_limiar*max(abs(ecg_filtrado(tamanho-limiar_comparacao:tamanho))); 
   end
   
   %procura a regiao da onda R, se encontrar...
   if ( (ecg_filtrado(n)>limiar) & (n<tamanho) ),
      
      %guarda o indice inicial da regiao da onda R
      ondasr=[ondasr;n];
                           
      %salta uns 200 msecs para evitar novos	      
      %disparos neste mesmo pulso.
      n=n+salto_entre_pulsos;    
                                 
   %se nao foi encontrado, continua a busca de 10 em 10 msecs   
   else
      n=n+salto_10msec;
      %n=n+1;
   end
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Localiza, na regiao, o pico da onda R
%

%inicia constantes e variaveis
n=1;
num_marcas=length(ondasr);
marcas=[];

%filtra o sinal com um passa altas para retirar a oscilação da linha de base
[B,A]= butter(4,1/(samplerate_ecg/2),'high'); %cria um butterworth de w0 = 1 Hz;
ecg_filtrado=filtfilt(B,A,ecg_sinal); %filtfilt é uma filtragem de fase zero

%volta um trecho do sinal para buscar a onda R
ondasr=ondasr-volta_amostras;
if ondasr(1)<1,ondasr(1)=1;end;

%localiza os picos das ondas R
for i=1:num_marcas,
   
   %acha o pico da regiao
   if tamanho>=ondasr(i)+regiao_de_busca,
      [valor,marca]=max(abs(ecg_filtrado(ondasr(i):ondasr(i)+regiao_de_busca)));   
   else
      [valor,marca]=max(abs(ecg_filtrado(ondasr(i):tamanho)));
   end
      
   %calcula a posição da marca e guarda o valor
   marca=marca+ondasr(i)-1;
   ecg_ondar=[ecg_ondar;marca];
   
end

if isempty(ondasr),
   ecg_ondar=-1;
end
