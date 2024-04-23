function poincareRR_tabelapct(pct102550table,pct7590table,main_window)

h=figure(main_window+1);
clf,

%janela=[590 390 435 320];
janela=[620   275   235   435];


set(h,'position',janela,'name','ECGLAB - Poincaré Plot / Percentile Stats','Color',[.95 .95 .95]);

%tx_pctstats1=uicontrol('Style','text','Units','normalized','Position',[0 0 .5 1],...
%   'Visible','on','Hor','left','backgr',[.8 .8 .8],...
%	'Fontname','Terminal','FontSize',6,'String',pct102550table);
%tx_pctstats2=uicontrol('Style','text','Units','normalized','Position',[.5 0 .5 1],...
%   'Visible','on','Hor','left','backgr',[.8 .8 .8],...
%   'Fontname','Terminal','FontSize',6,'String',pct7590table);

pctstats=[pct102550table,pct7590table];
tx_pctstats=uicontrol('Style','text','Units','normalized','Position',[0 0 1 1],...
   'Visible','on','Hor','left','backgr',[.95 .95 .95],...
	'Fontname','Terminal','FontSize',6,'String',pctstats);


