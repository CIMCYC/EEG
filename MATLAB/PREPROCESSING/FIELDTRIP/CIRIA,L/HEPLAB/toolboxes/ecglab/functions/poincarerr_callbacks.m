function poincarerr_callbacks(id)

global filename intervaloRR tempoRR verdadeiros ebs_indices intervaloRR_original tempoRR_original eixo1 eixo2 precisaopct pcts incl sds reta
global tabela pct102550table pct7590table handle main_window eventos prontuario pro_filename
global fr_tabelarr pb_versinal fr_prontuario tx_prontlabel pb_edita pb_atualiza fr_ectopics tx_eblabel
global rb_remove rb_interpola rb_naoremove fr_controles fr_controles2 tx_labelx4 tx_labelx5 tx_labelx6
global tx_labelx7 tx_labelx8 te_precisaopct tx_labelx1 te_eixox1 tx_labelx2 te_eixox2 tx_labelx3
global pb_html pb_tabelarr pb_print tx_stats pb_stats fr_stats cb_pcts cb_incl cb_sds rb_regressao
global rb_identidade tx_mensagem te_file tx_mensagens precisaomin precisaomax

switch(id)

%te_file
case 0,
      filename=get(te_file,'String');
      set(te_file,'String',filename);
	fid=fopen('filename.cfg','w');
    fwrite(fid,filename,'char');
    fclose(fid);

