% PARA INSTRUCOES SOBRE USO, LEIA O ARQUIVO ECGFILT_README.DOC
%
%
clear %limpa a memoria do matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lista das variaveis globais
%

%global samplerate_ecg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%estes parametros podem ser facilmente alterados para personalizacao:
%

numerodajanela=100; %numero da figura do MatLab a ser usada como janela principal
fig_largura=1024;fig_altura=702; %largura e altura da janela do programa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cria a tela do programa
%
figure(numerodajanela);close(numerodajanela);
main_window=figure(numerodajanela);
clf;
set(main_window,'Name','(GPDS/ENE/UnB) ECGConvert - Format conversion','Position',[1,29,fig_largura,fig_altura])

mensageminicial=sprintf([...
      'ECGConvert - Imports data in Physionet format\n\n\n',...
      'Jo�o Luiz Azevedo de Carvalho, Ph.D.\n\n\n',...
      'Digital Signal Processing Group\n',...
      'Department of Electrical Engineering\n',...
      'School of Technology\n',...      
      'University of Brasilia\n\n\n',...
      'joaoluiz@gmail.com',...
]);      
tx_mensagem=uicontrol('Style','text','String',mensageminicial,'Position',[100 150 800 500],'FontSize',14,...
   'HorizontalAlignment','center','BackgroundColor',[.8 .8 .8]);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%inicializacao de variaveis
%
%fid=fopen('samplerate_ecg.cfg','r');samplerate_ecg=str2num(fgetl(fid));fclose(fid); %taxa de amostragem do ECGCapt

fid=fopen('filename.cfg','r');pathtosave=fgetl(fid);fclose(fid); % nome do arquivo a ser aberto
ponto=find(pathtosave=='.');pathtosave=[pathtosave(1:ponto(length(ponto))-1),'.mat']; %adapta a extensao
fid=fopen('segundos_janela.cfg','r');segundos_janela=str2num(fgetl(fid));fclose(fid); %janela de tempo mostrada no grafico
fid=fopen('ecgconvert.cfg','r');filename=fgetl(fid);fclose(fid); % nome do arquivo a ser aberto
ponto=find(filename=='.');filename=[filename(1:ponto(length(ponto))-1),'.dat']; %adapta a extensao


ecg_handle=-1; %handle do grafico do ecg
segundo=0; %posicao inicial do grafico
ecg_sinal=-1; %sinal de ECG
ecg_eventos=[]; %eventos no ECG
segundos_sinal=-1; %tamanho do ECG em segundos
ecg_totalsamples=-1; %numero total de amostras do ECG
canal=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: abrir arquivo
%

%frame
fr_abrirarquivo=uicontrol('Style','frame','Position',[80 20 490 60]);

%texto pedindo o nome do arquivo
tx_file=uicontrol('Style','text',...
   'String','Enter the full path to the DAT file to be imported:',...
   'Position',[90 50 300 20]);

%text edit para entrar com o nome do arquivo
te_file=uicontrol('Style','edit',...
   'String',filename,...
   'Position',[90 30 400 20],...
	'CallBack',[...
      'filename=get(te_file,''String'');',...
      'set(te_file,''String'',filename);',...
		'fid=fopen(''ecgconvert.cfg'',''w'');fwrite(fid,filename,''char'');fclose(fid);',...
	]);

