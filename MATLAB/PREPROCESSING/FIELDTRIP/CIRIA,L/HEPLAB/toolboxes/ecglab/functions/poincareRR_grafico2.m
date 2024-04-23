function indices=poincareRR_grafico2(intervaloRR,minimo,maximo,precisaopct,pcts,sds,incl,reta)
%usage:

%clear

janela_plotagem=[60 45 390 390];

fig_largura=janela_plotagem(1)+janela_plotagem(3)+janela_plotagem(1)-40;
fig_altura=janela_plotagem(2)+janela_plotagem(4)+janela_plotagem(2)-15; %largura e altura da janela do programa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cria a tela do espectrograma
%
figure(101);close(101);
figure(101);clf;
set(101,'Position',[50,200,fig_largura,fig_altura],'Color',[.95 .95 .95])
axes('Units','pixels','Position',janela_plotagem);

ms=5; %tamanho do ponto

%cria os pontos do plot de poincare
RR2=intervaloRR(2:length(intervaloRR));
RR1=intervaloRR(1:length(intervaloRR)-1);
RR=RR1+j*RR2;

%calcula o ponto medio
RRmedio=mean(RR);

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% LONGITUDINAL
%
%%%%%%%%%%%%%%%%%%%%%%%%%

%calcula os coeficientes da reta m*x+b
%que mais se aproxima dos pontos
p=polyfit(real(RR),imag(RR),1);
coef_regr=p(1);
b=p(2);
eq_reta=[ 'RRn+1 = ' num2str(coef_regr) ' RRn + ' num2str(b) ];

%cria o vetor de base londituginal
if reta(1)=='r',
   vetorl=exp(j*atan(coef_regr)); %reta de regressao
else
   vetorl=(1+j)/abs(1+j); %reta de identidade
end

%calcula a componente de cada amostra nesse vetor
ipl=real(RR)*real(vetorl)+imag(RR)*imag(vetorl); 

%calcula o desvio longitudinal e a media no eixo l
sd2=std(ipl);
avl=mean(ipl);

%calcula os limites da reta longitudinal
minRRn=avl-sd2;
maxRRn=avl+sd2;

%calcula o componente do offset b em vetor-l
if reta(1)=='r',
	bl=imag(b*vetorl);
else
	bl=0;
end

%cria as retas longitudinais
if reta(1)=='r',
   retal=[0,3000]*vetorl+(j*b);
   retasdl=[minRRn-bl,maxRRn-bl]*vetorl+(j*b);
else
   retal=[0,3000]*vetorl;
   retasdl=[minRRn-bl,maxRRn-bl]*vetorl;
end

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% VERTICAL
%
%%%%%%%%%%%%%%%%%%%%%%%%%

%cria o vetor de base vertical (ortogonal)
vetorv=j*vetorl;

%calcula a componente de cada amostra nesse vetor
ipv=real(RR)*real(vetorv)+imag(RR)*imag(vetorv);

%calcula o desvio longitudinal e a media no eixo v
sd1=std(ipv);
avv=mean(ipv);

%calcula os limites da reta vertical
minRRn1=avv-sd1;
maxRRn1=avv+sd1;

%calcula o componente do offset b em vetor-v
if reta(1)=='r',
	bv=imag(b*vetorv);
else
	bv=0;
end

%cria as retas verticais
retasdv=[minRRn1-bv,maxRRn1-bv]*vetorv+RRmedio;

%%%%%%%%%%%%%%%%%%%%%%%%
%
% COEFICIENTES
%
%%%%%%%%%%%%%%%%%%%%%%%%

%faixa dinamica total
fdtotal=max(intervaloRR)-min(intervaloRR);

%coeficiente de correlacao
coef_corr=corrcoef(real(RR),imag(RR));
coef_corr=coef_corr(1,2);

%razao entre os desvios e area da elipse
rvl=sd1/sd2;
elipse=pi*sd1*sd2;

