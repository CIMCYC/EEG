function [psd_handle,N,PSD,F,line1,line2,line3,maxF,maxP]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,...
   vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
%usage:

%if params.alg=='ar',
%  [A, variancia] = arburg(segmento,ordemAR);
%  [H,F] = freqz(1,A,Npts,fs);
%  psdtotal=(abs(H).^2)*variancia*1/fs; %malik, p.67
%else,
%  psdtotal=(abs(fft(segmento,2*Npts)).^2)/length(segmento)/fs; 
%  F=(0:fs/(2*Npts):fs-fs/(2*Npts))';
%end;
%psdtotal=psdtotal(1:PSDend);
%F=F(1:PSDend);


janela_plotagem=[60 285 700 390];

%cria uma espaco para plotagem na janela
if psd_handle~=-1,
   delete(psd_handle);
end
psd_handle=axes('Units','pixels','Position',janela_plotagem);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temp=mean(intervaloRR);

switch metodo,
   case 'fhpis',
	  tempoRR=tempoRR(verdadeiros);
      intervaloRR=intervaloRR(verdadeiros);
      auxtempo = tempoRR(1):1/fs:tempoRR(length(tempoRR));		
      intervaloRR = (spline(tempoRR,intervaloRR,auxtempo))';
      intervaloRR=intervaloRR-mean(intervaloRR);
      eixoy='amplitude (ms^2/Hz)';
   case 'lhp__',
		tempoRR=tempoRR(verdadeiros);
      intervaloRR=intervaloRR(verdadeiros);
      intervaloRR=intervaloRR-mean(intervaloRR);
      eixoy='normalized amplitude';
   case 'fhpc_'
      tempoRR=(1:length(intervaloRR))';
      intervaloRR=intervaloRR(verdadeiros);
      intervaloRR =spline(verdadeiros,intervaloRR,tempoRR); %substituir por interpolacao com retas
      intervaloRR=intervaloRR-mean(intervaloRR);
      fs=1000/temp;
      eixoy='amplitude (ms^2/Hz)';
   case 'fhp__'
      intervaloRR=intervaloRR(verdadeiros);
      intervaloRR=intervaloRR-mean(intervaloRR);
      fs=1000/temp;
      eixoy='amplitude (ms^2/Hz)';
   case 'fhris',
		tempoRR=tempoRR(verdadeiros);
      intervaloRR=60*1./(intervaloRR(verdadeiros)/1000);
      auxtempo = tempoRR(1):1/fs:tempoRR(length(tempoRR));		
      intervaloRR = (spline(tempoRR,intervaloRR,auxtempo))';
      intervaloRR=intervaloRR-mean(intervaloRR);
      eixoy='amplitude (bpm^2/Hz)';
   case 'lhr__',
		tempoRR=tempoRR(verdadeiros);
      intervaloRR=60*1./(intervaloRR(verdadeiros)/1000);
      intervaloRR=intervaloRR-mean(intervaloRR);
      eixoy='normalized amplitude';      
   case 'fhrc_'
      tempoRR=(1:length(intervaloRR))';
      intervaloRR=60*1./(intervaloRR(verdadeiros)/1000);
      intervaloRR =spline(verdadeiros,intervaloRR,tempoRR); %substituir por interpolacao com retas
      intervaloRR=intervaloRR-mean(intervaloRR);
      fs=1000/temp;
      eixoy='amplitude (bpm^2/Hz)';
   case 'fhr__'
      intervaloRR=60*1./(intervaloRR(verdadeiros)/1000);
      intervaloRR=intervaloRR-mean(intervaloRR);
      fs=1000/temp;
      eixoy='amplitude (bpm^2/Hz)';
end,

%faz um janelamento para retirar distorcoes da segmentacao
switch janela,
   case 'han',
      intervaloRR = intervaloRR.*hanning(length(intervaloRR));
   case 'ham'
      intervaloRR = intervaloRR.*hamming(length(intervaloRR));
   case 'bla'
      intervaloRR = intervaloRR.*blackman(length(intervaloRR));
   case 'bar'
      intervaloRR = intervaloRR.*bartlett(length(intervaloRR));
end,    

%calcula numero de pontos da FFT
%if length(intervaloRR)>1024,
%   N=ceil(length(intervaloRR)/1024)*1024;
%else,
%   N=1024;
%end,
%N=length(intervaloRR);

