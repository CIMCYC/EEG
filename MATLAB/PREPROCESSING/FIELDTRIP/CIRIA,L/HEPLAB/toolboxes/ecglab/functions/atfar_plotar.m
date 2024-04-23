function handle=atfar_plotar(janela,handle,csastruct,params)

switch janela,
 case 1,
    janela_plotagem=[62 528 640 154];
    opcao = params.janela1;
 case 2,
    janela_plotagem=[62 324 640 154];
    opcao = params.janela2;    
 case 3,
    janela_plotagem=[62 120 640 154];   
    opcao = params.janela3;
end

%cria uma espaco para plotagem na janela
if handle~=-1, delete(handle); end
handle=axes('Units','pixels','Position',janela_plotagem);

switch opcao,
 case 1,
   if(params.rmvect==1), 
      plot(csastruct.tk(csastruct.normais),csastruct.RR(csastruct.normais));
   else,
      plot(csastruct.tk,csastruct.RR);
   end;
   ylabel('RR interval (ms)'),title('RR Signal')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])
 case 2,
   plot(csastruct.tksplines,csastruct.RRsplines)
   ylabel('RR interval (ms)'),title('RR Signal Interpolated Using Cubic Splines')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 3,
   logtvar = log10(csastruct.TVAR);
   logtvar(find(logtvar<0))=0;%para destacar os picos, nao dando visibilidade desnecessaria aos vales.
   imagesc(csastruct.T,csastruct.F,logtvar);
   set(gca,'YDir','normal')
   colormap(jet),
   ylabel('frequency (Hz)'),
   %ylabel('frequency (Hz)'),   
   if(params.alg=='ar'), title('Auto-Regressive Spectrogram');
   else,  title('Fourier Spectrogram');
   end;
   x=[csastruct.T(1);csastruct.T(end)];x=[x,x,x];
   y=[params.vlf,params.lf,params.hf];y=[y;y];
   z=[max(logtvar(:))];z=[z,z,z;z,z,z];
   set(line(x,y,z),'color',[0 0 0]);
   ztick = get(handle,'ZTick');
   axis([params.janela_inicio params.janela_fim 0 params.maxfreq ztick(1) ztick(end)]);
   view(0,90);

   %[TT,FF] = meshgrid(csastruct.T,csastruct.F);
   %mesh(TT, FF, logtvar )
   %colormap('jet(256)'),grid off
   %ylabel('freqüência (Hz)'),
   %if(params.alg=='ar'), title('Espectrograma Auto-Regressivo');
   %else,  title('Espectrograma de Fourier');
   % end;
   %x=[csastruct.T(1);csastruct.T(end)];x=[x,x,x];
   %y=[params.vlf,params.lf,params.hf];y=[y;y];
   %z=[max(logtvar(:))];z=[z,z,z;z,z,z];
   %set(line(x,y,z),'color',[0 0 0]);
   %ztick = get(handle,'ZTick');
   %axis([params.janela_inicio params.janela_fim 0 params.maxfreq ztick(1) ztick(end)]); %min(csastruct.TVAR(:)) max(csastruct.TVAR(:))]);
   %view(0,90);
   
   