%pb_abrir_irr
case 1,
      filename=get(te_file,'String');
      [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR(filename);
      intervaloRR_original=intervaloRR;tempoRR_original=tempoRR;
		if intervaloRR(1)~=-1,
  	      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
   		[eixo1,eixo2,precisaopct,pcts,incl,sds,reta]=poincareRR_le_cfg;
         poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
      	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
         set(tx_stats,'String',tabela);
	      if ~isempty(find(get(0,'children')==main_window+1)),
		      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
	      end,
   		set(tx_mensagens, 'String', ' ');
   		eventos=le_eventos(filename);
         [prontuario,pro_filename]=le_prontuario(filename,eventos);
      	set(fr_tabelarr,'Visible','on');
      	set(pb_versinal,'Visible','on');
      	set(fr_prontuario,'Visible','on');
			set(tx_prontlabel,'Visible','on');
			set(pb_edita,'Visible','on');
         set(pb_atualiza,'Visible','on');
			set(fr_ectopics,'Visible','on');
			set(tx_eblabel,'Visible','on');
			set(rb_remove,'Visible','on','Value',0);
			set(rb_interpola,'Visible','on','Value',1);
         set(rb_naoremove,'Visible','on','Value',0);
         set(fr_controles,'Visible','on');
	      set(fr_controles2,'Visible','on');
	      set(tx_labelx4,'Visible','on');
	      set(tx_labelx5,'Visible','on');
	      set(tx_labelx6,'Visible','on');
	      set(tx_labelx7,'Visible','on');
	      set(tx_labelx8,'Visible','on');
	      set(te_precisaopct,'Visible','on','String',num2str(precisaopct));
   	   set(tx_labelx1,'Visible','on');
      	set(te_eixox1,'Visible','on','String',num2str(eixo1));
   	   set(tx_labelx2,'Visible','on');
      	set(te_eixox2,'Visible','on','String',num2str(eixo2));
	      set(tx_labelx3,'Visible','on');
      	set(pb_html,'Visible','on');
			set(pb_tabelarr,'Visible','on');
			set(pb_print,'Visible','on');
			set(tx_stats,'Visible','on');
         set(pb_stats,'Visible','on');   
         set(fr_stats,'Visible','on');   
         set(cb_pcts,'Visible','on','Value',pcts);
      	set(cb_incl,'Visible','on','Value',incl);
         set(cb_sds,'Visible','on','Value',sds);
         set(rb_regressao,'Visible','on','Value',0);
      	set(rb_identidade,'Visible','on','Value',0);
        if reta(1)=='r',set(rb_regressao,'Value',1);
        else set(rb_identidade,'Value',1);
        end;
        set(tx_mensagem,'Visible','off');
      else,
	      set(tx_mensagens, 'String', 'This file does not contain R-R intervals!');
         eventos=[];pro_filename=[];prontuario=[];
         if handle~=-1, delete(handle);handle=-1;end,
      	set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
			set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
			set(fr_ectopics,'Visible','off');
			set(tx_eblabel,'Visible','off');
			set(rb_remove,'Visible','off');
			set(rb_interpola,'Visible','off');
         set(rb_naoremove,'Visible','off');
	      set(fr_controles,'Visible','off');
   	   set(tx_labelx1,'Visible','off');
      	set(te_eixox1,'Visible','off');
   	   set(tx_labelx2,'Visible','off');
      	set(te_eixox2,'Visible','off');
	      set(tx_labelx3,'Visible','off');
         set(pb_html,'Visible','off');
			set(pb_tabelarr,'Visible','off');
			set(pb_print,'Visible','off');
			set(tx_stats,'Visible','off');
         set(fr_stats,'Visible','off');   
      	set(fr_tabelarr,'Visible','off');
         set(pb_versinal,'Visible','off');
         set(cb_pcts,'Visible','off');
      	set(cb_incl,'Visible','off');
         set(cb_sds,'Visible','off');
	      set(fr_controles2,'Visible','off');
	      set(tx_labelx4,'Visible','off');
	      set(tx_labelx5,'Visible','off');
         set(tx_labelx6,'Visible','off');
	      set(tx_labelx7,'Visible','off');
	      set(tx_labelx8,'Visible','off');
         set(te_precisaopct,'Visible','off');
         set(pb_stats,'Visible','off');   
         set(rb_regressao,'Visible','off');
      	set(rb_identidade,'Visible','off');
        set(tx_mensagem,'Visible','on');        
      end,
    
%pb_abrir_ascii
case 2,
      filename=get(te_file,'String');
      [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR_ascii(filename);
      intervaloRR_original=intervaloRR;tempoRR_original=tempoRR;
		if intervaloRR(1)~=-1,
	      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
   		[eixo1,eixo2,precisaopct,pcts,incl,sds,reta]=poincareRR_le_cfg;
      	poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
      	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
         set(tx_stats,'String',tabela);
	      if ~isempty(find(get(0,'children')==main_window+1)),
		      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
	      end,
   		set(tx_mensagens, 'String', ' ');
   		eventos=[];
         [prontuario,pro_filename]=le_prontuario(filename,eventos);
         set(cb_pcts,'Visible','on','Value',pcts);
      	set(cb_incl,'Visible','on','Value',incl);
      	set(cb_sds,'Visible','on','Value',sds);
      	set(fr_prontuario,'Visible','on');
			set(tx_prontlabel,'Visible','on');
			set(pb_edita,'Visible','on');
         set(pb_atualiza,'Visible','on');
			set(fr_ectopics,'Visible','off');
			set(tx_eblabel,'Visible','off');
			set(rb_remove,'Visible','off','Value',0);
			set(rb_interpola,'Visible','off','Value',1);
         set(rb_naoremove,'Visible','off','Value',0);
	      set(fr_controles,'Visible','on');
   	   set(tx_labelx1,'Visible','on');
      	set(te_eixox1,'Visible','on','String',num2str(eixo1));
   	   set(tx_labelx2,'Visible','on');
      	set(te_eixox2,'Visible','on','String',num2str(eixo2));
	      set(tx_labelx3,'Visible','on');
         set(pb_html,'Visible','on');
			set(pb_tabelarr,'Visible','on');
			set(pb_print,'Visible','on');
			set(tx_stats,'Visible','on');
         set(fr_stats,'Visible','on');   
      	set(fr_tabelarr,'Visible','on');
         set(pb_versinal,'Visible','on');
	      set(fr_controles2,'Visible','on');
	      set(tx_labelx4,'Visible','on');
	      set(tx_labelx5,'Visible','on');
	      set(tx_labelx6,'Visible','on');
	      set(tx_labelx7,'Visible','on');
	      set(tx_labelx8,'Visible','on');
         set(te_precisaopct,'Visible','on','String',num2str(precisaopct));
         set(pb_stats,'Visible','on');   
         set(rb_regressao,'Visible','on','Value',0);
      	set(rb_identidade,'Visible','on','Value',0);
        if reta(1)=='r',set(rb_regressao,'Value',1);
        else set(rb_identidade,'Value',1);
        end;
        set(tx_mensagem,'Visible','off');        
      else,
      	set(tx_mensagens, 'String', 'This file does not contain R-R intervals! Each line must contain only 1 interval value!');
         eventos=[];pro_filename=[];prontuario=[];
			set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
         if handle~=-1, delete(handle);handle=-1;end,
      	set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
			set(fr_ectopics,'Visible','off');
			set(tx_eblabel,'Visible','off');
			set(rb_remove,'Visible','off');
			set(rb_interpola,'Visible','off');
			set(rb_naoremove,'Visible','off');
	      set(fr_controles,'Visible','off');
   	   set(tx_labelx1,'Visible','off');
      	set(te_eixox1,'Visible','off');
   	   set(tx_labelx2,'Visible','off');
      	set(te_eixox2,'Visible','off');
	      set(tx_labelx3,'Visible','off');
         set(pb_html,'Visible','off');
			set(pb_tabelarr,'Visible','off');
			set(pb_print,'Visible','off');
			set(tx_stats,'Visible','off');
         set(fr_stats,'Visible','off');   
      	set(fr_tabelarr,'Visible','off');
         set(pb_versinal,'Visible','off');
         set(cb_pcts,'Visible','off');
      	set(cb_incl,'Visible','off');
         set(cb_sds,'Visible','off');
	      set(fr_controles2,'Visible','off');
	      set(tx_labelx4,'Visible','off');
	      set(tx_labelx5,'Visible','off');
         set(tx_labelx6,'Visible','off');
	      set(tx_labelx7,'Visible','off');
	      set(tx_labelx8,'Visible','off');
         set(te_precisaopct,'Visible','off');
         set(pb_stats,'Visible','off');   
         set(rb_regressao,'Visible','off');
      	set(rb_identidade,'Visible','off');
        set(tx_mensagem,'Visible','on');        
      end,
    
 %pb_edita
case 3,
  	dos(['write ',pro_filename]);
      set(tx_mensagens,'String','When you are done editing the patient''s record on Wordpad, please save the file and click on VIEW/UPDATE.');

%pb_atualiza
case 4,
      prontuario=le_prontuario(pro_filename,eventos);
      mostrar_prontuario(prontuario);
      set(tx_mensagens,'String','');
  
%rb_remove
case 5,
      set(rb_remove   ,'Value',1);
      set(rb_interpola,'Value',0);
      set(rb_naoremove,'Value',0);
      tempoRR=tempoRR_original(verdadeiros);
      intervaloRR=intervaloRR_original(verdadeiros);
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
      set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,

%rb_interpola
case 6,
      set(rb_remove   ,'Value',0);
      set(rb_interpola,'Value',1);
      set(rb_naoremove,'Value',0);
      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
     	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
     	set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,

%rb_naoremove
case 7,
      set(rb_remove   ,'Value',0);
      set(rb_interpola,'Value',0);
      set(rb_naoremove,'Value',1);
      tempoRR=tempoRR_original;
      intervaloRR=intervaloRR_original;
     	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
     	set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,

%te_precisaopct
case 8,
      A=str2num(get(te_precisaopct,'String'));
      if length(A)==1,
	   	if A >=precisaomin & A<=precisaomax,
         	precisaopct=A;
	      end,
   	end,
      [tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
     	set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,
      set(te_precisaopct,'String',num2str(precisaopct));
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);

%te_eixox1
case 9,
     A=str2num(get(te_eixox1,'String'));
      if length(A)==1,
	   	if A >=0 & A<eixo2,
         	eixo1=floor(A); %tira as casas decimais
	      end,
   	end,
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
      set(te_eixox1,'String',num2str(eixo1));
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);

%te_eixox2
case 10,
      A=str2num(get(te_eixox2,'String'));
      if length(A)==1,
	   	if A >eixo1,
         	eixo2=floor(A); %tira as casas decimais
	      end,
   	end,
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
      set(te_eixox2,'String',num2str(eixo2));
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);

