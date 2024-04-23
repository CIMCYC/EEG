function poincareRR

% PARA INSTRUCOES SOBRE USO, LEIA O ARQUIVO POINCARERR_README.DOC
%
%
clear %limpa a memoria do matlab
clc

global filename intervaloRR tempoRR verdadeiros ebs_indices intervaloRR_original tempoRR_original eixo1 eixo2 precisaopct pcts incl sds reta
global tabela pct102550table pct7590table handle main_window eventos prontuario pro_filename
global fr_tabelarr pb_versinal fr_prontuario tx_prontlabel pb_edita pb_atualiza fr_ectopics tx_eblabel
global rb_remove rb_interpola rb_naoremove fr_controles fr_controles2 tx_labelx4 tx_labelx5 tx_labelx6
global tx_labelx7 tx_labelx8 te_precisaopct tx_labelx1 te_eixox1 tx_labelx2 te_eixox2 tx_labelx3
global pb_html pb_tabelarr pb_print tx_stats pb_stats fr_stats cb_pcts cb_incl cb_sds rb_regressao
global rb_identidade tx_mensagem te_file tx_mensagens precisaomin precisaomax

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
figure(numerodajanela+1);close(numerodajanela+1);
figure(numerodajanela);close(numerodajanela);
main_window=figure(numerodajanela);
clf;
set(main_window,'Name','(GPDS/ENE/UnB) ECGLAB - Poincaré Analysis','Position',...
   [1,29,fig_largura,fig_altura],'Color',[.95 .95 .95])

mensageminicial=sprintf([...
      'ECGLAB - Poincaré Analysis of R-R Intervals\n\n\n',...
      'João Luiz Azevedo de Carvalho, Ph.D.\n\n\n',...
      'Digital Signal Processing Group\n',...
      'Department of Electrical Engineering\n',...
      'School of Technology\n',...      
      'University of Brasilia\n\n\n',...
      'joaoluiz@gmail.com',...
]);      
tx_mensagem=uicontrol('Style','text','String',mensageminicial,'Position',[100 150 800 500],'FontSize',14,...
   'HorizontalAlignment','center','BackgroundColor',[.95 .95 .95]);

poincarerr_callbacks(-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%inicializacao de variaveis
%
fid=fopen('filename.cfg','r');filename=fgetl(fid);fclose(fid); % nome do arquivo a ser aberto
%ponto=find(filename=='.');filename=[filename(1:ponto(length(ponto))-1),'.irr']; %adapta a extensao
eventos=[];
intervaloRR=-1;
tempoRR=-1;
intervaloRR_original=-1;
tempoRR_original=-1;
verdadeiros=-1;
ebs_indices=[];
handle=-1;
prontuario='';
pro_filename='';
eixo1=-1;
eixo2=-1;
fid=fopen('samplerate_ecg.cfg','r');samplerate_ecg=str2num(fgetl(fid));fclose(fid); %taxa de amostragem do ECGCapt
precisaopct=-1; precisaomax=10; precisaomin=(1000*1/samplerate_ecg)/2;
pcts=1;
sds=1;
incl=1;
reta=-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: abrir arquivo
%

%frame
fr_abrirarquivo=uicontrol('Style','frame','Position',[20 20 580 60],'BackgroundColor',[1 1 1]);

%texto pedindo o nome do arquivo
tx_file=uicontrol('Style','text',...
   'String','Enter the full path to the IRR or ASCII file to be opened:',...
   'Position',[30 50 300 20],'BackgroundColor',[1 1 1]);

%text edit para entrar com o nome do arquivo
te_file=uicontrol('Style','edit',...
   'String',filename,...
   'Position',[30 30 400 20],'BackgroundColor',[1 1 1],...
	'CallBack','poincarerr_callbacks(0);');

%botao para abrir o arquivo
pb_abrir_irr=uicontrol('Style','pushbutton',...
   'String','Open IRR','BackgroundColor',[1 1 1],...
   'Position',[440 30 70 30],...
   'CallBack','poincarerr_callbacks(1);');
   
%botao para abrir o arquivo
pb_abrir_ascii=uicontrol('Style','pushbutton',...
   'String','Open ASCII','BackgroundColor',[1 1 1],...
   'Position',[520 30 70 30],...
   'CallBack','poincarerr_callbacks(2);');
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: caixa de mensagens
%
   
%borda em volta da caixa de texto de mensagens 
fr_mensagens=uicontrol('Style','frame','Position',[610 20 270 60],'BackgroundColor',[1 1 1]);
   
%caixa de texto para mensagens
tx_mensagens=uicontrol('Style','text',...
   'Position',[614 30 260 40],'BackgroundColor',[1 1 1],...
   'String', ['IRR files are the ones obtained from ECGLabRR or EctopicsRR. R-R intervals in ASCII must ',...
      'contain a single interval value per line.']);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: edicao do prontuario
%

fr_prontuario=uicontrol('Style','frame','Position',[780 100 90 85],'Visible','off','BackgroundColor',[1 1 1]);
tx_prontlabel=uicontrol('Style','text','Position',[785 160 80 15],'Visible','off','BackgroundColor',[1 1 1],'String','Patient Record','horiz','cent');

pb_edita=uicontrol('Style','pushbutton','Position',[790 135 70 20],'Visible','off','BackgroundColor',[1 1 1],'String','Edit',...
   'CallBack','poincarerr_callbacks(3);');

pb_atualiza=uicontrol('Style','pushbutton','Position',[790 110 70 20],'Visible','off','BackgroundColor',[1 1 1],'String','View/Update',...
   'CallBack','poincarerr_callbacks(4);');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: remocao/interpolacao de batimentos ectopicos
%

fr_ectopics=uicontrol('Style','frame','Position',[630 90 140 100],'Visible','off','BackgroundColor',[1 1 1]);
tx_eblabel=uicontrol('Style','text','Position',[640 160 120 20],'Visible','off','BackgroundColor',[1 1 1],'String','Ectopic Beats:','horiz','left');

rb_remove=uicontrol('Style','radio','Position',[640 140 120 20],'Visible','off','BackgroundColor',[1 1 1],'String','Remove','Value',0,...
   'CallBack','poincarerr_callbacks(5);');

rb_interpola=uicontrol('Style','radio','Position',[640 120 120 20],'Visible','off','BackgroundColor',[1 1 1],'String','Remove & Interpolate','Value',1,...
   'CallBack','poincarerr_callbacks(6);');

rb_naoremove=uicontrol('Style','radio','Position',[640 100 120 20],'Visible','off','BackgroundColor',[1 1 1],'String','Don''t Remove','Value',0,...
   'CallBack','poincarerr_callbacks(7);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: limites do grafico
%

fr_controles=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','frame','Position',[860 200 150 60]);
fr_controles2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','frame','Position',[630 200 215 60]);

% caixas de texto (label)
tx_labelx4=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','Percentile ±',...
   'Position',[637 207 56 20]);

% caixas de edicao de texto (pontos finais do grafico)
te_precisaopct=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[695 207 50 20],...
   'Value', precisaopct,...
	'String',num2str(precisaopct),...
   'Callback','poincarerr_callbacks(8);');

