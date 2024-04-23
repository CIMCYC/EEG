function temporalrr_callbacks(id)

global filename intervaloRR tempoRR verdadeiros ebs_indices tempoRR_original intervaloRR_original eventos prontuario pro_filename
global abscissa unidade_eixox eixox1 eixox2 eixoy1 eixoy2 minimox limitex outliers tabela_stats bp_handle rr_handle
global te_file tx_mensagens rb_beat rb_time rb_evnt
global fr_prontuario tx_prontlabel pb_edita pb_atualiza fr_ectopics tx_eblabel rb_remove rb_interpola rb_naoremove
global fr_controles tx_labelx1 tx_labely1 te_eixox1 te_eixoy1 tx_labelx2 tx_labely2 te_eixox2 te_eixoy2 tx_labelx3
global tx_labelx4 tx_labelx5 tx_labely3 cb_outliers pb_html pb_tabelarr pb_print tx_stats fr_stats tx_mensagem

switch(id)

    %te_file
case 0,
      filename=get(te_file,'String');
      set(te_file,'String',filename);
	%fid=fopen('filename.cfg','w');fwrite(fid,filename,'char');fclose(fid);
  
%pb_abrir_irr
case 1,
      filename=get(te_file,'String');
      [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR(filename);
      intervaloRR_original=intervaloRR;tempoRR_original=tempoRR;
		if intervaloRR(1)~=-1,
	      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
   		[abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers]=temporalRR_le_cfg(filename,intervaloRR,tempoRR);
         temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
	      if abscissa=='beat',limitex=length(tempoRR);else limitex=ceil(max(tempoRR));end,
      	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
      	set(tx_stats,'String',tabela_stats);
   		set(tx_mensagens, 'String', ' ');
   		eventos=le_eventos(filename);
         [prontuario,pro_filename]=le_prontuario(filename,eventos);
      	set(rb_beat,'Visible','on','Value',0);
   	   set(rb_time,'Visible','on','Value',0);
         set(rb_evnt,'Visible','on','Value',0);
         if abscissa=='beat',set(rb_beat,'Value',1);
   	   elseif abscissa=='time',set(rb_time,'Value',1);
         elseif abscissa=='evnt',set(rb_evnt,'Value',1);end,
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
   	   set(tx_labelx1,'Visible','on');
	      set(tx_labely1,'Visible','on');
      	set(te_eixox1,'Visible','on','String',num2str(eixox1));
   	   set(te_eixoy1,'Visible','on','String',num2str(eixoy1));
	      set(tx_labelx2,'Visible','on');
      	set(tx_labely2,'Visible','on');
   	   set(te_eixox2,'Visible','on','String',num2str(eixox2));
	      set(te_eixoy2,'Visible','on','String',num2str(eixoy2));
      	set(tx_labelx3,'Visible','on','String',unidade_eixox);
         set(tx_labelx4,'Visible','on','String',['max: ',num2str(limitex)]);
   	   set(tx_labelx5,'Visible','on','String',['min:  ',num2str(minimox)]);
	      set(tx_labely3,'Visible','on');
	      set(cb_outliers,'Visible','on','Value',outliers);
      	set(pb_html,'Visible','on');
			set(pb_tabelarr,'Visible','on');
			set(pb_print,'Visible','on');
			set(tx_stats,'Visible','on');
			set(fr_stats,'Visible','on');   
            set(tx_mensagem,'Visible','off');
         rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      else,
	      set(tx_mensagens, 'String', 'This file does not contain R-R intervals!');
         eventos=[];pro_filename=[];prontuario=[];
         if rr_handle~=-1, delete(rr_handle);rr_handle=-1;end,
			if bp_handle~=-1, delete(bp_handle);bp_handle=-1;end,
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
	      set(tx_labely1,'Visible','off');
      	set(te_eixox1,'Visible','off');
   	   set(te_eixoy1,'Visible','off');
	      set(tx_labelx2,'Visible','off');
      	set(tx_labely2,'Visible','off');
   	   set(te_eixox2,'Visible','off');
	      set(te_eixoy2,'Visible','off');
      	set(tx_labelx3,'Visible','off');
         set(tx_labelx4,'Visible','off');
   	   set(tx_labelx5,'Visible','off');
	      set(tx_labely3,'Visible','off');
      	set(rb_beat,'Visible','off');
   	   set(rb_time,'Visible','off');
         set(rb_evnt,'Visible','off');
         set(pb_html,'Visible','off');
			set(pb_tabelarr,'Visible','off');
			set(pb_print,'Visible','off');
			set(tx_stats,'Visible','off');
         set(fr_stats,'Visible','off');   
	      set(cb_outliers,'Visible','off');
          set(tx_mensagem,'Visible','on');
      end,
    
%pb_abrir_ascii
case 2,
      filename=get(te_file,'String');
      [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR_ascii(filename);
      intervaloRR_original=intervaloRR;tempoRR_original=tempoRR;
		if intervaloRR(1)~=-1,
	      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
   		[abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers]=temporalRR_le_cfg(filename,intervaloRR,tempoRR);
         temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
	      if abscissa=='beat',limitex=length(tempoRR);else limitex=ceil(max(tempoRR));end,
      	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
	     	set(tx_stats,'String',tabela_stats);
   		set(tx_mensagens, 'String', ' ');
   		eventos=[];
         [prontuario,pro_filename]=le_prontuario(filename,eventos);
        	set(rb_beat,'Visible','on','Value',0);
   	   set(rb_time,'Visible','on','Value',0);
         set(rb_evnt,'Visible','off','Value',0);
         if abscissa=='beat',set(rb_beat,'Value',1);
   	   elseif abscissa=='time',set(rb_time,'Value',1);
         elseif abscissa=='evnt',abscissa='time';set(rb_time,'Value',1);end,
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
	      set(tx_labely1,'Visible','on');
      	set(te_eixox1,'Visible','on','String',num2str(eixox1));
   	   set(te_eixoy1,'Visible','on','String',num2str(eixoy1));
	      set(tx_labelx2,'Visible','on');
      	set(tx_labely2,'Visible','on');
   	   set(te_eixox2,'Visible','on','String',num2str(eixox2));
	      set(te_eixoy2,'Visible','on','String',num2str(eixoy2));
      	set(tx_labelx3,'Visible','on','String',unidade_eixox);
         set(tx_labelx4,'Visible','on','String',['max: ',num2str(limitex)]);
   	   set(tx_labelx5,'Visible','on','String',['min:  ',num2str(minimox)]);
	      set(cb_outliers,'Visible','on','Value',outliers);
      	set(tx_labely3,'Visible','on');
         set(pb_html,'Visible','on');
			set(pb_tabelarr,'Visible','on');
			set(pb_print,'Visible','on');
			set(tx_stats,'Visible','on');
			set(fr_stats,'Visible','on');   
            set(tx_mensagem,'Visible','off');
         rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      else,
      	set(tx_mensagens, 'String', 'This file does not contain R-R intervals! Each line must contain only 1 interval value!');
         eventos=[];pro_filename=[];prontuario=[];
			set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
         if rr_handle~=-1, delete(rr_handle);rr_handle=-1;end,
			if bp_handle~=-1, delete(bp_handle);bp_handle=-1;end,
      	set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
			set(fr_ectopics,'Visible','off');
			set(tx_eblabel,'Visible','off');
			set(rb_remove,'Visible','off');
			set(rb_interpola,'Visible','off');
			set(rb_naoremove,'Visible','off');
	      set(fr_controles,'Visible','off');
   	   set(tx_labelx1,'Visible','off');
	      set(tx_labely1,'Visible','off');
      	set(te_eixox1,'Visible','off');
   	   set(te_eixoy1,'Visible','off');
	      set(tx_labelx2,'Visible','off');
      	set(tx_labely2,'Visible','off');
   	   set(te_eixox2,'Visible','off');
	      set(te_eixoy2,'Visible','off');
      	set(tx_labelx3,'Visible','off');
         set(tx_labelx4,'Visible','off');
   	   set(tx_labelx5,'Visible','off');
	      set(tx_labely3,'Visible','off');
      	set(rb_beat,'Visible','off');
   	   set(rb_time,'Visible','off');
         set(rb_evnt,'Visible','off');
         set(pb_html,'Visible','off');
			set(pb_tabelarr,'Visible','off');
			set(pb_print,'Visible','off');
			set(tx_stats,'Visible','off');
         set(fr_stats,'Visible','off');   
	      set(cb_outliers,'Visible','off');
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
      set(tx_mensagens,'String',' ');

%rb_remove
case 5,
      set(rb_remove   ,'Value',1);
      set(rb_interpola,'Value',0);
      set(rb_naoremove,'Value',0);
      tempoRR=tempoRR_original(verdadeiros);
      intervaloRR=intervaloRR_original(verdadeiros);
      if abscissa=='beat',limitex=length(tempoRR);else limitex=ceil(max(tempoRR));end,
      set(tx_labelx4,'String',['max: ',num2str(limitex)]);
      if eixox2>limitex,eixox2=limitex;set(te_eixox2,'String',num2str(eixox2));end,
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
     	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
     	set(tx_stats,'String',tabela_stats);
   	rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);

%rb_interpola
case 6,
      set(rb_remove   ,'Value',0);
      set(rb_interpola,'Value',1);
      set(rb_naoremove,'Value',0);
      [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices);
      if abscissa=='beat',limitex=length(tempoRR);else limitex=ceil(max(tempoRR));end,
      set(tx_labelx4,'String',['max: ',num2str(limitex)]);
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
     	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
     	set(tx_stats,'String',tabela_stats);
   	rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
        
%rb_naoremove
case 7,
      set(rb_remove   ,'Value',0);
      set(rb_interpola,'Value',0);
      set(rb_naoremove,'Value',1);
      tempoRR=tempoRR_original;
      intervaloRR=intervaloRR_original;
      if abscissa=='beat',limitex=length(tempoRR);else limitex=ceil(max(tempoRR));end,
      set(tx_labelx4,'String',['max: ',num2str(limitex)]);
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
     	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
     	set(tx_stats,'String',tabela_stats);
   	rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
        
%te_eixox1
case 8,
      A=str2num(get(te_eixox1,'String'));
      if length(A)==1,
	   	if A < eixox2-1 & A >=minimox,
         	eixox1=floor(A); %tira as casas decimais
        end,
    end,
      rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      set(te_eixox1,'String',num2str(eixox1));
	   temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);

