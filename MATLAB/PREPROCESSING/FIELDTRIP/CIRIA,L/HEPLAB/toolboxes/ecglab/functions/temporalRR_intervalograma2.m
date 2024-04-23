function temporalRR_intervalograma2(tempoRR,intervaloRR,eventos,abscissa,eixox1,eixox2,eixoy1,eixoy2)
%usage:

corirr='b';
janela_plotagem_irr=[55 45 584 320];
fig_largura=janela_plotagem_irr(1)+janela_plotagem_irr(3)+janela_plotagem_irr(1)-40;
fig_altura=janela_plotagem_irr(2)+janela_plotagem_irr(4)+janela_plotagem_irr(2)-15; %largura e altura da janela do programa

if abscissa=='beat',
   unidade_eixox='intervals';
   label_eixox='R-R interval number';
   if(isempty(eixox1)), eixox1=1; end,
   if(isempty(eixox2)), eixox2=length(intervaloRR); end,
else
   unidade_eixox='seconds';
   label_eixox='time (seconds)';
   if(isempty(eixox1)), eixox1=min(tempoRR); end,
   if(isempty(eixox2)), eixox2=max(tempoRR); end,
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cria a tela do intervalograma
%
figure(101);close(101);
figure(101);clf;
set(101,'Position',[50,200,fig_largura,fig_altura],'Color',[.95 .95 .95])
axes('Units','pixels','Position',janela_plotagem_irr);

%interpola valores de tempo onde ha batimentos ectopicos
trs=find(tempoRR~=0);
if tempoRR(1)==0,trs=[1;trs];end,
tempoRR=spline(trs,tempoRR(trs),1:length(tempoRR));
tempoRR=tempoRR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% plotagem do intervalograma
%


if abscissa=='time',
   plot(tempoRR,intervaloRR,corirr);
elseif abscissa=='beat',
   plot(intervaloRR,corirr);
else
   plot(tempoRR,intervaloRR,corirr);
   eventos_linhas=line([eventos'; eventos'],[eixoy1*ones(1,length(eventos)); eixoy2*ones(1,length(eventos))]);
   set(eventos_linhas,'Color',[0 .75 0],'LineStyle','-')
end,
axis([eixox1 eixox2 eixoy1 eixoy2]);
title('Intervalogram'),
xlabel(label_eixox),
ylabel('R-R interval (milliseconds)'),
grid,