function handle=ecgfilt_plotasinal(sinal, eventos, segundos, handle,segundos_janela,main_window)
% PLOTASINAL plota um trecho do sinal indicado
% usage: handle=ecgfilt_plotasinal(sinal, eventos, segundos, handle,segundos_janela,main_window)
% 	sinal=vetor com as amostras
%  eventos=vetor com os indices dos eventos
%	segundos=um numero entre 0 e o numero de segundos
%  segundos_janela=tamanho da janela de plotagem em segudos
%  handle=handle para o axes onde foi plotado
%  main_window=handle da janela principal

%apaga o plot anterior
if handle~=-1,
   delete(handle);
end

%pega as constantes (taxa de amostragem)
global samplerate_ecg

samplerate=samplerate_ecg;
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

plot(t,sinal,'b-');
eventos_linhas=line([eventos'; eventos'],[-1000*ones(1,length(eventos)); 1000*ones(1,length(eventos))]);
set(eventos_linhas,'Color',[.9 0 .3],'LineStyle','-')
  
grid
axis([t(1) t(length(t)) -1 1])
xlabel(['                                                                                                ',...
    '                                                                                        time (seconds)'])
ylabel('normalized amplitude')

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
