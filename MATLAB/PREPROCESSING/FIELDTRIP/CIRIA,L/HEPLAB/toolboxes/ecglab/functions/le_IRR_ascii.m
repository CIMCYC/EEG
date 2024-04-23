function [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR_ascii(filename)

%tamanho maximo da linha a ser lida
maxlenlinha=128;

%abre arquivo ascii
fid=fopen(filename,'r');

intervaloRR=[];linha=1;

%se conseguir abrir o arquivo ASCII
if fid~=-1,
  %le ate o final do texto
  while linha~=-1,
  % %le uma linha
    linha=fgetl(fid); %fegetl retornara -1 se nao tiver mais linha
    numero=[]; %limpa os digitos do intervalo
    passo=0; %passo 0: nenhum digito
  %  
  % %ve se é realmente um arquivo de sinal R-R (ve se a linha nao eh muito grande)
    if length(linha)>maxlenlinha,
  %
      intervaloRR=[];
      break; %sai do while (?)
  %    
    elseif length(linha)>0 & linha(1) ~= ';', %se nao eh linha comentada
  %    
  % % %le o intervalo daquela linha, letra por letra
      for c=1:length(linha), % c vai de 1 ate N letras
        letra=linha(c); %pega a c-esima letra
  % % %
    % % %ve se a letra eh -1 ou 'i' e faz igual a 'a' (???) 
        if letra==-1 | letra=='i',
           letra='a';
        end;
  % % % 
  % % % % se ainda nao leu o numero todo e a letra eh um numero
        if passo~=2 & ~isempty(str2num(letra)),
  % % %   %se ja esta construindo o numero e eh o ultimo digito da linha
          if passo==1 & c==length(linha),
            numero=[numero,letra]; %coloca o digito no numero
            intervaloRR=[intervaloRR,str2num(numero)]; %converte para inteiro e coloca no vetor de intervalos RR
            passo=2; %passo 2 - terminou este intervalo/linha
          else,
            passo=1; %proximo passo: passo 1 - construindo o numero, digito por digito
            numero=[numero,letra]; %adiciona o digito lido ao numero
          end;
  % % %
        %se ja comecou a construir o numero e encontrou uma letra que nao eh digito, entao acabou o numero
        elseif passo==1,
  % % %   %ve se nao era um numero referente a hora do dia
          if linha(c)~=':',
            intervaloRR=[intervaloRR,str2num(numero)]; %se nao era, converte para inteiro e coloca no vetor de intervalos RR
          end
          passo=2; %passo 2 - terminou este intervalo/linha
        end
  % % % 
      end %for (letra por letra)
  % %
    end %if linha nao muito grande
  %
  end %while (linha por linha)

  if isempty(intervaloRR)
    intervaloRR=-1;
    tempoRR=-1;
    verdadeiros=-1;
  else
    tempoRR=(1:length(intervaloRR))';
    tempoRR(1)=0;
    for i=2:length(intervaloRR),
      tempoRR(i)=tempoRR(i-1)+intervaloRR(i);
    end,
    tempoRR=round(1000*tempoRR)/1000/1000; %converte para segundos
    verdadeiros=1:length(intervaloRR);
  end
  ebs_indices=[];
  
  %fecha arquivo ascii
  fclose(fid);
   
  intervaloRR=intervaloRR';
  verdadeiros=verdadeiros';

else
  intervaloRR=-1;
  tempoRR=-1;
  verdadeiros=-1;
  ebs_indices=[];
end
