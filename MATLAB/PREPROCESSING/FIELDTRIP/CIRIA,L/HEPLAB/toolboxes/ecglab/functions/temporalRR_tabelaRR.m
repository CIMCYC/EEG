function temporalRR_tabelaRR(intervaloRR)
% usage: temporalRR_tabelaRR(intervaloRR)

fig_largura=1024;fig_altura=702; %largura e altura da janela do programa

%fecha a janela 6 (se existir, e abre uma nova)
handle=101;
tabelaRR_handle=figure(handle);
close(tabelaRR_handle);
tabelaRR_handle=figure(handle);
set(tabelaRR_handle,'Color','w','Name','Table of R-R Intervals','Position',[1,29,fig_largura,fig_altura]);

tabelaRRtexto=[sprintf(['\n                                                    ',...
         'Table of R-R Intervals, in milliseconds ',...
      '(values arranged IN ROWS)\n\n']),tabela_horizontal(intervaloRR,1000,34)];

%caixa de texto para a tabela dos intervalos R-R
tx_tabelaRR=uicontrol('Style','text','Units','normalized','Position',[0 0 1 1],...
	'String',tabelaRRtexto,'FontName','Terminal','FontSize',6,...
   'HorizontalAlignment','left','BackgroundColor','w');   