%acha os percentis
%pct10=2*round(prctile(real(RR),10)/2);
%pct25=2*round(prctile(real(RR),25)/2);
%pct50=2*round(prctile(real(RR),50)/2);
%pct75=2*round(prctile(real(RR),75)/2);
%pct90=2*round(prctile(real(RR),90)/2);
pct10=prctile(real(RR),10);
pct25=prctile(real(RR),25);
pct50=prctile(real(RR),50);
pct75=prctile(real(RR),75);
pct90=prctile(real(RR),90);

%acha a serie em cada percentil
rrpct10=(RR(find( real(RR)>=pct10-precisaopct & real(RR)<=pct10+precisaopct )));
rrpct25=(RR(find( real(RR)>=pct25-precisaopct & real(RR)<=pct25+precisaopct )));
rrpct50=(RR(find( real(RR)>=pct50-precisaopct & real(RR)<=pct50+precisaopct )));
rrpct75=(RR(find( real(RR)>=pct75-precisaopct & real(RR)<=pct75+precisaopct )));
rrpct90=(RR(find( real(RR)>=pct90-precisaopct & real(RR)<=pct90+precisaopct )));

%acha a parte imaginaria da serie em cada percentil
ypct10=imag(rrpct10);
ypct25=imag(rrpct25);
ypct50=imag(rrpct50);
ypct75=imag(rrpct75);
ypct90=imag(rrpct90);

%acha a estatisca no p10
pts10=length(ypct10);
if ~isempty(ypct10),
   max10=max(ypct10);
	min10=min(ypct10);
	faixa10=max10-min10;
	rdisp10=faixa10/fdtotal;
	mediana10=median(ypct10);
	media10=mean(ypct10);
	dp10=std(ypct10);
   cv10=100*dp10/media10;
else, max10=0;	min10=0;	faixa10=0;	rdisp10=0;	mediana10=0;	media10=0;	dp10=0;   cv10=0;
end

%acha a estatisca no p25
pts25=length(ypct25);
if ~isempty(ypct25),
   max25=max(ypct25);
	min25=min(ypct25);
	faixa25=max25-min25;
	rdisp25=faixa25/fdtotal;
	mediana25=median(ypct25);
	media25=mean(ypct25);
	dp25=std(ypct25);
   cv25=100*dp25/media25;
else, max25=0;	min25=0;	faixa25=0;	rdisp25=0;	mediana25=0;	media25=0;	dp25=0;   cv25=0;
end

%acha a estatisca no p50
pts50=length(ypct50);
if ~isempty(ypct50),
   max50=max(ypct50);
	min50=min(ypct50);
	faixa50=max50-min50;
	rdisp50=faixa50/fdtotal;
	mediana50=median(ypct50);
	media50=mean(ypct50);
	dp50=std(ypct50);
   cv50=100*dp50/media50;
else, max50=0;	min50=0;	faixa50=0;	rdisp50=0;	mediana50=0;	media50=0;	dp50=0;   cv50=0;
end

%acha a estatisca no p75
pts75=length(ypct75);
if ~isempty(ypct75),
   max75=max(ypct75);
	min75=min(ypct75);
	faixa75=max75-min75;
	rdisp75=faixa75/fdtotal;
	mediana75=median(ypct75);
	media75=mean(ypct75);
	dp75=std(ypct75);
   cv75=100*dp75/media75;
else, max75=0;	min75=0;	faixa75=0;	rdisp75=0;	mediana75=0;	media75=0;	dp75=0;   cv75=0;
end

%acha a estatisca no p90
pts90=length(ypct90);
if ~isempty(ypct90),
   max90=max(ypct90);
	min90=min(ypct90);
	faixa90=max90-min90;
	rdisp90=faixa90/fdtotal;
	mediana90=median(ypct90);
	media90=mean(ypct90);
	dp90=std(ypct90);
   cv90=100*dp90/media90;
else, max90=0;	min90=0;	faixa90=0;	rdisp90=0;	mediana90=0;	media90=0;	dp90=0;   cv90=0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PLOTAGEM
%
%%%%%%%%%%%%%%%%%%%%%%%%%

