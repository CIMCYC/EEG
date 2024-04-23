function atfar_PbAbrirIf

global te_file filename RR tk normais ebs_indices tx_mensagens
global params csastruct handle1 handle2 handle3 eventos prontuario pro_filename fr_prontuario tx_prontlabel pb_edita
global pb_atualiza pb_indices fr_janelas tx_janela1 pu_janela1 tx_janela2 pu_janela2 tx_janela3 pu_janela3
global tx_vlf tx_lf tx_hf tx_hz tx_maxF tx_maxFhz fr_params te_vlf te_lf te_hf te_maxF te_N te_fsAR tx_PSD 
global tx_N tx_fsAR tx_winlen te_winlen tx_wintype pu_wintype tx_fsRR te_fsRR fr_deslocador tx_janela_label
global pb_deslocadir pb_deslocaesq pb_eixoy te_janela_inicio te_janela_fim tx_janela_min tx_janela_max
global fr_eixoy pb_eixoyok te_eixoymin1 te_eixoymax1 te_eixoymin2 te_eixoymax2 te_eixoymin3 te_eixoymax3   
global tx_eixoy1 tx_eixoy2 tx_eixoy3 tx_mensagem pb_eixoyauto1 pb_eixoyauto2 pb_eixoyauto3 cb_rmvect
global rb_AR rb_FFT tx_ordemAR te_ordemAR main_window


        params=atfar_load_params(tk);
         atfar_salva_params(params);
         csastruct=atfar_calcula_csa(tk,RR,normais,params);
         handle1=atfar_plotar(1,handle1,csastruct,params);
         handle2=atfar_plotar(2,handle2,csastruct,params);
         handle3=atfar_plotar(3,handle3,csastruct,params);
   		set(tx_mensagens, 'String', ' ');
   		eventos=le_eventos(filename);         
      	[prontuario,pro_filename]=le_prontuario(filename,eventos);
			set(fr_prontuario,'Visible','on');
			set(tx_prontlabel,'Visible','on');
			set(pb_edita,'Visible','on');
         set(pb_atualiza,'Visible','on');
         set(pb_indices,'Visible','on');
         set(fr_janelas,'Visible','on');
         set(tx_janela1,'Visible','on');
         set(pu_janela1,'Visible','on','Value',params.janela1);         
         set(tx_janela2,'Visible','on');
         set(pu_janela2,'Visible','on','Value',params.janela2);
         set(tx_janela3,'Visible','on');
         set(pu_janela3,'Visible','on','Value',params.janela3);
         set(tx_vlf,'Visible','on');               
         set(tx_lf,'Visible','on');         
         set(tx_hf,'Visible','on');         
         set(tx_hz,'Visible','on');         
         set(tx_maxF,'Visible','on');         
         set(tx_maxFhz,'Visible','on');         
         set(fr_params,'Visible','on');         
         set(te_vlf,'Visible','on','String',num2str(params.vlf));         
         set(te_lf,'Visible','on','String',num2str(params.lf));         
         set(te_hf,'Visible','on','String',num2str(params.hf));         
         set(te_maxF,'Visible','on','String',num2str(params.maxfreq));         
         set(te_N,'Visible','on','String',num2str(params.Npts));         
         set(te_fsAR,'Visible','on','String',num2str(params.fsAR));         
         set(tx_PSD,'Visible','on');         
         set(tx_N,'Visible','on');         
         set(tx_fsAR,'Visible','on');         
         set(tx_winlen,'Visible','on');         
         set(te_winlen,'Visible','on','String',num2str(params.winlen));         
         set(tx_wintype,'Visible','on');         
         set(pu_wintype,'Visible','on','Value',params.wintype);         
         set(tx_fsRR,'Visible','on');         
         set(te_fsRR,'Visible','on','String',num2str(params.fsRR));         
         set(fr_deslocador,'Visible','on');
         set(tx_janela_label,'Visible','on');
         set(pb_deslocadir,'Visible','on');
         set(pb_deslocaesq,'Visible','on');
         set(pb_eixoy,'Visible','on');
         set(te_janela_inicio,'Visible','on','String',num2str(params.janela_inicio));
         set(te_janela_fim,'Visible','on','String',num2str(params.janela_fim));
         set(tx_janela_min,'Visible','on','String',['Min=',num2str(params.janela_inicio), 's']);
         set(tx_janela_max,'Visible','on','String',['Max=',num2str(params.janela_fim), 's']);   
   set(fr_eixoy,'Visible','off');
   set(pb_eixoyok,'Visible','off');
   set(te_eixoymin1,'Visible','off');
   set(te_eixoymax1,'Visible','off');   
   set(te_eixoymin2,'Visible','off');
   set(te_eixoymax2,'Visible','off');
   set(te_eixoymin3,'Visible','off');
   set(te_eixoymax3,'Visible','off');   
   set(tx_eixoy1,'Visible','off');
   set(tx_eixoy2,'Visible','off');
   set(tx_eixoy3,'Visible','off');
   set(tx_mensagem,'Visible','off');
   set(pb_eixoyauto1,'Visible','off');
   set(pb_eixoyauto2,'Visible','off');
   set(pb_eixoyauto3,'Visible','off');
   set(cb_rmvect,'Visible','on','Value',~params.rmvect);
   if (params.alg=='ar'),
     set(rb_AR,'Visible','on','Value',1);
     set(rb_FFT,'Visible','on','Value',0);
     set(tx_ordemAR,'Visible','on');         
     set(te_ordemAR,'Visible','on','String',num2str(params.ordemAR));
 else,
     set(rb_AR,'Visible','on','Value',0);
     set(rb_FFT,'Visible','on','Value',1);
     set(tx_ordemAR,'Visible','off');         
     set(te_ordemAR,'Visible','off','String',num2str(params.ordemAR));
 end;
   if ~isempty(find(get(0,'children')==main_window+1)),
     atfar_indices(main_window,csastruct);
 end;