%te_eixoy1
case 9,

      A=str2num(get(te_eixoy1,'String'));
      if length(A)==1,
	   	if A < eixoy2 & A >=0,
         	eixoy1=floor(A); %tira as casas decimais
	      end,
   	end,
      rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      set(te_eixoy1,'String',num2str(eixoy1));
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);

%te_eixox2
case 10,

      A=str2num(get(te_eixox2,'String'));
      if length(A)==1,
	   	if A <= limitex & A >eixox1+1,
         	eixox2=ceil(A); %tira as casas decimais
	      end,
   	end,
      set(te_eixox2,'String',num2str(eixox2));
   	rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);

%te_eixoy2
case 11,

      A=str2num(get(te_eixoy2,'String'));
      if length(A)==1,
	   	if A <= 5000 & A >eixoy1,
         	eixoy2=ceil(A); %tira as casas decimais
	      end,
   	end,
      set(te_eixoy2,'String',num2str(eixoy2));
   	rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);

%rb_beat
case 12,
  	   set(rb_beat,'Value',1);
    	set(rb_time,'Value',0);
      set(rb_evnt,'Value',0);
   	if abscissa(1)~='b',
      	eixox1=1;eixox2=length(intervaloRR);
      	minimox=eixox1;limitex=eixox2;
         abscissa='beat';unidade_eixox='intervals';
         rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      	set(te_eixox1,'String',num2str(eixox1));
   	   set(te_eixox2,'String',num2str(eixox2));
      	set(tx_labelx3,'String',unidade_eixox);
         set(tx_labelx4,'String',['max: ',num2str(limitex)]);
         set(tx_labelx5,'String',['min:  ',num2str(minimox)]);
         temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
    end,

