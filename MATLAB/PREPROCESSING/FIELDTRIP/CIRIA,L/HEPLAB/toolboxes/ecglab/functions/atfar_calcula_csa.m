function csastruct=atfar_calcula_csa(tempoRR,intervaloRR,normais,params)

if(params.rmvect==1),
  tk=tempoRR(normais);
  RR=intervaloRR(normais);
else,
  tk=tempoRR;
  RR=intervaloRR;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IPFM                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%T=.800; fs=500; Ts=1/fs; t=0:Ts:300-Ts;
%a1 =  (0:length(t)-1)/length(t) * .6; %.3; f1 = .1;
%a2 = (length(t)-1:-1:0)/length(t) * .6; % .3; f2 = .25;
%a1 = 0.3; f1 = (length(t)-1:-1:0)/length(t)*0.025+0.25;
%a2 = a1; f2 = (0:length(t)-1)/length(t)*0.025+0.05;
%m=a1.*cos(2*pi*f1.*t)+a2.*cos(2*pi*f2.*t)+3*rand(size(t));
%tk=ipfm(m,T,fs); RR=1000*(tk(2:end)-tk(1:end-1)); tk=tk(2:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%senoides
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tk = 0:1:300;
%RR = 900+250*sin(2*pi*0.1*tk).*(tk<100)+250*sin(2*pi*0.02*tk).*(tk>=100).*(tk<200)+250*sin(2*pi*0.2*tk).*(tk>=200);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tira parametros da estrutura
fs      = params.fsRR;
ordemAR = params.ordemAR;
winlen  = params.winlen;
wintype = params.wintype;
Npts    = params.Npts;
fsAR    = params.fsAR;
vlf     = params.vlf;
lf      = params.lf;
hf      = params.hf;
maxfreq = params.maxfreq;

%interpola com splines e tira o DC
Ts = 1/fs;
time = (tk(1):Ts:tk(end))';
hrv = spline(tk,RR,time);
csastruct.RRsplines = hrv;
csastruct.tksplines = time;
hrv = hrv-mean(hrv);

%numero de pontos no hrv, em cada PSD, nas janelas e tamanho do passo.
hrvlen = length(hrv);
PSDend = round(Npts/ ((fs/2)/maxfreq));
winlen = round(winlen*fs);
step   = round(1/fsAR*fs);

switch params.wintype,
	case 1,
    wintvar = boxcar(winlen);
    winpsd = boxcar(hrvlen);
	case 2,
    wintvar = bartlett(winlen);
    winpsd = bartlett(hrvlen);
	case 3,
    wintvar = hamming(winlen);
    winpsd = hamming(hrvlen);
	case 4,
    wintvar = hanning(winlen);
    winpsd = hanning(hrvlen);
	case 5,
    wintvar = blackman(winlen);
    winpsd = blackman(hrvlen);
end   
   
%calcula os PSDs e os indices espectrais de cada um deles.
TVAR=[]; timefreqindexes=[];
for i=1:step:(hrvlen-winlen+1),
   segmento=hrv(i:i+winlen-1).*wintvar;
   
   if params.alg=='ar',
     %espectrograma auto-regressivo
     [A, variancia] = arburg(segmento,ordemAR);
     [H,F] = freqz(1,A,Npts,fs);
     PSD=(abs(H).^2)*variancia*1/fs; %malik, p.67
   else,
     %espectrograma de fourier
     PSD=(abs(fft(segmento,2*Npts)).^2)/length(segmento)/fs;
     F=(0:fs/(2*Npts):fs-fs/(2*Npts))';
   end;
   
   TVAR=[TVAR,PSD(1:PSDend)];
   [aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf,lf,hf);
   timefreqindexes=[timefreqindexes;aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf];
end

[a,b]=size(TVAR);
timelength = time(end)-time(1);
steplength = (step /length(hrv)*timelength);
winlength = (winlen /length(hrv)*timelength);
T=((0:b-1)') * steplength + winlength/2 + tk(1);

%calculo do PSD total
segmento=hrv.*winpsd;

if params.alg=='ar',
  [A, variancia] = arburg(segmento,ordemAR);
  [H,F] = freqz(1,A,Npts,fs);
  psdtotal=(abs(H).^2)*variancia*1/fs; %malik, p.67
else,
  psdtotal=(abs(fft(segmento,2*Npts)).^2)/length(segmento)/fs; 
  F=(0:fs/(2*Npts):fs-fs/(2*Npts))';
end;
psdtotal=psdtotal(1:PSDend);
F=F(1:PSDend);


[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(psdtotal,F,vlf,lf,hf);


%areas de razao maior e menor que 1
deltaT=T(2)-T(1);
gt1=find(timefreqindexes(:,8)>1);
lt1=find(timefreqindexes(:,8)<1);
agt1 = sum( deltaT * (timefreqindexes(gt1,8)-1) );
alt1 = sum( deltaT * abs(1-timefreqindexes(lt1,8)) );
ragt1alt1 = agt1/alt1;

csastruct.tk = tempoRR ;
csastruct.RR = intervaloRR ;
csastruct.normais = normais ;
csastruct.T = T;
csastruct.F = F;
csastruct.TVAR = TVAR;
csastruct.aavlf = timefreqindexes(:,1);
csastruct.aalf = timefreqindexes(:,2);
csastruct.aahf = timefreqindexes(:,3);
csastruct.aatotal = timefreqindexes(:,4);
csastruct.avlf = timefreqindexes(:,5);
csastruct.alf = timefreqindexes(:,6);
csastruct.ahf = timefreqindexes(:,7);
csastruct.rlfhf = timefreqindexes(:,8);
csastruct.anlf = timefreqindexes(:,9);
csastruct.anhf = timefreqindexes(:,10);
csastruct.psd = psdtotal;
csastruct.psd_aavlf = aavlf;
csastruct.psd_aalf = aalf;
csastruct.psd_aahf = aahf;
csastruct.psd_aatotal = aatotal;
csastruct.psd_avlf = avlf;
csastruct.psd_alf = alf;
csastruct.psd_ahf = ahf;
csastruct.psd_rlfhf = rlfhf;
csastruct.psd_anlf = anlf;
csastruct.psd_anhf = anhf;
csastruct.agt1 = agt1; %area com razao maior que 1
csastruct.alt1 = alt1; %area com razao menor que 1
csastruct.ragt1alt1 = ragt1alt1; %razao entre as areas agt1/alt1

%save spectrogram csastruct params