%cb_sds
case 11,
      sds = ~sds;
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);

%cb_incl
case 12,
     incl = ~incl;
     poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);

%cb_pcts
case 13,
      pcts = ~pcts;
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
    	[tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);

%pb_stats
case 14,
      poincareRR_tabelapct(pct102550table,pct7590table,main_window);

%pb_html
case 15,
	poincareRR_gera_html(filename,prontuario,intervaloRR,eixo1,eixo2,precisaopct,sds,incl,pcts,reta);      

%pb_versinal
case 16,
      temporalRR_intervalograma2(tempoRR,intervaloRR,eventos,'evnt',min(tempoRR(find(tempoRR>0))),max(tempoRR),min(intervaloRR)-25,max(intervaloRR)+25);      

%pb_tabelarr
case 17,
	temporalRR_tabelaRR(intervaloRR);      

%pb_print
case 18,
  	dos(['write ',salva_irr_txt(intervaloRR,[],filename)]);      

%rb_regressao
case 19,
      set(rb_regressao,'Value',1);      
      set(rb_identidade,'Value',0);
      reta='regressao';
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
      [tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
     	set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,

%rb_identidade
case 20,
      set(rb_regressao,'Value',0);      
      set(rb_identidade,'Value',1);      
      reta='identidade';
      poincareRR_salva_cfg(eixo1,eixo2,precisaopct,pcts,incl,sds,reta);
      [tabela,pct102550table,pct7590table,handle]=poincareRR_grafico(intervaloRR,eixo1,eixo2,precisaopct,handle,pcts,sds,incl,reta);
     	set(tx_stats,'String',tabela);
      if ~isempty(find(get(0,'children')==main_window+1)),
	      poincareRR_tabelapct(pct102550table,pct7590table,main_window);
      end,
    
otherwise,
    
end;