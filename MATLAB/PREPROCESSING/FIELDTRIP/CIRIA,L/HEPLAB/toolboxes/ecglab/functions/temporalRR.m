function temporalRR

% PARA INSTRUCOES SOBRE USO, LEIA O ARQUIVO TEMPORALRR_README.DOC
%
%
clear %limpa a memoria do matlab
clc %limpa a tela de comando

global filename intervaloRR tempoRR verdadeiros ebs_indices tempoRR_original intervaloRR_original eventos prontuario pro_filename
global abscissa unidade_eixox eixox1 eixox2 eixoy1 eixoy2 minimox limitex outliers tabela_stats bp_handle rr_handle
global te_file tx_mensagens rb_beat rb_time rb_evnt
global fr_prontuario tx_prontlabel pb_edita pb_atualiza fr_ectopics tx_eblabel rb_remove rb_interpola rb_naoremove
global fr_controles tx_labelx1 tx_labely1 te_eixox1 te_eixoy1 tx_labelx2 tx_labely2 te_eixox2 te_eixoy2 tx_labelx3
global tx_labelx4 tx_labelx5 tx_labely3 cb_outliers pb_html pb_tabelarr pb_print tx_stats fr_stats tx_mensagem

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%estes parametros podem ser facilmente alterados para personalizacao:
%

numerodajanela=100; %numero da figura do MatLab a ser usada como janela principal
fig_largura=1024;fig_altura=702; %largura e altura da janela do programa

temporalrr_callbacks(-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cria a tela do programa
%
figure(numerodajanela+1);close(numerodajanela+1);
figure(numerodajanela);close(numerodajanela);
main_window=figure(numerodajanela);
clf;
set(main_window,'Name','(GPDS/ENE/UnB) ECGLAB - Time-Domain Analysis','Position',[1,29,fig_largura,fig_altura],'Color',[.95 .95 .95])

mensageminicial=sprintf([...
      'ECGLAB - Time-Domain of R-R Intervals\n\n\n',...
      'João Luiz Azevedo de Carvalho, Ph.D.\n\n\n',...
      'Digital Signal Processing Group\n',...
      'Department of Electrical Engineering\n',...
      'School of Technology\n',...      
      'University of Brasilia\n\n\n',...
      'joaoluiz@gmail.com',...
]);       
tx_mensagem=uicontrol('Style','text','String',mensageminicial,'Position',[100 150 800 500],'FontSize',14,...
   'HorizontalAlignment','center','BackgroundColor',[.95 .95 .95]);

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
rr_handle=-1;
bp_handle=-1;
prontuario='';
pro_filename='';
abscissa='';
unidade_eixox='';
eixox1=-1;
eixox2=-1;
eixoy1=-1;
eixoy2=-1;
minimox=-1;
limitex=-1;
outliers=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: abrir arquivo
%

%frame
fr_abrirarquivo=uicontrol('Style','frame','Position',[80 20 580 60],'BackgroundColor',[1 1 1]);

%texto pedindo o nome do arquivo
tx_file=uicontrol('Style','text',...
   'String','Enter the full path to the IRR or ASCII file to be opened:',...
   'Position',[90 50 300 20],'BackgroundColor',[1 1 1]);

%text edit para entrar com o nome do arquivo
te_file=uicontrol('Style','edit',...
   'String',filename,...
   'Position',[90 30 400 20],...
	'CallBack','temporalrr_callbacks(0);','BackgroundColor',[1 1 1]);

%botao para abrir o arquivo
pb_abrir_irr=uicontrol('Style','pushbutton',...
   'String','Open IRR',...
   'Position',[500 30 70 30],'BackgroundColor',[1 1 1],...
   'CallBack','temporalrr_callbacks(1);');
   
%botao para abrir o arquivo
pb_abrir_ascii=uicontrol('Style','pushbutton',...
   'String','Open ASCII',...
   'Position',[580 30 70 30],'BackgroundColor',[1 1 1],...
   'CallBack','temporalrr_callbacks(2);');
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: caixa de mensagens
%
   
%borda em volta da caixa de texto de mensagens 
fr_mensagens=uicontrol('Style','frame','Position',[680 20 300 60],'BackgroundColor',[1 1 1]);
   
%caixa de texto para mensagens
tx_mensagens=uicontrol('Style','text',...
   'Position',[690 30 280 40],'BackgroundColor',[1 1 1],...
   'String', ['IRR files are the ones obtained from ECGLabRR or EctopicsRR. R-R intervals in ASCII must ',...
      'contain a single interval value per line.']);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: edicao do prontuario
%

fr_prontuario=uicontrol('Style','frame','Position',[80 100 250 40],'Visible','off','BackgroundColor',[1 1 1]);
tx_prontlabel=uicontrol('Style','text','Position',[90 105 50 30],'Visible','off','BackgroundColor',[1 1 1],'String','Patient Record:','horiz','left');

pb_edita=uicontrol('Style','pushbutton','Position',[150 110 80 20],'Visible','off','BackgroundColor',[1 1 1],'String','Edit',...
   'CallBack','temporalrr_callbacks(3);');

pb_atualiza=uicontrol('Style','pushbutton','Position',[240 110 80 20],'Visible','off','BackgroundColor',[1 1 1],'String','View/Update',...
   'CallBack','temporalrr_callbacks(4);');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: remocao/interpolacao de batimentos ectopicos
%

fr_ectopics=uicontrol('Style','frame','Position',[350 100 420 40],'Visible','off','BackgroundColor',[1 1 1]);
tx_eblabel=uicontrol('Style','text','Position',[360 110 200 20],'Visible','off','BackgroundColor',[1 1 1],'String','Ectopic Beats:','horiz','left');

rb_remove=uicontrol('Style','radio','Position',[470 110 100 20],'Visible','off','BackgroundColor',[1 1 1],'String','Remove','Value',0,...
   'CallBack','temporalrr_callbacks(5);');

rb_interpola=uicontrol('Style','radio','Position',[540 110 120 20],'Visible','off','BackgroundColor',[1 1 1],'String','Remove & Interpolate','Value',1,...
   'CallBack','temporalrr_callbacks(6);');

rb_naoremove=uicontrol('Style','radio','Position',[670 110 90 20],'Visible','off','BackgroundColor',[1 1 1],'String','Don''t Remove','Value',0,...
   'CallBack','temporalrr_callbacks(7);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: limites do intervalograma
%

fr_controles=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','frame','Position',[80 160 470 70]);

% caixas de texto (label)
tx_labelx1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','From',...
   'Position',[83 200 23 20]);

tx_labely1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','From',...
   'Position',[83 170 23 20]);

