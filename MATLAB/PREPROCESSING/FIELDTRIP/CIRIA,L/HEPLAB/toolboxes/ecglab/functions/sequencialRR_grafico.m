function [handle,indices]=sequencialRR_grafico(intervaloRR,eixo,handle)
% usage:

janela_plotagem=[100 130 550 550];

%calcula as variacoes de intervalo
RR3=intervaloRR(3:length(intervaloRR));
RR2=intervaloRR(2:length(intervaloRR)-1);
RR1=intervaloRR(1:length(intervaloRR)-2);

%coloca os pontos no plano atraves de uma modelagem complexa
deltaRR=(RR2-RR1)+j*(RR3-RR2);

%calcula a "fase" de cada ponto (angulo)
angulo=angle(deltaRR);

%conta o numero de pontos em cada quadrante a partir da fase
q1=length(find(angulo>0 & angulo< pi/2));
q2=length(find(angulo>pi/2 & angulo< pi));
q3=length(find(angulo>-pi & angulo<-pi/2));
q4=length(find(angulo> -pi/2 & angulo<0));

%conta o numero de pontos em cada linha
l1=length(find(angulo==0));
l2=length(find(angulo==pi/2));
l3=length(find(angulo==pi));
l4=length(find(angulo==-pi/2));

%acha o numero de pontos na origem
centro=length(find(deltaRR==0));
l1=l1-centro; %corrige a linha 1

%acha o total de diferencas nulas
difnulas=l1+l2+l3+l4+centro;
difnaonulas=q1+q2+q3+q4;

%calcula a porcentagem e o numero total de pontos
total=length(angulo);
pq1=round(1000*q1/total)/10;
pq2=round(1000*q2/total)/10;
pq3=round(1000*q3/total)/10;
pq4=round(1000*q4/total)/10;
pl1=round(1000*l1/total)/10;
pl2=round(1000*l2/total)/10;
pl3=round(1000*l3/total)/10;
pl4=round(1000*l4/total)/10;
pcentro=round(1000*centro/total)/10;
pdifnulas=round(1000*difnulas/total)/10;
pdifnaonulas=round(1000*difnaonulas/total)/10;

indices=[q1 pq1 q2 pq2 q3 pq3 q4 pq4 l1 pl1 l2 pl2 l3 pl3 l4 pl4 centro pcentro total difnulas pdifnulas difnaonulas pdifnaonulas];

%cria uma espaco para plotagem na janela
if handle~=-1,
   delete(handle);
end

handle=axes('Units','pixels','Position',janela_plotagem);

set(plot(real(deltaRR),imag(deltaRR),'r.'),'markersize',14),grid
set(line([-eixo;eixo],[0;0]),'color',[0 0 0])
set(line([0;0],[-eixo;eixo]),'color',[0 0 0])
axis([-eixo eixo -eixo eixo]),
%grid,
title('Sequential Trend Analysis of R-R Intervals'),
xlabel('diffRRn (ms)'),
ylabel('diffRRn+1 (ms)'),
set(text(eixo-0.2*eixo, eixo-0.1*eixo, '+/+'),'FontName','Courier')
set(text(-(eixo-0.1*eixo), eixo-0.1*eixo, '-/+'),'FontName','Courier')
set(text(-(eixo-0.1*eixo), -(eixo-0.1*eixo), '-/-'),'FontName','Courier')
set(text(eixo-0.2*eixo, -(eixo-0.1*eixo), '+/-'),'FontName','Courier')
%text(1, 140, 'atividade parassimpática')
%text(-110, -140, 'atividade simpática')
%text(60,120,[num2str(q1) ' pts, ' num2str(p1) '%'])
%text(-120,120,[num2str(q2) ' pts, ' num2str(p2) '%'])
%text(-120,-120,[num2str(q3) ' pts, ' num2str(p3) '%'])
%text(60,-120,[num2str(q4) ' pts, ' num2str(p4) '%'])