%botao para abrir o arquivo
pb_abrir=uicontrol('Style','pushbutton',...
   'String','OPEN',...
   'Position',[500 30 60 30],...
   'CallBack',	[...
       'filename=get(te_file,''String'');',...
      '[ecg2canais, ecg_totalsamples, segundos_sinal, janelas, samplerate]=ecgconvert_abrir(filename,segundos_janela);',...
     	'if ecg_totalsamples==-1,',...
  			'set(tx_ecgerror,''String'',ecg_sinal,''Visible'',''on'');',...
			'ecg_sinal=-1;',...
			'if ecg_handle~=-1, delete(ecg_handle);ecg_handle=-1;end,',...
      	'set(fr_slider, ''Visible'', ''off'');',...      
     		'set(tx_janela_min, ''Visible'', ''off'');',...      
  			'set(sb_janela, ''Visible'', ''off'');',...      
			'set(tx_janela_max, ''Visible'', ''off'');',...      
			'set(tx_janela_lab, ''Visible'', ''off'');',...      
     	   'set(te_janela_cur, ''Visible'', ''off'');',...
     		'set(tx_deslocamento, ''Visible'', ''off'');',...
         'set(te_deslocamento, ''Visible'', ''off'');',...
  	   	'set(pb_deslocaesq, ''Visible'', ''off'');',...
         'set(pb_deslocadir, ''Visible'', ''off'');',...
      'else ',...
            'set(tx_mensagem,''Visible'',''off'');',...
  			'set(tx_ecgerror,''Visible'',''off'');',...
     	   'if segundos_sinal-segundos_janela > 0,',...
      		'set(sb_janela,''Max'',segundos_sinal-segundos_janela,''Value'',0);',...
         'else,',...   
         	'segundos_janela=segundos_sinal;',...
            'set(te_deslocamento,''String'',num2str(segundos_janela));',...
		   	'fid=fopen(''segundos_janela.cfg'',''w'');fwrite(fid,num2str(segundos_janela),''char'');fclose(fid);',...   
      		'set(sb_janela,''Max'',0,''Value'',0);',...
			'end,',...         
         'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
      	'set(tx_janela_max, ''String'',[''Max='',num2str(segundos_sinal), ''s'']);',...
  	   	'segundo=0;',...
     		'set(te_janela_cur, ''String'',num2str(segundo));',...
   		'set(fr_slider, ''Visible'', ''on'');',...      
      	'set(tx_janela_min, ''Visible'', ''on'');',...      
	  		'set(sb_janela, ''Visible'', ''on'');',...      
			'set(tx_janela_max, ''Visible'', ''on'');',...      
			'set(tx_janela_lab, ''Visible'', ''on'');',...      
         'set(te_janela_cur, ''Visible'', ''on'');',...
  	   	'set(tx_deslocamento, ''Visible'', ''on'');',...
     	   'set(te_deslocamento, ''Visible'', ''on'');',...
     		'set(pb_deslocaesq, ''Visible'', ''on'');',...
         'set(pb_deslocadir, ''Visible'', ''on'');',...
         'set(te_inicio,''String'',num2str(0));ecg_inicio=0;'...
         'set(te_fim,''String'',num2str(segundos_sinal));ecg_fim=segundos_sinal;',...         
     	'end,',...
		]);      
   
