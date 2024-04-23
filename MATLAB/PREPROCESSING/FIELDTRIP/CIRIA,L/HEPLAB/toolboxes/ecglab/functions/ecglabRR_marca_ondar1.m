function ecg_ondar=ecglabRR_marca_ondar1(ecg_sinal,ecg_filtrado)

global samplerate_ecg

salto_entre_pulsos=0.200*samplerate_ecg;
area_limiar=2*samplerate_ecg;
volta_amostras=0.160*samplerate_ecg;

tamanho=length(ecg_sinal);
ecg_temp=-1500*ones(tamanho,1);
ecg_sinal_aux=ecg_sinal;
n=1;
ecg_ondar=[];

%repete para cada onda R
while n<tamanho,
   maximo=0;
   indice=0;
   
   %calcula o limiar para a onda R atual, baseado nos proximos 2 segundos
   %com ganho de 0.2 nao sao marcadas algumas ondas R no sinal 124, posicao 300-336
   if (n+area_limiar)<=tamanho,
		limiar=0.15*max(abs(ecg_filtrado(n:n+area_limiar)));
   else
  	   limiar=0.15*max(abs(ecg_filtrado(tamanho-area_limiar:tamanho))); 
   end
   
   %procura a regiao da onda R
   while ( (ecg_filtrado(n)>limiar) & (n<tamanho) ),
      
      %encontra e memoriza a localizacao do ponto de maximo dentro dessa regiao
      if abs(ecg_filtrado(n))>maximo,
	      maximo=abs(ecg_filtrado(n));
         indice=n;
   	end
      n=n+1;
      
   end
   
   %se for encontrado o ponto de maximo, marca em um vetor a localizacao
   if indice~=0,
      ecg_temp(indice)=1;
      n=indice+salto_entre_pulsos; % salta 200 msec para evitar novos disparos neste mesmo pulso.
      %n=n+150;    % salta 150 amostras para evitar novos disparos neste mesmo pulso.
      
   %se nao foi encontrado, continua a busca na proxima amostra   
   else
      n=n+1;
   end
   
end

%calcula a media em regioes de 1 segundo (melhor fazer um passa baixas)
for kk=1:samplerate_ecg:tamanho-samplerate_ecg,
   ecg_sinal(kk:kk+samplerate_ecg-1) =...
      ecg_sinal(kk:kk+samplerate_ecg-1) - mean(ecg_sinal(kk:kk+samplerate_ecg-1));
end

atraso=volta_amostras; %volta 130ms e busca o maximo ate o ponto da marcacao
n=1;

%busca no vetor de marcacao as regioes ondem estao as
%onda R e encontra o ponto de maximo no vetor ECG
while n<=tamanho,
   maximo=0;
   indice=0;
   
   %se encontrar uma marcacao entre neste laco
   while ( (ecg_temp(n)==1) & (n<=tamanho) ),
      
      %volta, se possivel, até 130ms do sinal para a busca da onda R
      if (n-atraso)>0,
         inicio=n-volta_amostras;
      else
         inicio=1;   
      end
      
		%localiza o pico na regiao de 130ms e memoriza no vetor ondar
      [maximo,indice]=max(abs(ecg_sinal(inicio:n)));
      indice=fix(inicio+indice-1);
      ecg_ondar=[ecg_ondar;indice];
      n=n+1;   
   end
   n=n+1;
end

if isempty(ecg_ondar),
   ecg_ondar=-1;
end