%rb_time
case 13,
  	   set(rb_beat,'Value',0);
    	set(rb_time,'Value',1);
      set(rb_evnt,'Value',0);
   	if abscissa(1)~='t',
      	eixox1=floor(min(tempoRR_original));eixox2=ceil(max(tempoRR));
      	minimox=eixox1;limitex=eixox2;
         abscissa='time';unidade_eixox='seconds';
         rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      	set(te_eixox1,'String',num2str(eixox1));
   	   set(te_eixox2,'String',num2str(eixox2));
      	set(tx_labelx3,'String',unidade_eixox);
         set(tx_labelx4,'String',['max: ',num2str(limitex)]);
         set(tx_labelx5,'String',['min:  ',num2str(minimox)]);
         temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
      end,

%rb_evnt
case 14,
 	   set(rb_beat,'Value',0);
     	set(rb_time,'Value',0);
      set(rb_evnt,'Value',1);
   	if abscissa(1)~='e',
      	eixox1=floor(min(tempoRR_original));eixox2=ceil(max(tempoRR));
      	minimox=eixox1;limitex=eixox2;
         abscissa='evnt';unidade_eixox='seconds';
         rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2);
      	set(te_eixox1,'String',num2str(eixox1));
   	   set(te_eixox2,'String',num2str(eixox2));
      	set(tx_labelx3,'String',unidade_eixox);
         set(tx_labelx4,'String',['max: ',num2str(limitex)]);
         set(tx_labelx5,'String',['min:  ',num2str(minimox)]);
         temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);
      end,

%cb_outliers
case 15,
      outliers=get(cb_outliers,'Value');
   	[tabela_stats,bp_handle]=temporalRR_tabela_stats(intervaloRR,bp_handle,outliers);
	   temporalRR_salva_cfg(filename,abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers);

%pb_html
case 16,
	temporalRR_gera_html(intervaloRR,tempoRR,prontuario,filename,eventos,abscissa,eixox1,eixox2,eixoy1,eixoy2,outliers);

%pb_tabelarr
case 17,
  temporalRR_tabelaRR(intervaloRR);      

%pb_print
case 18,
  	dos(['write ',salva_irr_txt(intervaloRR,[],filename)]);      
      
      
otherwise,
    
end;