%mensagem de erro do abre arquivo ecg
tx_ecgerror=uicontrol('Style','text',...
   'Position',[80 140 500 40],...
   'Visible','off',...
   'String', ' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: visualizacao do ECG
%

%frame do slider
fr_slider=uicontrol('Style','frame','Position',[80 100 490 70],'Visible','off');

%label do minimo do slider
tx_janela_min=uicontrol('Style','text',...
   'Position',[90 140 40 20],...
   'String','Min=0s',...
	'Visible','off');

%slider que desloca o sinal
sb_janela=uicontrol('Style','slider','Position',[130 140 620-270 20],...
   'Min',0,'Max',1,...
	'Visible','off',...
	'CallBack', [...
		'segundo=round(1000*get(sb_janela,''Value''))/1000;',...     
      'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
      'set(te_janela_cur, ''String'',num2str(segundo));']);

%label do maximo do slider
tx_janela_max=uicontrol('Style','text',...
   'Position',[750-270 140 80 20],...
   'String','Max=0s',...
   'HorizontalAlignment', 'left',...
	'Visible','off');

%label do slider (janela atual)
tx_janela_lab=uicontrol('Style','text',...
   'Position',[90 110 90 20],...
   'String','Current position:',...
	'Visible','off');

%text edit que mostra/modifica a posicao da janela atual
te_janela_cur=uicontrol('Style','edit',...
   'Position',[180 110 60 20],...
   'String','0',...
   'Visible','off',...
   'CallBack',[...
      'A=str2num(get(te_janela_cur,''String''));',...
      'if length(A)==1,',...
	   	'if A(1) <= get(sb_janela,''Max'') & A(1)>=0,',...
   			'set(sb_janela,''Value'',A(1));',...
         'elseif A(1)<=get(sb_janela,''Max'')+segundos_janela & A(1)>=0,',...
   			'set(sb_janela,''Value'',get(sb_janela,''Max''));',...
	      'end,',...
   	   'segundo=round(1000*get(sb_janela,''Value''))/1000;',...     
         'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
   	'end,',...
      'set(te_janela_cur, ''String'',num2str(segundo));']);

%label do campo de deslocamento
tx_deslocamento=uicontrol('Style','text',...
   'Position',[255 110 75 20],...
   'String','Window size:',...
   'Visible','off');

%botao que desloca uma janela para esquerda
pb_deslocaesq=uicontrol('Style','pushbutton',...
   'String','<',...
	'Position',[330 110 20 20],...
   'Visible','off',...
   'Callback',[...
         'if segundo-segundos_janela >= 0,',...
	   		'segundo=segundo-segundos_janela;',...
      	'else,',...
         	'segundo=0;',...
         'end,',... 
         'set(sb_janela,''Value'',segundo);',...  
         'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
   		'set(te_janela_cur, ''String'',num2str(segundo));']);

%text edit para determinar o tamanho da janela de deslocamento
te_deslocamento=uicontrol('Style','edit',...
   'Position',[350 110 40 20],...
   'Value', segundos_janela,...
	'String',num2str(segundos_janela),...
   'Visible','off',...
   'Callback',[...
      'A=str2num(get(te_deslocamento,''String''));',...
      'if (length(A)==1) & (A(1) >= 1/samplerate) & (A<=segundos_sinal),',...
	      'segundos_janela=round(1000*A(1))/1000;',...     
      	'if A(1)+segundo>=segundos_sinal,',...
            'segundo=segundos_sinal-segundos_janela;',...
            'set(te_janela_cur,''String'',num2str(segundo));',...
            'set(sb_janela,''Value'',segundo);',...
         'end,',...
      	'if segundos_sinal-segundos_janela > 0,',...
	      	'set(sb_janela,''Max'',segundos_sinal-segundos_janela);',...
         'else,',...   
	      	'set(sb_janela,''Max'',0);',...
	    	'end,',...
         'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
      'end,',...
      'set(te_deslocamento,''String'',num2str(segundos_janela));',...
   	'fid=fopen(''segundos_janela.cfg'',''w'');fwrite(fid,num2str(segundos_janela),''char'');fclose(fid);',...   
	]);

%botao que desloca uma janela para direita
pb_deslocadir=uicontrol('Style','pushbutton',...
   'String','>',...
	'Position',[390 110 20 20],...
   'Visible','off',...
   'Callback',[...
         'if segundo+segundos_janela <= get(sb_janela,''Max''),',...
	   		'segundo=segundo+segundos_janela;',...
      	'else,',...
         	'segundo=get(sb_janela,''Max'');',...
         'end,',... 
         'set(sb_janela,''Value'',segundo);',...  
         'ecg_handle=ecgconvert_plotacanais(ecg2canais, samplerate, segundo, ecg_handle, segundos_janela, main_window);',...
   		'set(te_janela_cur, ''String'',num2str(segundo));']);  
   
fr_canal=uicontrol('Style','frame','Position',[585 20 425 150],'Visible','on');   
   
tx_canal=uicontrol('Style','text','Position',[600 135 170 20],'Visible','on',...
	'String','Choose channel to be exported:');
   
rb_canal1=uicontrol('Style','radio','Position',[600 115 80 20],'Visible','on',...
   'String','Channel 1','Value',1,'CallBack',[...
      'set(rb_canal2,''Value'',0);canal=1;']);
	   
rb_canal2=uicontrol('Style','radio','Position',[600 95 80 20],'Visible','on',...
   'String','Channel 2','Value',0,'CallBack',[...
      'set(rb_canal1,''Value'',0);canal=2;']);   

tx_inicio=uicontrol('Style','text','Position',[855 135 140 20],'Visible','on',...
   'String','Begin:                             sec');

te_inicio=uicontrol('Style','edit','Position',[890 137 80 20],'Visible','on',...
   'CallBack',[...
      'A=str2num(get(te_inicio,''String''));',...
      'if length(A)==1,',...
	   	'if A(1) < ecg_fim & A(1)>=0,',...
            'ecg_inicio=A(1);',...     
	      'end,',...         
      'end,',...
      'set(te_inicio,''String'',ecg_inicio);']);

tx_final=uicontrol('Style','text','Position',[855 115 140 20],'Visible','on',...
   'String','End:                                sec');

te_fim=uicontrol('Style','edit','Position',[890 115 80 20],'Visible','on',...
   'CallBack',[...
      'A=str2num(get(te_fim,''String''));',...
      'if length(A)==1,',...
	   	'if A(1) > ecg_inicio & A(1)<=segundos_sinal,',...
            'ecg_fim=A(1);',...     
	      'end,',...         
      'end,',...
      'set(te_fim,''String'',ecg_fim);']);

tx_salvarcomo=uicontrol('Style','text','Position',[600 50 70 20],'Visible','on','String','Save as:');
te_salvarcomo=uicontrol('Style','edit','Position',[600 30 395 20],'Visible','on','String',pathtosave);

pb_salvar=uicontrol('Style','pushbutton','Position',[920 60 70 30],...
   'Visible','on','String','Save','CallBack',[...
      'pathtosave=get(te_salvarcomo,''String'');',...
      'fid=fopen(''filename.cfg'',''w'');fwrite(fid,pathtosave,''char'');fclose(fid);',...
      'ecgconvert_salvarecg(pathtosave,ecg_inicio,ecg_fim,ecg2canais(:,canal),samplerate);']);