switch metodo
   case {'lhp__','lhr__'},
		deltaF=maxF/N;
      F=(0:deltaF:maxF-deltaF)';
      PSD=lomb(intervaloRR,tempoRR,F);
      PSD=PSD/max(PSD); %o resultado é um espectro normalizado
      maxPSD=max(PSD);
      minPSD=min(PSD);
      switch escala
	      case 'normal'
            plot(F,PSD)
         case 'monolog'
            semilogy(F,PSD)
         case 'loglog'
            loglog(F,PSD)
      end
   otherwise
switch algoritmo
	case 'mar'
      [A, variancia] = arburg(intervaloRR,ordem_ar);
      [H,F] = freqz(1,A,N,fs);
      PSD=(abs(H).^2)*variancia*1/fs; %malik, p.67
	  maxPSD=max(PSD);
	  minPSD=min(PSD);
      switch escala
	      case 'normal'
            plot(F,PSD)
         case 'monolog'
            semilogy(F,PSD)
         case 'loglog'
            loglog(F,PSD)
      end
   case 'fft',
      PSD=(abs(fft(intervaloRR,N)).^2)/length(intervaloRR)/fs; %*fs
      F=(0:fs/N:fs-fs/N)';
      PSD=PSD(1:ceil(length(PSD)/2));
      F=F(1:ceil(length(F)/2));
      maxPSD=max(PSD);
      minPSD=min(PSD(2:length(PSD)));
      switch escala
	      case 'normal'
            plot(F,PSD)
         case 'monolog'
            semilogy(F,PSD)
         case 'loglog'
            loglog(F,PSD)
      end
	case 'amb'
      [A, variancia] = arburg(intervaloRR,ordem_ar);
      [H,F] = freqz(1,A,N,fs);
      PSD=(abs(H).^2)*variancia*1/fs; %malik, p.67
      PSD_aux=(abs(fft(intervaloRR,N)).^2)/length(intervaloRR)/fs; %*fs
      F_aux=(0:fs/N:fs-fs/N)';
      PSD_aux=PSD_aux(1:ceil(length(PSD_aux)/2));
      F_aux=F_aux(1:ceil(length(F_aux)/2));
      maxPSD=max([max(PSD),max(PSD_aux)]);
      minPSD=min([min(PSD),min(PSD_aux(2:length(PSD_aux)))]);
      switch escala
	      case 'normal'
            plot(F_aux,PSD_aux,'b',F,PSD,'k')
         case 'monolog'
            semilogy(F_aux,PSD_aux,'b',F,PSD,'k')
         case 'loglog'
            loglog(F_aux,PSD_aux,'b',F,PSD,'k')
      end
end,
end,

if maxF>fs/2,
   maxF=round(max(F)*1000)/1000;
end,

if maxP==0,
   maxP=maxPSD;
end,

if minP==0 & escala(1)~='n',
   minP=minPSD;
end,

if fill==1,
   
	%calcula o ponto de limite de cada banda
	indice_vlf=round(vlf2*length(F)/(F(length(F))+F(2)))+1;
	indice_lf=round(lf2*length(F)/(F(length(F))+F(2)))+1;
	indice_hf=round(hf2*length(F)/(F(length(F))+F(2)))+1;
	if indice_hf>length(F),indice_hf=length(F);end   
   
   if escala(1)=='l',
      patch([F(2),F(2:indice_vlf)',F(indice_vlf)],[minP,PSD(2:indice_vlf)',minP],[0 .5 0])
   else
      patch([F(1),F(1:indice_vlf)',F(indice_vlf)],[minP,PSD(1:indice_vlf)',minP],[0 .5 0])
   end   
   
   patch([F(indice_vlf),F(indice_vlf:indice_lf)',F(indice_lf)],[minP,PSD(indice_vlf:indice_lf)',minP],[.9 0 0])
   patch([F(indice_lf),F(indice_lf:indice_hf)',F(indice_hf)],[minP,PSD(indice_lf:indice_hf)',minP],[0 0 .8])
   patch([F(indice_hf),F(indice_hf:length(F))',F(length(F))],[minP,PSD(indice_hf:length(F))',minP],[0.4 0.4 0.4])
   
end

switch metodo,
	case {'lhp__','lhr__'},
		axis([minF maxF 0 1]);
	otherwise,
		axis([minF maxF minP maxP]);
end
title('Spectrogram'),
ylabel(eixoy),
xlabel('frequency (Hz)'),
grid,

%plota as linhas que delimitam as bandas
line1=line([vlf2 vlf2],[minP maxP]);
set(line1,'color',[1 0 0]);
line2=line([lf2 lf2],[minP maxP]);
set(line2,'color',[1 0 0]);
line3=line([hf2 hf2],[minP maxP]);
set(line3,'color',[1 0 0]);