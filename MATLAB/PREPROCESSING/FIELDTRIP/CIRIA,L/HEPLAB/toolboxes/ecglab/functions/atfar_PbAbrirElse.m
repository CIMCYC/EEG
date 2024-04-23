function atfar_PbAbrirElse

global te_file filename RR tk normais ebs_indices tx_mensagens
global params csastruct handle1 handle2 handle3 eventos prontuario pro_filename fr_prontuario tx_prontlabel pb_edita
global pb_atualiza pb_indices fr_janelas tx_janela1 pu_janela1 tx_janela2 pu_janela2 tx_janela3 pu_janela3
global tx_vlf tx_lf tx_hf tx_hz tx_maxF tx_maxFhz fr_params te_vlf te_lf te_hf te_maxF te_N te_fsAR tx_PSD 
global tx_N tx_fsAR tx_winlen te_winlen tx_wintype pu_wintype tx_fsRR te_fsRR fr_deslocador tx_janela_label
global pb_deslocadir pb_deslocaesq pb_eixoy te_janela_inicio te_janela_fim tx_janela_min tx_janela_max
global fr_eixoy pb_eixoyok te_eixoymin1 te_eixoymax1 te_eixoymin2 te_eixoymax2 te_eixoymin3 te_eixoymax3   
global tx_eixoy1 tx_eixoy2 tx_eixoy3 tx_mensagem pb_eixoyauto1 pb_eixoyauto2 pb_eixoyauto3 cb_rmvect
global rb_AR rb_FFT tx_ordemAR te_ordemAR main_window

         eventos=[];pro_filename=[];prontuario=[];
         if handle1~=-1, delete(handle1);handle1=-1;end,
			if handle2~=-1, delete(handle2);handle2=-1;end,
			if handle3~=-1, delete(handle3);handle3=-1;end,
      	set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
			set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
         set(pb_indices,'Visible','off');
         set(fr_janelas,'Visible','off');         
         set(tx_janela1,'Visible','off');         
         set(pu_janela1,'Visible','off');         
         set(tx_janela2,'Visible','off');         
         set(pu_janela2,'Visible','off');         
         set(tx_janela3,'Visible','off');         
         set(pu_janela3,'Visible','off');         
         set(tx_vlf,'Visible','off');               
         set(tx_lf,'Visible','off');         
         set(tx_hf,'Visible','off');         
         set(tx_hz,'Visible','off');         
         set(tx_maxF,'Visible','off');         
         set(tx_maxFhz,'Visible','off');         
         set(fr_params,'Visible','off');         
         set(te_vlf,'Visible','off');         
         set(te_lf,'Visible','off');         
         set(te_hf,'Visible','off');         
         set(te_maxF,'Visible','off');       
         set(te_N,'Visible','off');         
         set(te_fsAR,'Visible','off');         
         set(tx_PSD,'Visible','off');         
         set(tx_N,'Visible','off');         
         set(tx_fsAR,'Visible','off');         
         set(tx_winlen,'Visible','off');         
         set(te_winlen,'Visible','off');         
         set(tx_wintype,'Visible','off');         
         set(pu_wintype,'Visible','off');         
         set(tx_fsRR,'Visible','off');         
         set(te_fsRR,'Visible','off');         
         set(tx_ordemAR,'Visible','off');         
         set(te_ordemAR,'Visible','off');         
         set(fr_deslocador,'Visible','off');
         set(tx_janela_label,'Visible','off');
         set(pb_deslocadir,'Visible','off');
         set(pb_deslocaesq,'Visible','off');
         set(te_janela_inicio,'Visible','off');
         set(te_janela_fim,'Visible','off');
         set(tx_janela_max,'Visible','off');
         set(tx_janela_min,'Visible','off');
         set(pb_eixoy,'Visible','off');
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
   set(tx_mensagem,'Visible','on');
   set(pb_eixoyauto1,'Visible','off');
   set(pb_eixoyauto2,'Visible','off');
   set(pb_eixoyauto3,'Visible','off');   
   set(rb_AR,'Visible','off');
   set(rb_FFT,'Visible','off');
   set(cb_rmvect,'Visible','off');
   if ~isempty(find(get(0,'children')==main_window+1)),
     close(main_window+1);
 end;

   
  