%[TT,FF] = meshgrid( [csastruct.T(1);csastruct.T(end)] , [csastruct.F(1);csastruct.F(end)] );
%mesh(TT, FF, TT);
%xtick = get(handle,'XTick');
%ytick = get(handle,'YTick');
%xticklabel = get(handle,'XTickLabel');
%yticklabel = get(handle,'YTickLabel');
%handlei=imagesc(log10(csastruct.TVAR(end:-1:1,:)));
%get(handlei)
%set(handle,'XTick',xtick,'YTick',ytick,'XTickLabel',xticklabel,'YTickLabel',yticklabel);

 case 4,
   plot(csastruct.T,csastruct.rlfhf)
   ylabel('LF/HF ratio'),title('LF/HF Ratio as a Function of Time')
   %ylabel('LF/HF ratio'),   
   ytick = get(handle,'YTick');   
   if ytick(end) < 2,
      ytick(end) = 2;
   end;
   axis([params.janela_inicio params.janela_fim 0 ytick(end)])   
   x=[csastruct.T(1);csastruct.T(end)];
   y=[1,1];
   set(line(x,y),'color',[1 0 0],'linestyle',':');
   
 case 5,
   gt1=((csastruct.rlfhf>1).*csastruct.rlfhf);
   gt1(find(gt1==0))=1;
   lt1=((csastruct.rlfhf<1).*csastruct.rlfhf);
   lt1(find(lt1==0))=1;
   hold on
   fill([csastruct.T(1);csastruct.T;csastruct.T(end)],[1;gt1;1],'c')
   fill([csastruct.T(1);csastruct.T;csastruct.T(end)],[1;lt1;1],'m')
   hold off
   ylabel('LF/HF ratio'),title('LF/HF Ratio as a Function of Time')   
   ytick = get(handle,'YTick');   
   if ytick(end) < 2,
      ytick(end) = 2;
   end;
   axis([params.janela_inicio params.janela_fim 0 ytick(end)])
 case 6,
   plot(csastruct.T,csastruct.aavlf)
   ylabel('VLF power (ms^2)'),title('Power in VLF Band as a Function of Time')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 7,
   plot(csastruct.T,csastruct.aalf)
   ylabel('LF power (ms^2)'),title('Power in LF Band as a Function of Time')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 8,
   plot(csastruct.T,csastruct.aahf)
   %plot(csastruct.T,csastruct.aavlf,'r-',csastruct.T,csastruct.aalf,'b-',csastruct.T,csastruct.aahf,'k-')
   ylabel('HF power (ms^2)'),title('Power in HF Band as a Function of Time')
   %ylabel('power (ms^2)')   
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 9,
   plot(csastruct.T,csastruct.aatotal)
   ylabel('total power (ms^2)'),title('Total Power as a Function of Time')   
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 10,
   plot(csastruct.T,csastruct.avlf)
   ylabel('VLF power (%)'),title('Power in VLF Band as a Function of Time')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 11,
   plot(csastruct.T,csastruct.alf)
   ylabel('LF power (%)'),title('Power in LF Band as a Function of Time')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 12,
   plot(csastruct.T,csastruct.ahf)
   ylabel('HF power (%)'),title('Power in HF Band as a Function of Time')
   ytick = get(handle,'YTick');   
   axis([params.janela_inicio params.janela_fim ytick(1) ytick(end)])   
 case 13,
   %calcula o ponto de limite de cada banda
	indice_vlf=round(params.vlf*length(csastruct.F)/(csastruct.F(length(csastruct.F))+csastruct.F(2)))+1;
	indice_lf=round(params.lf*length(csastruct.F)/(csastruct.F(length(csastruct.F))+csastruct.F(2)))+1;
	indice_hf=round(params.hf*length(csastruct.F)/(csastruct.F(length(csastruct.F))+csastruct.F(2)))+1;
   if indice_hf>length(csastruct.F),indice_hf=length(csastruct.F);end;
   
   %plota o AR e pinta as bandas
   plot(csastruct.F,csastruct.psd)
   patch([csastruct.F(1),csastruct.F(1:indice_vlf)',csastruct.F(indice_vlf)],[0,csastruct.psd(1:indice_vlf)',0],[0 .5 0])
   patch([csastruct.F(indice_vlf),csastruct.F(indice_vlf:indice_lf)',csastruct.F(indice_lf)],[0,csastruct.psd(indice_vlf:indice_lf)',0],[.9 0 0])
   patch([csastruct.F(indice_lf),csastruct.F(indice_lf:indice_hf)',csastruct.F(indice_hf)],[0,csastruct.psd(indice_lf:indice_hf)',0],[0 0 .8])
   patch([csastruct.F(indice_hf),csastruct.F(indice_hf:length(csastruct.F))',csastruct.F(length(csastruct.F))],[0,csastruct.psd(indice_hf:length(csastruct.F))',0],[0.4 0.4 0.4])   
   ylabel('magnitude (ms^2/Hz)'),title('Power Spectrum Density')
   
   %desenha as linhas que dividem as bandas
   ytick = get(handle,'YTick');
   y=[0;300000];y=[y,y,y];
   x=[params.vlf,params.lf,params.hf];x=[x;x];
   set(line(x,y),'color',[0 0 0]);
   axis([0 params.maxfreq ytick(1) ytick(end)])
case 14,
    [scalogram,period] = atfar_cwt(csastruct,params);
    scalogram = log10(scalogram);
    scalogram(find(scalogram<-2))=-2;%para destacar os picos, nao dando visibilidade desnecessaria aos vales.
    [TT,FF] = meshgrid(csastruct.tksplines,(1./period));    
    mesh(TT, FF, scalogram)
	colormap('jet(256)'),grid off
	ylabel('frequency (Hz)'),
	%xlabel('tempo (segundos)')
	title('Wavelet Spectrogram (Scalogram)');
    x=[csastruct.tksplines(1);csastruct.tksplines(end)];x=[x,x,x];
    y=[params.vlf,params.lf,params.hf];y=[y;y];
    z=[max(scalogram(:))];z=[z,z,z;z,z,z];
    set(line(x,y,z),'color',[0 0 0]);    
    ztick = get(handle,'ZTick');
    axis([params.janela_inicio params.janela_fim 0 params.maxfreq ztick(1) ztick(end)]);    
	view(0,90);
case 15,
    [scalogram,period] = atfar_cwt(csastruct,params);
    scalogram = log10(scalogram);
    scalogram(find(scalogram<-2))=-2;%para destacar os picos, nao dando visibilidade desnecessaria aos vales.
    [TT,FF] = meshgrid(csastruct.tksplines,log2(period));
    mesh(TT, FF, scalogram)
	colormap('jet(256)'),grid off
	ylabel('frequency (Hz)'),
	%xlabel('tempo (segundos)')
	title('Wavelet Spectrogram (Scalogram)');
    Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
    set(gca,'YLim',log2([min(period),max(period)]),'YDir','reverse', ...
          'YTick',log2(Yticks(:)),'YTickLabel',Yticks.^(-1),'XLim',[params.janela_inicio params.janela_fim]);
	view(0,90);    
end

if (janela==3),
   if(opcao == 13),
      xlabel('frequency (Hz)');
   else,
      xlabel('time (seconds)');
      %xlabel('time (s)');
   end;
end;

if params.eixoyauto == 0,
   set(handle,'YLim',[params.eixoymin(opcao) params.eixoymax(opcao)]);
end;

%Color maps.
%    hsv        - Hue-saturation-value color map.
%    hot        - Black-red-yellow-white color map.
%    gray       - Linear gray-scale color map.
%    bone       - Gray-scale with tinge of blue color map.
%    copper     - Linear copper-tone color map.
%    pink       - Pastel shades of pink color map.
%    white      - All white color map.
%    flag       - Alternating red, white, blue, and black color map.
%    lines      - Color map with the line colors.
%    colorcube  - Enhanced color-cube color map.
%    vga        - Windows colormap for 16 colors.
%    jet        - Variant of HSV.
%    prism      - Prism color map.
%    cool       - Shades of cyan and magenta color map.
%    autumn     - Shades of red and yellow color map.
%    spring     - Shades of magenta and yellow color map.
%    winter     - Shades of blue and green color map.
%    summer     - Shades of green and yellow color map.


%params



