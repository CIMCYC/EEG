function handle=ecglabRR_plotasinal(sinal, eventos, ondar, ebs_indices, segundos, signaltype,handle,segundos_janela,main_window)
% PLOTASINAL plota um trecho do sinal indicado
% usage: handle=ecglabRR_plotasinal(sinal, eventos, ondar, indicedossegundos, signaltype,handle,segundos_janela,main_window)
% 	sinal=vetor com as amostras
%  eventos=vetor com os indices dos eventos
%  ondar=vetor com a onda R marcada
%	segundos=um numero entre 0 e o numero de segundos
%  signaltype=pode ser 'ecg' ou 'rsp'
%  handle=handle para o axes onde foi plotado
%  main_window=handle da janela principal

%apaga o plot anterior
if handle~=-1,
   delete(handle);
end

%pega as constantes (taxa de amostragem)
global samplerate_ecg

samplerate=samplerate_ecg;
%titulo='Batimento Cardiaco';
posicao=[80 220 890 470];

%cria o eixo inteiro do tempo
tempo=0:1/samplerate:(length(sinal)-1)/samplerate;

%calcula numero de segundos e de amostras do segmento
segundos=segundos+1/samplerate;
janela=floor(segundos_janela*samplerate);

%insere um zero depois da ultima amostra
sinal=[sinal;0];

%delimita os sinais à regiao plotada
ss=round(segundos*samplerate);
ecg=sinal;
sinal=sinal(ss:ss+janela);

%cria eixo do tempo
t=segundos-1/samplerate:1/samplerate:segundos+segundos_janela-1/samplerate;

%cria o handle da regiao do plot
handle=axes('Units','pixels','Position',posicao);

%plota o sinal, os eventos e a marcacao R-R
if signaltype=='ecg',
   
   if isempty(ondar),
      plot(t,sinal,'b-');
      indices_r=[];
   else   
      indices_r=ondar; ondar=-1500*ones(length(ecg),1);
      ondar(indices_r)=ecg(indices_r);	ondar=ondar(ss:ss+janela);
      
      indices_ebs=ebs_indices; ebs_indices=-1500*ones(length(ecg),1);
      ebs_indices(indices_ebs)=ecg(indices_ebs); ebs_indices=ebs_indices(ss:ss+janela);
      
      plot(t,ebs_indices,'ko',t,sinal,'b-',t,ondar,'r.');
   end
	eventos_linhas=line([eventos'; eventos'],[-1000*ones(1,length(eventos)); 1000*ones(1,length(eventos))]);
   set(eventos_linhas,'Color',[.9 0 .3],'LineStyle','-')
   
   
   %mostra os indices dos intervalos
   [intervaloRR, tempoRR]=calcula_IRR(indices_r,length(ecg)*1/samplerate_ecg);
   if intervaloRR(1)~=-1,
      
      %encontra ondas R dentro da janela
      mostrar=find(tempoRR>=t(1) & tempoRR<=t(length(t)));
      indices_r_aux=indices_r(mostrar);
      tempoRR=tempoRR(mostrar);
      intervaloRR=intervaloRR(mostrar);
      
      %so mostra o valor dos intervalos para janelas de 10 segundos ou menos
   	if segundos_janela <=10,
         for i=1:length(intervaloRR),
            xRR=tempoRR(i);
            yRR=ecg(indices_r(mostrar(1)+i));
            textoRR=sprintf([  num2str(intervaloRR(i))  '[' num2str(mostrar(1)+i-1) ']-'  ]);
            h=text(xRR,yRR,textoRR);
            set(h,'fontname','Courier New','fontsize',9,'HorizontalAlignment','right','verticalalignment','middle')
   	   end
      end
   end
   
else
   plot(t,sinal,'r-')
end
grid
axis([t(1) t(length(t)) -1 1])
xlabel(['                                                                  ',...
    '                                                                     ',...
    '                                              time (seconds)'])
ylabel('normalized amplitude')
%title(titulo)

%  		   y     yellow        .     point              -     solid
%           m     magenta       o     circle             :     dotted
%           c     cyan          x     x-mark             -.    dashdot 
%           r     red           +     plus               --    dashed   
%           g     green         *     star
%           b     blue          s     square
%           w     white         d     diamond
%           k     black         v     triangle (down)
%                               ^     triangle (up)
%                               <     triangle (left)
%                               >     triangle (right)
%                               p     pentagram
%                               h     hexagram
