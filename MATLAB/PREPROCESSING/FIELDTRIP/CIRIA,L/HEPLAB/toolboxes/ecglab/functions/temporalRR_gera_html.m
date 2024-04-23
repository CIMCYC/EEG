function temporalRR_gera_html(intervaloRR,tempoRR,prontuario,filename,eventos,abscissa,eixox1,eixox2,eixoy1,eixoy2,outliers)
%usage:

cor='b'; %cor dos plots: 'k','b','r'
imagenspb='n'; %imagens em preto e branco? [s/n]
tamanho_imagens=.9; %em porcentagem do tamanho original (recomendado: 0.3)
colunas_tabelaIRR=10; %numero de colunas na tabela dos intervalos R-R
titulo_html='ECGLAB - Temporal Analysis of R-R Intervals';

if tempoRR(1)~=0 & length(find(tempoRR==0))~=0,
   titulo_tabelaIRR='Table of R-R Intervals: Position/Interval (in milliseconds);&nbsp;&nbsp;&nbsp;&nbsp;obs: value ''0'' indicates samples that have been corrected by interpolation';
else
   titulo_tabelaIRR='Table of R-R Intervals: Position/Interval (in milliseconds)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho corrige o path e determina o nome do arquivo de acordo com a extensao
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ponto=find(filename=='.');
pathfilename=[filename(1:ponto(length(ponto))-1),'_trr'];

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
% Este trecho gera um arquivo bmp com o intervalograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temporalRR_intervalograma2(tempoRR,intervaloRR,eventos,abscissa,eixox1,eixox2,eixoy1,eixoy2);
print temp -f101 -dtiff -r100;
close(101);
intervalograma_handle=-1;
figura_intervalograma=imread('temp.tif','tif');
delete temp.tif;

%recorta a figura na parte do desenho esquematico
figura_intervalograma=figura_intervalograma(194:599,1:685,:);

figura_intervalograma=imresize(figura_intervalograma,tamanho_imagens,'bilinear');
if imagenspb=='s',
   figura_intervalograma=rgb2gray(figura_intervalograma);
end
imwrite(figura_intervalograma,[pathfilename,'.bmp'],'bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar o intervalograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_intervalograma=['\n<p align="center"><img border="0" src="',...
   [filename,'.bmp'],'">\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera um arquivo bmp com o boxplot do intervalograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plota e captura o boxplot para figura_boxplot
figure(101);clf;
set(101,'Position',[100,100,225,340],'Color',[.95 .95 .95]);
axes('Units','pixels','Position',[50 5 165 325]);

if outliers==0,
   temporalRR_boxplot(intervaloRR,0,'x',1,5000)
else
   temporalRR_boxplot(intervaloRR,0,'x',1,1.5)
end   

print temp -f101 -dtiff -r100;                   %captura para um arquivo temporario.
close(101);                           %fecha a janela do plot.
figura_boxplot=imread('temp.tif','tif'); %le o arquivo temporario.
delete temp.tif;                         %apaga arquivo temporario.

%recorta a figura na parte do desenho esquematico
figura_boxplot=figura_boxplot(249:599,20:230,:);

%converte para preto e branco, se for o caso
if imagenspb=='s', figura_boxplot=rgb2gray(figura_boxplot); end,
%tamanho_imagens=.9

%reduz o tamanho da imagem
figura_boxplot=imresize(figura_boxplot,tamanho_imagens,'bilinear');

%escreve o arquivo no disco
%figure(345234),clf,image(figura_boxplot)
imwrite(figura_boxplot,[pathfilename,'_bp.bmp'],'bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar o boxplot do intervalograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_boxplot=['\n<td><img border="0" src="',...
   [filename,'_bp.bmp'],'"></td>\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este gera uma tabela com os indices temporais do intervalograma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[totaldeamostras,media,mediana,desviopadrao,minimo,maximo,quartil1,quartil3,...
      pnn50,rmssd,coefvar,faixadinamica]=temporalRR_calcula_stats(intervaloRR);

estacionariedade=temporalRR_estacionariedade(intervaloRR);

if estacionariedade(1)>=80,
   yes_no='YES';
else
	yes_no='NO';
end

estacionariedade=[...
      yes_no,': ',...
      num2str(round(estacionariedade(1))) '%% [',...
      num2str(round(estacionariedade(2))) ' ',...
      num2str(round(estacionariedade(3))) ' ',...
      num2str(round(estacionariedade(4))) ' ',...
      num2str(round(estacionariedade(5))) ' ',...
      num2str(round(estacionariedade(6))) ' ',...
      num2str(round(estacionariedade(7))) ']',...
      ];


indices_irr=['\n\n<div align="center"><center><table border="1"><tr>',...
   '<td colspan="2">\n',...   
   '<font face="Arial" size="2"><center>Time-Domain Statistics\n',...
   '</center></font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Minimum:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(minimo),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Maximum:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(maximo),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Dynamic Range:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(faixadinamica),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">1st Quartile:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(quartil1),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Median:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(mediana),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">3rd Quartile:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(quartil3),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Mean:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(media),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Standard Deviaton:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(desviopadrao),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Coeff. of Variation:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(coefvar),' %%</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">pNN50:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(pnn50),' %%</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">r-MSSD:</font></td>\n',...
	'<td><font face="Arial" size="2">',num2str(rmssd),' ms</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Number of Samples:</font></td>\n',...
   '<td><font face="Arial" size="2">',num2str(totaldeamostras),'</font></td></tr>\n',...
	'<tr><td><font face="Arial" size="2">Stationarity:</font></td>\n',...
	'<td><font face="Arial" size="2">',estacionariedade,'&nbsp;</font></td></tr>\n',...
	'</table></center></div></td>\n\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para juntar os 3 acima numa tabela
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_intervalograma=[html_intervalograma,'<br><br>\n<div align="center"><center><table border="0"><tr>\n',...
      '<td>',indices_irr,'</td>\n','<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>\n',...
      html_boxplot,'</tr></table></center></div></td></tr></table></center></div></p>'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera a tabela dos Intervalos R-R
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tabela_irr=['<div align="center"><center>\n',...
      '<table border="1"><tr><td colspan="',...
      num2str(3*colunas_tabelaIRR-1),'"><p align="center"><font face="Arial" size="1">',...
      titulo_tabelaIRR,...
      '</font></p></td>\n'];

intervalos=length(intervaloRR);
for i=1:intervalos,
   tempo=num2str(round(tempoRR(i)*1000));
   intervalo=num2str(intervaloRR(i));
   if mod(i-1,colunas_tabelaIRR)==0,
      tabela_irr=[tabela_irr,'</tr>\n<tr>\n'];
   else,
      tabela_irr=[tabela_irr,'<td></td>\n'];
   end,
   tabela_irr=[tabela_irr,'<td align="right"><font face="Arial" size="1">',...
         tempo,'</font></td>\n'];
   tabela_irr=[tabela_irr,'<td align="right"><font face="Arial" size="1">',...
         intervalo,'</font></td>\n'];
end
tabela_irr=[tabela_irr,'</tr>\n</table>\n','</center></div>\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho junta os varios pedacos do arquivo HTML, grava no disco e abre no explorer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_code=[html_header,html_prontuario,html_intervalograma,...
      tabela_irr,html_end];
%barras=find(html_code=='\');
%for i=length(barras):-1:1,
%   if html_code(barras(i)+1)~='n',
%      html_code=[html_code(1:barras(i)),'\',html_code(barras(i)+1:length(html_code))];
%   end
%end   
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