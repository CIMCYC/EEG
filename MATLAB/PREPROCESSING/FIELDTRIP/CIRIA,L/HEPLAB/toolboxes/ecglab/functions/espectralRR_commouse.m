function [vlf2,lf2,hf2,line1,line2,line3]=espectralRR_commouse(maxF,PSD,F,line1,line2,line3,vlf2,lf2,hf2,NRR,Neb,metodo)
%usage: 

global tx_vlf1 tx_lf1 tx_hf1 te_vlf2 te_lf2 te_hf2
global tx_areas1 tx_areas2

%inicializa variaveis
vlf=maxF;
lf=maxF;
hf=maxF;
i=1;

temp = get(gca,'YLim');
minPSD=temp(1),
maxPSD=temp(2),

%apaga as linhas
delete(line1);
delete(line2);
delete(line3);

%repete para as 3 bandas
while (i<=3),

	%define qual a banda
	switch i,
      
      %banda 1
		case 1,
         [x,y]=ginput(1); %le do mouse (com cursor)
			if (x<lf & x>=0 & y<=maxPSD & y>=0), %verifica se a area é valida
         	vlf2=round(x*1000)/1000; %deixa só 3 casas decimais
				line1=line([vlf2 vlf2],[10^(-20) 100*maxPSD]); %desenha a linha da banda
				set(line1,'color',[1 0 0]); %define a cor da linha
		      set(te_vlf2,'String',num2str(vlf2)); %corrige o valor na caixa de texto
		      set(tx_lf1,'String',num2str(vlf2)); %corrige o valor na caixa de texto
				[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf]=espectralRR_calcula_areas(PSD,F,...
				   vlf2,lf2,hf2); %calcula areas
				set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
				set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,NRR,Neb));            
         else,
            i=i-1; %se o clique foi fora da area valida, repete para a banda
         end,
         
      %banda 2   
   	case 2,
      	[x,y]=ginput(1);
			if (x<hf & x>vlf2 & y<=maxPSD & y>=0 ),
         	lf2=round(x*1000)/1000;%deixa só 3 casas decimais
				line2=line([lf2 lf2],[10^(-20) 100*maxPSD]);
				set(line2,'color',[1 0 0]);
		      set(te_lf2,'String',num2str(lf2));
		      set(tx_hf1,'String',num2str(lf2));
				[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf]=espectralRR_calcula_areas(PSD,F,...
				   vlf2,lf2,hf2); %calcula areas
				set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
				set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,NRR,Neb));
         else,
         	i=i-1; %se o clique foi fora da area valida, repete para a banda
         end,
         
      %banda 3
   	case 3,
      	[x,y]=ginput(1);
			if (x<=maxF & x>lf2 & y<=maxPSD & y>=0 ),
         	hf2=round(x*1000)/1000;%deixa só 3 casas decimais
				line3=line([hf2 hf2],[10^(-20) 100*maxPSD]);
				set(line3,'color',[1 0 0]);
		      set(te_hf2,'String',num2str(hf2));
				[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf]=espectralRR_calcula_areas(PSD,F,...
				   vlf2,lf2,hf2); %calcula areas
				set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
				set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,NRR,Neb));
         else,
         	i=i-1; %se o clique foi fora da area valida, repete para a banda
         end,
         
   end,
   
   i=i+1; %proxima banda
end,
