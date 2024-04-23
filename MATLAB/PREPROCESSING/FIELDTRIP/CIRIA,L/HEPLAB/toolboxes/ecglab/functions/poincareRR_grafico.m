function [indices,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,minimo,maximo,precisaopct,handle,pcts,sds,incl,reta)
%usage:

%clear

janela_plotagem=[60 130 550 550];

%cria uma espaco para plotagem na janela
if handle~=-1,
   delete(handle);
end

handle=axes('Units','pixels','Position',janela_plotagem);

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
rrpct10=RR(find( real(RR)>=pct10-precisaopct & real(RR)<=pct10+precisaopct ));
rrpct25=RR(find( real(RR)>=pct25-precisaopct & real(RR)<=pct25+precisaopct ));
rrpct50=RR(find( real(RR)>=pct50-precisaopct & real(RR)<=pct50+precisaopct ));
rrpct75=RR(find( real(RR)>=pct75-precisaopct & real(RR)<=pct75+precisaopct ));
rrpct90=RR(find( real(RR)>=pct90-precisaopct & real(RR)<=pct90+precisaopct ));

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

indices=sprintf([...
      'Poincaré Plot Statistics\n',...
      '------------------------\n\n\n',...
      'Number of Points: ',num2str(length(RR)),'\n\n',...
		'Centroid: (',num2str(real(RRmedio)),',',num2str(imag(RRmedio)),') ms\n\n\n',...
   	'Vertical Deviation (SD1): ',num2str(sd1),' ms \n\n',...
      'Longitudinal Deviation (SD2): ',num2str(sd2),' ms \n\n\n',...
      'SD1/SD2 Ratio: ',num2str(rvl),'\n\n',...
      'Area of Ellipse: ',num2str(elipse),' ms²\n\n\n',...
      'Correlation Coefficient: ',num2str(coef_corr),'\n\n',...
   	'Regression Coefficient: ',num2str(coef_regr),'\n\n\n',...
      'Regression Line Equation:\n\n        ',eq_reta,'\n\n',...
   ]);      

pct102550table=sprintf([...
   	'Percentile 10: ',num2str(pct10),' ms \n',...
      '  -Number of Points: ',num2str(pts10),'\n',...
   	'  -Maximum: ',num2str(max10),' ms \n',...
      '  -Minimum: ',num2str(min10),' ms \n',...
      '  -Dynamic Range: ',num2str(faixa10),' ms \n',...
      '  -Dispersion Ratio: ',num2str(rdisp10),'  \n',...      '  -1o Quartil: ',num2str(quartil110),' ms \n',...
      '  -Median: ',num2str(mediana10),' ms \n',...      '  -3o Quartil: ',num2str(quartil310),' ms \n',...
      '  -Mean: ',num2str(media10),' ms \n',...
   	'  -Standard Deviation: ',num2str(dp10),' ms \n',...
   	'  -Coefficient of Variation: ',num2str(cv10),' %% \n\n',...
   	'Percentile 25: ',num2str(pct25),' ms \n',...
      '  -Number of Points: ',num2str(pts25),'\n',...
      '  -Maximum: ',num2str(max25),' ms \n',...
      '  -Minimum: ',num2str(min25),' ms \n',...
      '  -Dynamic Range: ',num2str(faixa25),' ms \n',...
      '  -Dispersion Ratio: ',num2str(rdisp25),'  \n',...      '  -1o Quartil: ',num2str(quartil125),' ms \n',...
      '  -Median: ',num2str(mediana25),' ms \n',...      '  -3o Quartil: ',num2str(quartil325),' ms \n',...
      '  -Mean: ',num2str(media25),' ms \n',...
   	'  -Standard Deviation: ',num2str(dp25),' ms \n',...
   	'  -Coefficient of Variation: ',num2str(cv25),' %% \n\n',...
   	'Percentile 50: ',num2str(pct50),' ms \n',...
      '  -Number of Points: ',num2str(pts50),'\n',...
      '  -Maximum: ',num2str(max50),' ms \n',...
      '  -Minimum: ',num2str(min50),' ms \n',...
      '  -Dynamic Range: ',num2str(faixa50),' ms \n',...
      '  -Dispersion Ratio: ',num2str(rdisp50),'  \n',...      '  -1o Quartil: ',num2str(quartil150),' ms \n',...
      '  -Median: ',num2str(mediana50),' ms \n',...      '  -3o Quartil: ',num2str(quartil350),' ms \n',...
      '  -Mean: ',num2str(media50),' ms \n',...
   	'  -Standard Deviation: ',num2str(dp50),' ms \n',...
      '  -Coefficient of Variation: ',num2str(cv50),' %% \n\n',...
   ]);

pct7590table=sprintf([...
   	'Percentile 75: ',num2str(pct75),' ms \n',...
      '  -Number of Points: ',num2str(pts75),'\n',...
      '  -Maximum: ',num2str(max75),' ms \n',...
      '  -Minimum: ',num2str(min75),' ms \n',...
      '  -Dynamic Range: ',num2str(faixa75),' ms \n',...
      '  -Dispersion Ratio: ',num2str(rdisp75),'  \n',...      '  -1o Quartil: ',num2str(quartil175),' ms \n',...
      '  -Median: ',num2str(mediana75),' ms \n',...      '  -3o Quartil: ',num2str(quartil375),' ms \n',...
      '  -Mean: ',num2str(media75),' ms \n',...
   	'  -Standard Deviation: ',num2str(dp75),' ms \n',...
   	'  -Coefficient of Variation: ',num2str(cv75),' %% \n\n',...
   	'Percentile 90: ',num2str(pct90),' ms \n',...
      '  -Number of Points: ',num2str(pts90),'\n',...
      '  -Maximum: ',num2str(max90),' ms \n',...
      '  -Minimum: ',num2str(min90),' ms \n',...
      '  -Dynamic Range: ',num2str(faixa90),' ms \n',...
      '  -Dispersion Ratio: ',num2str(rdisp90),'  \n',...      '  -1o Quartil: ',num2str(quartil190),' ms \n',...
      '  -Median: ',num2str(mediana90),' ms \n',...      '  -3o Quartil: ',num2str(quartil390),' ms \n',...
      '  -Mean: ',num2str(media90),' ms \n',...
   	'  -Standard Deviation: ',num2str(dp90),' ms \n',...
   	'  -Coefficient of Variation: ',num2str(cv90),' %% \n\n',...
   ]);