% caixas de edicao de texto (pontos iniciais do grafico)
te_eixox1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[108 200 40 20],...
   'Value', eixox1,...
	'String',num2str(eixox1),...
   'Callback','temporalrr_callbacks(8);');

te_eixoy1=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[108 170 40 20],...
   'Value', eixoy1,...
	'String',num2str(eixoy1),...
   'Callback','temporalrr_callbacks(9);');

% caixas de texto (label)
tx_labelx2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','to',...
   'Position',[153 200 10 20]);

tx_labely2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','to',...
   'Position',[153 170 10 20]);

% caixas de edicao de texto (pontos finais do grafico)
te_eixox2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[168 200 40 20],...
   'Value', eixox2,...
	'String',num2str(eixox2),...
   'Callback','temporalrr_callbacks(10);');

te_eixoy2=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','edit',...
   'Position',[168 170 40 20],...
   'Value', eixoy2,...
	'String',num2str(eixoy2),...
   'Callback','temporalrr_callbacks(11);');

% caixas de texto (label)
tx_labelx3=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String',unidade_eixox,...
   'Position',[213 200 55 20]);

tx_labelx5=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String',['min:  ',num2str(limitex)],...
   'Hor','left',...
	'Position',[275 213 65 13]);

tx_labelx4=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String',['max: ',num2str(limitex)],...
   'Hor','left',...
   'Position',[275 200 65 13]);

tx_labely3=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','text',...
   'String','milliseconds',...
   'Position',[213 170 55 20]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% escolha tempo x batimento
%

rb_beat=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','radio',...
   'String','R-R Interval x Interval Number',...
   'Position',[350 205 190 20],...
   'Value',0,...
   'Callback','temporalrr_callbacks(12);');

rb_time=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','radio',...
   'String','R-R Interval x Time (seconds)',...
   'Position',[350 185 190 20],...
   'Value',0,...
   'Callback','temporalrr_callbacks(13);');
   
rb_evnt=uicontrol('Visible','off','BackgroundColor',[1 1 1],'Style','radio',...
   'String','Show Events: Interval x Time',...
   'Position',[350 165 190 20],...
   'Value',1,...
   'Callback','temporalrr_callbacks(14);');   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: estatistica
%

fr_stats=uicontrol('Style','frame','Position',[810 425 200 250],'Visible','off','BackgroundColor',[1 1 1]);
tx_stats=uicontrol('Style','text','Position',[820 435 180 230],...
   'Visible','off','BackgroundColor',[1 1 1],'Hor','left','Fontname','Terminal','FontSize',6);
tx_null=uicontrol('Style','text','Position',[923 80 10 9],'BackgroundColor',[.95 .95 .95]); %pra tampar o '1' que aparece no boxplot

cb_outliers=uicontrol('Style','checkbox','Position',[280 170 60 20],'Visible','off','BackgroundColor',[1 1 1],...
   'Value',outliers,'String','Outliers','CallBack','temporalrr_callbacks(15);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: gera html
%

pb_html=uicontrol('Style','push','Position',[680 170 110 50],'Visible','off','BackgroundColor',[1 1 1],...
   'String','HTML Report','CallBack','temporalrr_callbacks(16);');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GUI: tabela dos R-R
%

pb_tabelarr=uicontrol('Style','push','Position',[560 200 110 30],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Table of Intervals','CallBack','temporalrr_callbacks(17);');

pb_print=uicontrol('Style','push','Position',[560 160 110 30],'Visible','off','BackgroundColor',[1 1 1],...
   'String','Print Table','CallBack','temporalrr_callbacks(18);');

