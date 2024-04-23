function sequencialRR_gera_html(filename,prontuario,intervaloRR,eixo)
%usage:

imagenspb='n'; %imagens em preto e branco? [s/n]
tamanho_imagens=.8; %em porcentagem do tamanho original (recomendado: 0.3)
titulo_html='ECGLAB - Sequential Trend Analysis of R-R Intervals';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho corrige o path e determina o nome do arquivo de acordo com a extensao
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ponto=find(filename=='.');
pathfilename=[filename(1:ponto(length(ponto))-1),'_srr'];

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
% Este trecho gera um arquivo bmp com o grafico
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

indices=sequencialRR_grafico2(intervaloRR,eixo);
                     
print temp -f101 -dtiff -r100;
close(101);
figura_psd=imread('temp.tif','tif');
delete temp.tif;

%recorta a figura na parte do desenho esquematico
size(figura_psd)
figura_psd=figura_psd(120:end,1:500,:);

figura_psd=imresize(figura_psd,tamanho_imagens,'bilinear');
if imagenspb=='s',
   figura_psd=rgb2gray(figura_psd);
end
imwrite(figura_psd,[pathfilename,'.bmp'],'bmp');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar o grafico
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

html_espectrograma=['\n<p align="center"><img border="0" src="',...
   [filename,'.bmp'],'"><br><br>\n'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Este trecho gera o codigo HTML para mostrar os indices espectrais
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q1=indices(1);pq1=indices(2);
q2=indices(3);pq2=indices(4);
q3=indices(5);pq3=indices(6);
q4=indices(7);pq4=indices(8);
l1=indices(9);pl1=indices(10);
l2=indices(11);pl2=indices(12);
l3=indices(13);pl3=indices(14);
l4=indices(15);pl4=indices(16);
centro=indices(17);pcentro=indices(18);
total=indices(19);
difnulas=indices(20);
pdifnulas=indices(21);
difnaonulas=indices(22);
pdifnaonulas=indices(23);
   
html_indicesfreq=['<div align="center"><center><table border="1" width="250"><tr>\n',...
      '<td><font face="Arial" size="2"><center>Points per quadrant:<br>\n',...
      '(+,+): ',num2str(q1),' pts, ',num2str(pq1),' %%<br>\n',...
      '(-,+): ',num2str(q2),' pts, ',num2str(pq2),' %%<br>\n',...
      '(-,-): ',num2str(q3),' pts, ',num2str(pq3),' %%<br>\n',...
      '(+,-): ',num2str(q4),' pts, ',num2str(pq4),' %%</center></font></td></tr>\n',...
      '<tr><td><font face="Arial" size="2"><center>Points per line:<br>\n',...
      '(+,o): ',num2str(l1),' pts, ',num2str(pl1),' %%<br>\n',...
      '(o,+): ',num2str(l2),' pts, ',num2str(pl2),' %%<br>\n',...
      '(-,o): ',num2str(l3),' pts, ',num2str(pl3),' %%<br>\n',...
      '(o,-): ',num2str(l4),' pts, ',num2str(pl4),' %%</center></font></td></tr>\n',...
      '<tr><td><font face="Arial" size="2"><center>Points at origin:<br>\n',...
      '(o,o): ',num2str(centro),' pts, ',num2str(pcentro),' %%</center></font></td></tr>\n',...
      '<tr><td><font face="Arial" size="2"><center>Total: ',num2str(total),' pts</center></font></td>\n',...   
      '<tr><td><font face="Arial" size="2"><center>Null differences: ',...
      num2str(difnulas),' pts, ',num2str(pdifnulas),' %%<br>\n',...
      'Non-null differences: ',num2str(difnaonulas),' pts, ',num2str(pdifnaonulas),' %%</center></font></td></tr>\n',...
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