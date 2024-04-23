function mostrar_prontuario(prontuario)
%usage: 

figure_handle=101;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reinicia a janela
figure(figure_handle),close(figure_handle),figure(figure_handle),clf,
set(figure_handle,'Name','ECGLAB - Patient Record','Color',[.95 .95 .95]),

%fr_prontuario=uicontrol('Style','frame','Position',[2 2 556 416]);
tx_prontuario=uicontrol('Style','text','Units','normal','Position',[.025 0 1 1-.025],'String',prontuario,'horiz','left','backg',[.95 .95 .95]);