% caixas de texto (label)
tx_labelx5=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','ms',...
   'Position',[750 207 15 20]);

% caixas de texto (label)
tx_labelx7=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text','hor','left',...
   'String',['(min: ' num2str(precisaomin) ' ms)'],...
   'Position',[770 217 70 15]);

% caixas de texto (label)
tx_labelx8=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text','hor','left',...
   'String',['(max: ' num2str(precisaomax) ' ms)'],...
   'Position',[770 201 70 15]);

% caixas de texto (label)
tx_labelx1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','Show from',...
   'Position',[640 233 50 20]);

% caixas de edicao de texto (pontos finais do grafico)
te_eixox1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[695 233 50 20],...
   'Value', eixo1,...
	'String',num2str(eixo1),...
   'Callback','poincarerr_callbacks(9);');

% caixas de texto (label)
tx_labelx2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','to',...
   'Position',[750 233 15 20]);

% caixas de edicao de texto (pontos finais do grafico)
te_eixox2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[770 233 50 20],...
   'Value', eixo2,...
	'String',num2str(eixo2),...
   'Callback','poincarerr_callbacks(10);');

% caixas de texto (label)
tx_labelx3=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','ms',...
   'Position',[825 233 12 20]);

% caixas de texto (label)
tx_labelx6=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','Display:',...
   'Position',[870 222 45 15]);

cb_sds=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','checkbox',...
   'String','SD1 & SD2','Value',sds,...
   'Position',[925 239 75 15],'CallBack','poincarerr_callbacks(11);');
 
cb_incl=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','checkbox',...
   'String','Slope','Value',incl,...
   'Position',[925 222 75 15],'CallBack','poincarerr_callbacks(12);');

cb_pcts=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','checkbox',...
   'String','Percentiles','Value',pcts,...
   'Position',[925 205 64 15],'CallBack','poincarerr_callbacks(13);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: estatistica
%

fr_stats=uicontrol('Style','frame','Position',[630 270 380 420],'Visible','off','BackgroundColor',[1 1 1]);
tx_stats=uicontrol('Style','text','Position',[640 280 360 400],...
   'Visible','off','BackgroundColor',[1 1 1],'Hor','left','Fontname','Courier','FontSize',8);

pb_stats=uicontrol('Style','pushbutton','Position',[849 280 150 30],...
   'Visible','off','BackgroundColor',[1 1 1],'String','Percentile Statistics',...
   'CallBack','poincarerr_callbacks(14);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: gera html
%

pb_html=uicontrol('Style','push','Position',[890 25 120 50],'Visible','off','BackgroundColor',[1 1 1],...
   'String','HTML Report','CallBack','poincarerr_callbacks(15);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: tabela dos R-R
%

fr_tabelarr=uicontrol('Style','frame','Position',[880 90 130 100],'Visible','off','BackgroundColor',[1 1 1]);

pb_versinal=uicontrol('Style','push','Position',[890 158 110 25],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Display R-R Signal','CallBack','poincarerr_callbacks(16);');

pb_tabelarr=uicontrol('Style','push','Position',[890 128 110 25],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Display Intervals','CallBack','poincarerr_callbacks(17);');

pb_print=uicontrol('Style','push','Position',[890 98 110 25],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Print Table','CallBack','poincarerr_callbacks(18);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: para escolher entre regressao e identidade
%

rb_regressao=uicontrol('Style','radio','Position',[650 300 150 20],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Regression Line','CallBack','poincarerr_callbacks(19);');

rb_identidade=uicontrol('Style','radio','Position',[650 280 150 20],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Identity Line','CallBack','poincarerr_callbacks(20);');