set(plot(RR,'b.'),'markersize',ms)
axis([minimo maximo minimo maximo])
hold on

if incl==1,
   set(plot(retal,'k-'),'LineWidth',1)
end

if sds==1,
set(plot(retasdv,'k-'),'LineWidth',2)
set(plot(retasdl,'k-'),'LineWidth',2)
set(plot(RRmedio,'g.'),'markersize',5) %para mostrar o centroid
end

if pcts==1,
   if ~isempty(ypct10),
      set(line([pct10;pct10],[min(ypct10);max(ypct10)]),'color',[1 0 0],'LineWidth',1,'linestyle',':'),
      set(plot(rrpct10,'r.'),'markersize',ms)
      set(plot(pct10+media10*j,'m+'),'markersize',10) %mostra a media do p10
      set(line([pct10;pct10],[media10-dp10;media10+dp10]),'color',[0 0 0],'LineWidth',2,'linestyle','-'),
   end
   if ~isempty(ypct25),
      set(line([pct25;pct25],[min(ypct25);max(ypct25)]),'color',[1 0 0],'LineWidth',1,'linestyle',':'),
      set(plot(rrpct25,'r.'),'markersize',ms)
      set(plot(pct25+media25*j,'m+'),'markersize',10) %mostra a media do p10
      set(line([pct25;pct25],[media25-dp25;media25+dp25]),'color',[0 0 0],'LineWidth',2,'linestyle','-'),
   end
   if ~isempty(ypct50),
      set(line([pct50;pct50],[min(ypct50);max(ypct50)]),'color',[1 0 0],'LineWidth',1,'linestyle',':'),
      set(plot(rrpct50,'r.'),'markersize',ms)
      set(plot(pct50+media50*j,'m+'),'markersize',10) %mostra a media do p50
      set(line([pct50;pct50],[media50-dp50;media50+dp50]),'color',[0 0 0],'LineWidth',2,'linestyle','-'),
   end
   if ~isempty(ypct75),
      set(line([pct75;pct75],[min(ypct75);max(ypct75)]),'color',[1 0 0],'LineWidth',1,'linestyle',':'),
      set(plot(rrpct75,'r.'),'markersize',ms)
      set(plot(pct75+media75*j,'m+'),'markersize',10) %mostra a media do p10
      set(line([pct75;pct75],[media75-dp75;media75+dp75]),'color',[0 0 0],'LineWidth',2,'linestyle','-'),
   end
   if ~isempty(ypct90),
      set(line([pct90;pct90],[min(ypct90);max(ypct90)]),'color',[1 0 0],'LineWidth',1,'linestyle',':'),
      set(plot(rrpct90,'r.'),'markersize',ms)
      set(plot(pct90+media90*j,'m+'),'markersize',10) %mostra a media do p90
      set(line([pct90;pct90],[media90-dp90;media90+dp90]),'color',[0 0 0],'LineWidth',2,'linestyle','-'),
   end
end

grid
hold off
title('Poincaré Plot of R-R Intervals'),
xlabel('RRn (ms)'),
ylabel('RRn+1 (ms)'),

quartil110=0;quartil310=0;
quartil125=0;quartil325=0;
quartil150=0;quartil350=0;
quartil175=0;quartil375=0;
quartil190=0;quartil390=0;

indices=[length(RR),RRmedio,sd1,sd2,rvl,elipse,coef_corr,coef_regr,b,...
			pct10,pts10,max10,min10,faixa10,rdisp10,quartil110,mediana10,quartil310,media10,dp10,cv10,...
			pct25,pts25,max25,min25,faixa25,rdisp25,quartil125,mediana25,quartil325,media25,dp25,cv25,...
			pct50,pts50,max50,min50,faixa50,rdisp50,quartil150,mediana50,quartil350,media50,dp50,cv50,...
			pct75,pts75,max75,min75,faixa75,rdisp75,quartil175,mediana75,quartil375,media75,dp75,cv75,...
			pct90,pts90,max90,min90,faixa90,rdisp90,quartil190,mediana90,quartil390,media90,dp90,cv90];