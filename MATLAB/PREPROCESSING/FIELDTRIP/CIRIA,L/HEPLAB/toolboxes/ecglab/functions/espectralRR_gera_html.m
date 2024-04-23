function espectralRR_gera_html(filename,prontuario,tempoRR,intervaloRR,verdadeiros,...
   ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill)
%usage:

imagenspb='n'; %imagens em preto e branco? [s/n]
tamanho_imagens=.8; %em porcentagem do tamanho original (recomendado: 0.3)
titulo_html='ECGLAB - Frequency-Domain Analysis of HRV';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho corrige o path e determina o nome do arquivo de acordo com a extensao
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ponto=find(filename=='.');
pathfilename=[filename(1:ponto(length(ponto))-1),'_frr'];

barras=find(pathfilename=='\');
filename=pathfilename(barras(length(barras))+1:length(pathfilename));
path=pathfilename(1:barras(length(barras)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o header e o final do arquivo HTML
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


html_header=['',...
      '<html>\n',...
      '<head>\n',...
      '<title>',titulo_html,'</title>\n',...
      '</head>\n',...
      '<body>\n',...
      '\n',...
	];

html_end='\n</body>\n</html>';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho mostra o prontuario
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prontuario=sprintf(prontuario);   
quebra_linha=find(prontuario==10);

if length(prontuario)<=1,
   html_prontuario='';
else
	if isempty(quebra_linha)~=1,

		for i=length(quebra_linha):-1:1,
   		if quebra_linha(i)>1 & quebra_linha(i)<length(prontuario),
      		prontuario=[prontuario(1:quebra_linha(i)-1),'<br>\n',prontuario(quebra_linha(i)+1:length(prontuario))];
		   elseif quebra_linha(i)==1,
   		   prontuario=['<br>\n',prontuario(quebra_linha(i)+1:length(prontuario))];
		   else
   		   if quebra_linha(i)>1 & quebra_linha(i)==length(prontuario),
      		   prontuario=[prontuario(1:quebra_linha(i)-1)];
		      end
   	   end      
		end
   
	end

	html_prontuario=[...
		'<div align="center"><center><table border="1" width="500"><tr><td><font face="Arial" size="2">\n',...
		prontuario,...
		'</font></td></tr></table></center></div>&nbsp;',...
		];

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera um arquivo bmp com o espectrograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcula o espectro
[PSD,F]=espectralRR_espectrograma2(tempoRR,intervaloRR,verdadeiros,ebs_indices,...
   							vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
                     
print temp -f101 -dtiff -r100;
close(101);
figura_psd=imread('temp.tif','tif');
delete temp.tif;

%recorta a figura na parte do grafico
figura_psd=figura_psd(119:599,1:800,:);

figura_psd=imresize(figura_psd,tamanho_imagens,'bilinear');
if imagenspb=='s',
   figura_psd=rgb2gray(figura_psd);
end
imwrite(figura_psd,[pathfilename,'.bmp'],'bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar o espectrograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_espectrograma=['\n<p align="center"><img border="0" src="',...
   [filename,'.bmp'],'"><br><br>\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar os indices espectrais
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcula as areas
[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);

if algoritmo=='fft',
   ordem_ar='-';
else,
   ordem_ar=num2str(ordem_ar);
end,

switch janela,
	case 'ret',
      janela='Rectangular';
	case 'han',
      janela='Hanning';
	case 'ham',
      janela='Hamming';
	case 'bla',
      janela='Blackman';
	case 'bar',
      janela='Bartlett';
end,
   
switch metodo,
	case 'fhpis',
      metodo=['FHPIS (R-R signal interpolated with splines), fs = ',num2str(fs),' Hz'];
	case 'fhpc_',
      metodo='FHPc (corrected series of R-R intervals)';
	case 'fhp__',
      metodo='FHP (series of normal R-R intervals)';
	case 'fhris',
      metodo=['FHRIS (HR signal interpolated with splines), fs = ',num2str(fs),' Hz'];
	case 'fhrc_',
      metodo='FHRc (corrected series of instaneous HR)';
	case 'fhr__',
      metodo='FHR (series of normal instaneous HR)';
	case 'lhp__',
      metodo='LHP (Lomb-Scargle periodogram of R-R signal)';
	case 'lhr__',
      metodo='LHR (Lomb-Scargle periodogram of HR signal)';
end,
   
html_indicesfreq=['<div align="center"><center><table border="1" width="500"><tr>\n',...
      '<td><font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;Frequency-Domain Analysis of HRV<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- From 0 to ',num2str(hf2),' Hz<br>\n',...
		'&nbsp;&nbsp;&nbsp;&nbsp;- Total Area: ',num2str(aatotal),' ms²<br><br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;Very Low Frequencies:<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- From 0 to ',num2str(vlf2),' Hz<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Absolute area: ',num2str(aavlf),' ms²<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Relative area: ',num2str(avlf),'%%<br><br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;Low Frequencies :<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- From ',num2str(vlf2),' to ',num2str(lf2),' Hz<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Absolute area: ',num2str(aalf),' ms²<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Relative area: ',num2str(alf),'%%<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Normalized Area: ',num2str(anlf),' n.u.<br><br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;High Frequencies:<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- From ',num2str(lf2),' to ',num2str(hf2),' Hz<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Absolute area: ',num2str(aahf),' ms²<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Relative area: ',num2str(ahf),'%%<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;- Normalized Area: ',num2str(anhf),' n.u.<br><br>\n',...
		'&nbsp;&nbsp;&nbsp;&nbsp;LF/HF Ratio: ',num2str(rlfhf),'<br><br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;Method: ',metodo,'<br>\n',...
      '&nbsp;&nbsp;&nbsp;&nbsp;AR model order: ',ordem_ar,'<br>\n',...
	   '&nbsp;&nbsp;&nbsp;&nbsp;Window: ',janela,'<br>\n',...
   	'&nbsp;&nbsp;&nbsp;&nbsp;# of Pts: ',num2str(N),'</font></td>\n',...
   	'</tr></table></center></div>'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho junta os varios pedacos do arquivo HTML, grava no disco e abre no explorer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_code=[html_header,html_prontuario,html_espectrograma,...
      html_indicesfreq,html_end];

fid = fopen([pathfilename,'.html'],'w');
fprintf(fid,html_code);
fclose(fid);

%cria um arquivo .bat para abrir o explorer
bat_code=[101 99 104 111 32 111 102 102 13 10 99 108 115,...
          13 10 99 58 13 10 99 100 92 97 114 113 117 105,...
          118 126 49 92 105 110 116 101 114 110 126 49,...
          13 10 99 100 92 112 114 111 103 114 97 126 49,...
          92 105 110 116 101 114 110 126 49 13 10 105 101,...
          120 112 108 111 114 101 32 37 49];
fid = fopen([path,'iexplore.bat'],'w');
fwrite(fid,bat_code,'uchar');
fclose(fid);

dos([path,'iexplore.bat ' ,pathfilename,'.html']);

% no matlab 5.3:
% dos([pathfilename,'.html']);