function handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, handle, segundos_janela, main_window)

%apaga os plots anteriores
if handle(1)~=-1,
   delete(handle(1));
   delete(handle(2));   
end

posicao1=[80 480 890 200];
posicao2=[80 220 890 200];

len=size(ecg2canais);len=len(1);

%cria o eixo inteiro do tempo
tempo=0:1/samplerate:(len-1)/samplerate;

%calcula numero de segundos e de amostras do segmento
segundo=segundo+1/samplerate;
janela=floor(segundos_janela*samplerate);

%insere um zero depois da ultima amostra
ecg2canais=[ecg2canais;0 0];

%delimita os sinais à regiao plotada
ss=round(segundo*samplerate);
ecg2canais=ecg2canais(ss:ss+janela,:);

%cria eixo do tempo
t=segundo-1/samplerate:1/samplerate:segundo+segundos_janela-1/samplerate;

%cria o handle da regiao do plot
handle1=axes('Units','pixels','Position',posicao1);
plot(t,ecg2canais(:,1),'b-');
grid
axis([t(1) t(length(t)) -1 1])
ylabel('normalized amplitude')


handle2=axes('Units','pixels','Position',posicao2);
plot(t,ecg2canais(:,2),'b-');
grid
axis([t(1) t(length(t)) -1 1])
xlabel(['                                                                               ',...
        '                                                                   ',...
        '                                                        time (seconds)'])
ylabel('normalized amplitude')

handle=[handle1,handle2];