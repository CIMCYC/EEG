function espectralrr_callbacks(id)

global psd_handle PSD F line1 line2 line3 aavlf aalf aahf aatotal avlf alf ahf rlfhf anlf anhf
global fill filename intervaloRR tempoRR verdadeiros ebs_indices intervaloRR_original tempoRR_original
global eventos prontuario pro_filename vlf2 lf2 hf2 ordem_ar escala maxF minF minP maxP algoritmo metodo
global fs janela N vlf1 lf1 hf1
global te_vlf2 tx_vlf1 te_lf2 tx_lf1 te_hf2 tx_hf1 te_minF te_maxF te_minP te_maxP tx_minF
global te_ordemAR te_N te_fs rb_normal rb_monolog rb_loglog fr_escala tx_escala
global fr_bandas tx_vlf tx_lf tx_hf tx_vlf1 tx_lf1 tx_hf1 tx_vlfa tx_lfa tx_hfa
global te_hf2 te_lf2 te_vlf2 tx_hzvlf tx_hzlf tx_hzhf pb_commouse fr_areas1
global tx_areas1 tx_areas2 tx_areas3 fr_psd tx_maxF rb_fhr rb_lhp rb_lhr tx_fs
global tx_maxP te_minP tx_minP tx_N te_N fr_algoritmo tx_algoritmo rb_mar rb_dft
global rb_ambos fr_janela tx_janela rb_ret rb_ham rb_han rb_bla rb_bar cb_fill tx_mensagem
global te_file tx_mensagens fr_prontuario tx_prontlabel pb_edita pb_atualiza pb_versinal
global pb_html tx_ordemAR fr_metodo tx_metodo rb_fhpis rb_fhpc rb_fhp rb_fhris rb_fhrc


switch id,

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
   		set(tx_mensagens, 'String', ' ');
   		eventos=le_eventos(filename);         
     	[prontuario,pro_filename]=le_prontuario(filename,eventos);
			set(fr_prontuario,'Visible','on');
			set(tx_prontlabel,'Visible','on');
			set(pb_edita,'Visible','on');
         set(pb_atualiza,'Visible','on');
      	set(pb_versinal,'Visible','on');
      	set(pb_html,'Visible','on');
         [vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill]=espectralRR_le_cfg(filename);
         vlf1=0;lf1=vlf2;hf1=lf2;
			if escala(1)=='n',set(rb_normal,'Value',1);set(rb_monolog,'Value',0);set(rb_loglog,'Value',0);
            elseif escala(1)=='m',set(rb_normal,'Value',0);set(rb_monolog,'Value',1);set(rb_loglog,'Value',0);
            else set(rb_normal,'Value',0);set(rb_monolog,'Value',0);set(rb_loglog,'Value',1);end;
			if algoritmo=='mar', set(rb_mar,'Value',1);set(rb_dft,'Value',0);set(rb_ambos,'Value',0);
            elseif algoritmo=='fft', set(rb_mar,'Value',0);set(rb_dft,'Value',1);set(rb_ambos,'Value',0);
            else set(rb_mar,'Value',0);set(rb_dft,'Value',0);set(rb_ambos,'Value',1); end;         
	      set(te_vlf2, 'String',num2str(vlf2));      
	      set(tx_vlf1,'String',num2str(vlf1));
	      set(te_lf2, 'String',num2str(lf2));      
	      set(tx_lf1,'String',num2str(lf1));
	      set(te_hf2, 'String',num2str(hf2));      
	      set(tx_hf1,'String',num2str(hf1));
	      set(te_minF, 'String',num2str(minF));      
         set(te_maxF, 'String',num2str(maxF));      
	      set(te_minP, 'String',num2str(minP));      
	      set(te_maxP, 'String',num2str(maxP));      
	      set(te_ordemAR, 'String',num2str(ordem_ar));      
         set(te_N, 'String',num2str(N));
         set(te_fs, 'String',num2str(fs));         
			set(rb_normal,'Visible','on');
			set(rb_monolog,'Visible','on');
			set(rb_loglog,'Visible','on');
         set(fr_escala,'Visible','on');
			set(tx_escala,'Visible','on');
			set(fr_bandas,'Visible','on');
			set(tx_vlf,'Visible','on');
			set(tx_lf,'Visible','on');
			set(tx_hf,'Visible','on');
         set(tx_vlf1,'Visible','on');
         set(tx_lf1,'Visible','on');
         set(tx_hf1,'Visible','on');
			set(tx_vlfa,'Visible','on');
			set(tx_lfa,'Visible','on');
			set(tx_hfa,'Visible','on');
         set(te_hf2,'Visible','on');
			set(te_lf2,'Visible','on');
			set(te_vlf2,'Visible','on');
         set(tx_hzvlf,'Visible','on');
         set(tx_hzlf,'Visible','on');
         set(tx_hzhf,'Visible','on');
			set(pb_commouse,'Visible','on');
			set(fr_areas1,'Visible','on');
         set(tx_areas1,'Visible','on');
         set(tx_areas2,'Visible','on');
         set(tx_areas3,'Visible','on');
			set(fr_psd,'Visible','on');
			set(te_maxF,'Visible','on');
         set(tx_maxF,'Visible','on');
			set(te_minF,'Visible','on');
         set(tx_minF,'Visible','on');
			set(te_maxP,'Visible','on');
         set(tx_maxP,'Visible','on');
			set(te_minP,'Visible','on');
			set(tx_minP,'Visible','on');
         set(tx_N,'Visible','on');
         set(te_N,'Visible','on');
			set(fr_algoritmo,'Visible','on');
			set(tx_algoritmo,'Visible','on');
			set(rb_mar,'Visible','on');
			set(rb_dft,'Visible','on');
         set(rb_ambos,'Visible','on');
	      set(fr_janela,'Visible','on');
   	   set(tx_janela,'Visible','on');
			set(rb_ret,'Visible','on','Value',0);
   	   set(rb_ham,'Visible','on','Value',0);
			set(rb_han,'Visible','on','Value',0);
   	   set(rb_bla,'Visible','on','Value',0);
         set(rb_bar,'Visible','on','Value',0);
         set(cb_fill,'Visible','on','Value',fill);
         switch algoritmo,
         	case {'mar','amb'},
					set(tx_ordemAR,'Visible','on');
               set(te_ordemAR,'Visible','on');
            case 'fft',
					set(tx_ordemAR,'Visible','off');
               set(te_ordemAR,'Visible','off');
			end,
         switch janela,
         	case 'ret', set(rb_ret,'Value',1);
         	case 'ham', set(rb_ham,'Value',1);
         	case 'han', set(rb_han,'Value',1);
         	case 'bla', set(rb_bla,'Value',1);
         	case 'bar', set(rb_bar,'Value',1);
         end,
         set(fr_metodo,'Visible','on');
   	   set(tx_metodo,'Visible','on');
			set(rb_fhpis,'Visible','on','Value',0);
   	   set(rb_fhpc,'Visible','on','Value',0);
         set(rb_fhp,'Visible','on','Value',0);
			set(rb_fhris,'Visible','on','Value',0);
   	   set(rb_fhrc,'Visible','on','Value',0);
         set(rb_fhr,'Visible','on','Value',0);         
         set(rb_lhp,'Visible','on','Value',0);
			set(rb_lhr,'Visible','on','Value',0);         
         switch metodo,
         	case 'fhpis',
					set(rb_fhpis,'Value',1);
               set(tx_fs,'Visible','on');
               set(te_fs,'Visible','on');
				case 'fhpc_',
				   set(rb_fhpc,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
            case 'fhp__',
               set(rb_fhp,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
         	case 'fhris',
					set(rb_fhris,'Value',1);
               set(tx_fs,'Visible','on');
               set(te_fs,'Visible','on');
				case 'fhrc_',
				   set(rb_fhrc,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
            case 'fhr__',
               set(rb_fhr,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');               
            case 'lhp__',
               set(rb_lhp,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
					set(fr_algoritmo,'Visible','off');
					set(tx_algoritmo,'Visible','off');
					set(rb_mar,'Visible','off');
					set(rb_dft,'Visible','off');
               set(rb_ambos,'Visible','off');
					set(te_maxP,'Visible','off');
		         set(tx_maxP,'Visible','off');
					set(te_minP,'Visible','off');
					set(tx_minP,'Visible','off');
            case 'lhr__',
               set(rb_lhr,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');               
					set(fr_algoritmo,'Visible','off');
					set(tx_algoritmo,'Visible','off');
					set(rb_mar,'Visible','off');
					set(rb_dft,'Visible','off');
               set(rb_ambos,'Visible','off');               
					set(te_maxP,'Visible','off');
		         set(tx_maxP,'Visible','off');
					set(te_minP,'Visible','off');
					set(tx_minP,'Visible','off');               
         end,
      	[psd_handle,N,PSD,F,line1,line2,line3,maxF,maxP]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR, verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
        [aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
	      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
         set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
         set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
	      set(te_maxP, 'String',num2str(maxP));      
             set(tx_mensagem,'Visible','off');
         espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

      else,
	      set(tx_mensagens, 'String', 'This file does not contain R-R intervals!');
         eventos=[];pro_filename=[];prontuario=[];
			if psd_handle~=-1, delete(psd_handle);psd_handle=-1;end,
      	set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
			set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
      	set(pb_versinal,'Visible','off');
      	set(pb_html,'Visible','off');
			set(rb_normal,'Visible','off');
			set(rb_monolog,'Visible','off');
			set(rb_loglog,'Visible','off');
			set(tx_escala,'Visible','off');         
      	set(fr_escala,'Visible','off');
      	set(fr_bandas,'Visible','off');
			set(tx_vlf,'Visible','off');
			set(tx_lf,'Visible','off');
			set(tx_hf,'Visible','off');
         set(tx_vlf1,'Visible','off');
         set(tx_lf1,'Visible','off');
         set(tx_hf1,'Visible','off');
			set(tx_vlfa,'Visible','off');
			set(tx_lfa,'Visible','off');
			set(tx_hfa,'Visible','off');
         set(te_hf2,'Visible','off');
			set(te_lf2,'Visible','off');
			set(te_vlf2,'Visible','off');
         set(tx_hzvlf,'Visible','off');
         set(tx_hzlf,'Visible','off');
         set(tx_hzhf,'Visible','off');
			set(pb_commouse,'Visible','off');
			set(fr_areas1,'Visible','off');
         set(tx_areas1,'Visible','off');
         set(tx_areas2,'Visible','off');
         set(tx_areas3,'Visible','off');
			set(fr_psd,'Visible','off');
			set(te_maxF,'Visible','off');
         set(tx_maxF,'Visible','off');
			set(te_minF,'Visible','off');
         set(tx_minF,'Visible','off');
			set(te_maxP,'Visible','off');
         set(tx_maxP,'Visible','off');
			set(te_minP,'Visible','off');
			set(tx_minP,'Visible','off');
         set(tx_N,'Visible','off');
         set(te_N,'Visible','off');
			set(tx_fs,'Visible','off');
			set(te_fs,'Visible','off');
			set(tx_ordemAR,'Visible','off');
         set(te_ordemAR,'Visible','off');          
			set(fr_algoritmo,'Visible','off');
			set(tx_algoritmo,'Visible','off');
			set(rb_mar,'Visible','off');
			set(rb_dft,'Visible','off');
         set(rb_ambos,'Visible','off');
	      set(fr_janela,'Visible','off');
   	   set(tx_janela,'Visible','off');
			set(rb_ret,'Visible','off');
   	   set(rb_ham,'Visible','off');
			set(rb_han,'Visible','off');
   	   set(rb_bla,'Visible','off');
			set(rb_bar,'Visible','off');
         set(fr_metodo,'Visible','off');
   	   set(tx_metodo,'Visible','off');
			set(rb_fhpis,'Visible','off');
   	   set(rb_fhpc,'Visible','off');
         set(rb_fhp,'Visible','off');
			set(rb_fhris,'Visible','off');
   	   set(rb_fhrc,'Visible','off');
         set(rb_fhr,'Visible','off');         
         set(rb_lhp,'Visible','off');
         set(rb_lhr,'Visible','off');         
         set(cb_fill,'Visible','off');
            set(tx_mensagem,'Visible','on');
      end,

%pb_abrir_ascii
case 2,
      filename=get(te_file,'String');
      [intervaloRR,tempoRR,verdadeiros,ebs_indices]=le_IRR_ascii(filename);
      intervaloRR_original=intervaloRR;tempoRR_original=tempoRR;
		if intervaloRR(1)~=-1,
   		set(tx_mensagens, 'String', ' ');
   		eventos=le_eventos(filename);         
     	[prontuario,pro_filename]=le_prontuario(filename,eventos);
			set(fr_prontuario,'Visible','on');
			set(tx_prontlabel,'Visible','on');
			set(pb_edita,'Visible','on');
         set(pb_atualiza,'Visible','on');
      	set(pb_versinal,'Visible','on');
      	set(pb_html,'Visible','on');
         [vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill]=espectralRR_le_cfg(filename);
         vlf1=0;lf1=vlf2;hf1=lf2;
			if escala(1)=='n',set(rb_normal,'Value',1);set(rb_monolog,'Value',0);set(rb_loglog,'Value',0);
			elseif escala(1)=='m',set(rb_normal,'Value',0);set(rb_monolog,'Value',1);set(rb_loglog,'Value',0);
         else set(rb_normal,'Value',0);set(rb_monolog,'Value',0);set(rb_loglog,'Value',1);end;
			if algoritmo=='mar', set(rb_mar,'Value',1);set(rb_dft,'Value',0);set(rb_ambos,'Value',0);
			elseif algoritmo=='fft', set(rb_mar,'Value',0);set(rb_dft,'Value',1);set(rb_ambos,'Value',0);
			else set(rb_mar,'Value',0);set(rb_dft,'Value',0);set(rb_ambos,'Value',1); end;         
	      set(te_vlf2, 'String',num2str(vlf2));      
	      set(tx_vlf1,'String',num2str(vlf1));
	      set(te_lf2, 'String',num2str(lf2));      
	      set(tx_lf1,'String',num2str(lf1));
	      set(te_hf2, 'String',num2str(hf2));      
	      set(tx_hf1,'String',num2str(hf1));
	      set(te_minF, 'String',num2str(minF));      
         set(te_maxF, 'String',num2str(maxF));      
	      set(te_minP, 'String',num2str(minP));      
	      set(te_maxP, 'String',num2str(maxP));      
	      set(te_ordemAR, 'String',num2str(ordem_ar));      
         set(te_N, 'String',num2str(N));
         set(te_fs, 'String',num2str(fs));         
			set(rb_normal,'Visible','on');
			set(rb_monolog,'Visible','on');
			set(rb_loglog,'Visible','on');
         set(fr_escala,'Visible','on');
			set(tx_escala,'Visible','on');
			set(fr_bandas,'Visible','on');
			set(tx_vlf,'Visible','on');
			set(tx_lf,'Visible','on');
			set(tx_hf,'Visible','on');
         set(tx_vlf1,'Visible','on');
         set(tx_lf1,'Visible','on');
         set(tx_hf1,'Visible','on');
			set(tx_vlfa,'Visible','on');
			set(tx_lfa,'Visible','on');
			set(tx_hfa,'Visible','on');
         set(te_hf2,'Visible','on');
			set(te_lf2,'Visible','on');
			set(te_vlf2,'Visible','on');
         set(tx_hzvlf,'Visible','on');
         set(tx_hzlf,'Visible','on');
         set(tx_hzhf,'Visible','on');
			set(pb_commouse,'Visible','on');
			set(fr_areas1,'Visible','on');
         set(tx_areas1,'Visible','on');
         set(tx_areas2,'Visible','on');
         set(tx_areas3,'Visible','on');
			set(fr_psd,'Visible','on');
			set(te_maxF,'Visible','on');
         set(tx_maxF,'Visible','on');
			set(te_minF,'Visible','on');
         set(tx_minF,'Visible','on');
			set(te_maxP,'Visible','on');
         set(tx_maxP,'Visible','on');
			set(te_minP,'Visible','on');
			set(tx_minP,'Visible','on');
         set(tx_N,'Visible','on');
         set(te_N,'Visible','on');
			set(fr_algoritmo,'Visible','on');
			set(tx_algoritmo,'Visible','on');
			set(rb_mar,'Visible','on');
			set(rb_dft,'Visible','on');
         set(rb_ambos,'Visible','on');
	      set(fr_janela,'Visible','on');
   	   set(tx_janela,'Visible','on');
			set(rb_ret,'Visible','on','Value',0);
   	   set(rb_ham,'Visible','on','Value',0);
			set(rb_han,'Visible','on','Value',0);
   	   set(rb_bla,'Visible','on','Value',0);
         set(rb_bar,'Visible','on','Value',0);
         switch algoritmo,
         	case {'mar','amb'},
					set(tx_ordemAR,'Visible','on');
               set(te_ordemAR,'Visible','on');
            case 'fft',
					set(tx_ordemAR,'Visible','off');
               set(te_ordemAR,'Visible','off');
			end,
         switch janela,
         	case 'ret', set(rb_ret,'Value',1);
         	case 'ham', set(rb_ham,'Value',1);
         	case 'han', set(rb_han,'Value',1);
         	case 'bla', set(rb_bla,'Value',1);
         	case 'bar', set(rb_bar,'Value',1);
         end,
         set(fr_metodo,'Visible','on');
   	   set(tx_metodo,'Visible','on');
         set(cb_fill,'Visible','on','Value',fill);
			set(rb_fhpis,'Visible','on','Value',0);
   	   set(rb_fhpc,'Visible','on','Value',0);
         set(rb_fhp,'Visible','on','Value',0);
			set(rb_fhris,'Visible','on','Value',0);
   	   set(rb_fhrc,'Visible','on','Value',0);
         set(rb_fhr,'Visible','on','Value',0);         
         set(rb_lhp,'Visible','on','Value',0);
			set(rb_lhr,'Visible','on','Value',0);         
         switch metodo,
         	case 'fhpis',
					set(rb_fhpis,'Value',1);
               set(tx_fs,'Visible','on');
               set(te_fs,'Visible','on');
				case 'fhpc_',
				   set(rb_fhpc,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
            case 'fhp__',
               set(rb_fhp,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
         	case 'fhris',
					set(rb_fhris,'Value',1);
               set(tx_fs,'Visible','on');
               set(te_fs,'Visible','on');
				case 'fhrc_',
				   set(rb_fhrc,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
            case 'fhr__',
               set(rb_fhr,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');               
            case 'lhp__',
               set(rb_lhp,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');
					set(fr_algoritmo,'Visible','off');
					set(tx_algoritmo,'Visible','off');
					set(rb_mar,'Visible','off');
					set(rb_dft,'Visible','off');
               set(rb_ambos,'Visible','off');
					set(te_maxP,'Visible','off');
		         set(tx_maxP,'Visible','off');
					set(te_minP,'Visible','off');
					set(tx_minP,'Visible','off');               
            case 'lhr__',
               set(rb_lhr,'Value',1);
               set(tx_fs,'Visible','off');
               set(te_fs,'Visible','off');               
					set(fr_algoritmo,'Visible','off');
					set(tx_algoritmo,'Visible','off');
					set(rb_mar,'Visible','off');
					set(rb_dft,'Visible','off');
               set(rb_ambos,'Visible','off');               
					set(te_maxP,'Visible','off');
		         set(tx_maxP,'Visible','off');
					set(te_minP,'Visible','off');
					set(tx_minP,'Visible','off');               
         end,
      	[psd_handle,N,PSD,F,line1,line2,line3,maxF,maxP]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
         [aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
	      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
         set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
         set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
	      set(te_maxP, 'String',num2str(maxP));      
             set(tx_mensagem,'Visible','off');
         espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      else,
      	set(tx_mensagens, 'String', 'This file does not contain R-R intervals! Each line must contain only 1 interval value!');
         eventos=[];pro_filename=[];prontuario=[];
			if psd_handle~=-1, delete(psd_handle);psd_handle=-1;end,
      	set(fr_prontuario,'Visible','off');
			set(tx_prontlabel,'Visible','off');
			set(pb_edita,'Visible','off');
         set(pb_atualiza,'Visible','off');
      	set(pb_versinal,'Visible','off');
      	set(pb_html,'Visible','off');
			set(rb_normal,'Visible','off');
			set(rb_monolog,'Visible','off');
			set(rb_loglog,'Visible','off');
         set(fr_escala,'Visible','off');
			set(tx_escala,'Visible','off');         
      	set(fr_bandas,'Visible','off');
			set(tx_vlf,'Visible','off');
			set(tx_lf,'Visible','off');
			set(tx_hf,'Visible','off');
         set(tx_vlf1,'Visible','off');
         set(tx_lf1,'Visible','off');
         set(tx_hf1,'Visible','off');
			set(tx_vlfa,'Visible','off');
			set(tx_lfa,'Visible','off');
			set(tx_hfa,'Visible','off');
         set(te_hf2,'Visible','off');
			set(te_lf2,'Visible','off');
			set(te_vlf2,'Visible','off');
         set(tx_hzvlf,'Visible','off');
         set(tx_hzlf,'Visible','off');
         set(tx_hzhf,'Visible','off');
			set(pb_commouse,'Visible','off');
			set(fr_areas1,'Visible','off');
         set(tx_areas1,'Visible','off');
         set(tx_areas2,'Visible','off');
         set(tx_areas3,'Visible','off');
			set(fr_psd,'Visible','off');
			set(te_maxF,'Visible','off');
         set(tx_maxF,'Visible','off');
			set(te_minF,'Visible','off');
         set(tx_minF,'Visible','off');
			set(te_maxP,'Visible','off');
         set(tx_maxP,'Visible','off');
			set(te_minP,'Visible','off');
			set(tx_minP,'Visible','off');
         set(tx_N,'Visible','off');
         set(te_N,'Visible','off');
			set(tx_fs,'Visible','off');
			set(te_fs,'Visible','off');
			set(tx_ordemAR,'Visible','off');
         set(te_ordemAR,'Visible','off');          
			set(fr_algoritmo,'Visible','off');
			set(tx_algoritmo,'Visible','off');
			set(rb_mar,'Visible','off');
			set(rb_dft,'Visible','off');
         set(rb_ambos,'Visible','off');
	      set(fr_janela,'Visible','off');
   	   set(tx_janela,'Visible','off');
			set(rb_ret,'Visible','off');
   	   set(rb_ham,'Visible','off');
			set(rb_han,'Visible','off');
   	   set(rb_bla,'Visible','off');
			set(rb_bar,'Visible','off');
         set(fr_metodo,'Visible','off');
   	   set(tx_metodo,'Visible','off');
			set(rb_fhpis,'Visible','off');
   	   set(rb_fhpc,'Visible','off');
         set(rb_fhp,'Visible','off');
			set(rb_fhris,'Visible','off');
   	   set(rb_fhrc,'Visible','off');
         set(rb_fhr,'Visible','off');         
         set(rb_lhp,'Visible','off');
         set(rb_lhr,'Visible','off');         
         set(cb_fill,'Visible','off');
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

%te_vlf2
case 5,
      A=str2num(get(te_vlf2,'String'));
      if length(A)==1,
	   	if A < lf2 & A >=0,
         	vlf2=round(A*1000)/1000; %deixa só 3 casas decimais
	      end,
   	end,
      set(te_vlf2, 'String',num2str(vlf2));      
      set(tx_lf1,'String',num2str(vlf2));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
	[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%te_lf2
case 6,
      A=str2num(get(te_lf2,'String'));
      if length(A)==1,
	   	if A < hf2 & A >vlf2,
         	lf2=round(A*1000)/1000; %deixa só 3 casas decimais
	      end,
   	end,
      set(te_lf2, 'String',num2str(lf2));      
      set(tx_hf1,'String',num2str(lf2));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
		set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%te_hf2
case 7,
      A=str2num(get(te_hf2,'String'));
      if length(A)==1,
	   	if A <= maxF & A >lf2,
         	hf2=round(A*1000)/1000; %deixa só 3 casas decimais
	      end,
   	end,
      set(te_hf2, 'String',num2str(hf2));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%cb_fill
case 8,
      fill=get(cb_fill,'Value');
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);

%pb_commouse
case 9,
      [vlf2,lf2,hf2,line1,line2,line3]=espectralRR_commouse(maxF,PSD,F,line1,line2,line3,vlf2,lf2,hf2,length(intervaloRR_original),length(ebs_indices),metodo);
      vlf1=0;lf1=vlf2;hf1=lf2;
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);

%te_minF
case 10,
      A=str2num(get(te_minF,'String'));
      if length(A)==1,
	   	if A < maxF & A >=0,
         	minF=round(A*1000)/1000; %deixa só 3 casas decimais
	      end,
   	end,
      set(te_minF, 'String',num2str(minF));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%te_maxF
case 11,
      A=str2num(get(te_maxF,'String'));
      if length(A)==1,
      	switch metodo,
      		case {'fhpis','fhris','lhp__','lhr__'},
   	      	if A <= fs/2 & A > minF,
	         		maxF=round(A*1000)/1000; %deixa só 3 casas decimais
	   	   	end,
            case {'fhp__','fhpc_','fhr__','fhrc_'},
   	      	if A <= round(1000*max(F))/1000 & A > minF,
	         		maxF=round(A*1000)/1000; %deixa só 3 casas decimais
               elseif A > minF,
						maxF=round(1000*max(F))/1000;
               end,
			end,
   	end,
      set(te_maxF, 'String',num2str(maxF));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%te_minP
case 12,
      A=str2num(get(te_minP,'String'));
      if length(A)==1,
	   	if A < maxP & A >=0,
         	minP=A;
	      end,
   	end,
      set(te_minP, 'String',num2str(minP));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
      
%te_maxP
case 13,
      A=str2num(get(te_maxP,'String'));
      if length(A)==1,
      	if A > minP,
        		maxP=A;
  	   	end,
   	end,
      set(te_maxP, 'String',num2str(maxP));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%te_N
case 14,
      A=str2num(get(te_N,'String'));
      if length(A)==1,
	   	if round(A) <= 2^18 & round(A) >=32,
         	N=2.^ceil(log(A)/log(2)); %converte para potencia de 2
      	end,
   	end,
      set(te_N, 'String',num2str(N));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%te_ordemAR
case 15,
      A=str2num(get(te_ordemAR,'String'));
      if length(A)==1,
	   	if round(A) <= 150 & round(A) >0,
         	ordem_ar=round(A); %remove as casas decimais
      	end,
   	end,
      set(te_ordemAR, 'String',num2str(ordem_ar));      
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%te_fs
case 16,
    fs_ant=fs;
   	A=str2num(get(te_fs,'String'));
      if length(A)==1,
	   	if A <= 10 & A >=0.8,
         	fs=round(A*1000)/1000; %deixa só 3 casas decimais         
      	end,
   	end,
      set(te_fs, 'String',num2str(fs));
      if fs/2 < maxF,
      	maxF=round(fs/2*1000)/1000;
	      set(te_maxF, 'String',num2str(maxF));
      end;
      ordem_ar=round((fs/fs_ant)*ordem_ar);
      set(te_ordemAR,'String',num2str(ordem_ar));
      N=2.^round(log((fs/fs_ant)*N)/log(2));
            set(te_N,'String',num2str(N));
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%rb_normal
case 17,
      set(rb_normal,'Value',1);
      set(rb_monolog,'Value',0);
      set(rb_loglog,'Value',0);
      escala='normal';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%rb_monolog
case 18,
      set(rb_normal,'Value',0);
      set(rb_monolog,'Value',1);
      set(rb_loglog,'Value',0);
      escala='monolog';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%rb_loglog
case 19,
      set(rb_normal,'Value',0);
      set(rb_monolog,'Value',0);
      set(rb_loglog,'Value',1);
      escala='loglog';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);

%rb_mar
case 20,
      set(rb_mar,'Value',1);
      set(rb_dft,'Value',0);
      set(rb_ambos,'Value',0);
      algoritmo='mar';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_ordemAR,'Visible','on');
      set(te_ordemAR,'Visible','on');

%rb_dft
case 21,
      set(rb_mar,'Value',0);
      set(rb_dft,'Value',1);
      set(rb_ambos,'Value',0);
   	algoritmo='fft';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_ordemAR,'Visible','off');
      set(te_ordemAR,'Visible','off');

%rb_ambos
case 22,
      set(rb_mar,'Value',0);
      set(rb_dft,'Value',0);
      set(rb_ambos,'Value',1);
      algoritmo='amb';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_ordemAR,'Visible','on');
      set(te_ordemAR,'Visible','on');

%rb_ret
case 23,
      set(rb_ret,'Value',1);
      set(rb_ham,'Value',0);
      set(rb_han,'Value',0);
      set(rb_bla,'Value',0);
      set(rb_bar,'Value',0);
      janela='ret';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%rb_bar
case 24,
      set(rb_ret,'Value',0);
      set(rb_ham,'Value',0);
      set(rb_han,'Value',0);
      set(rb_bla,'Value',0);
      set(rb_bar,'Value',1);
      janela='bar';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
    
%rb_ham
case 25,
      set(rb_ret,'Value',0);
      set(rb_ham,'Value',1);
      set(rb_han,'Value',0);
      set(rb_bla,'Value',0);
      set(rb_bar,'Value',0);
      janela='ham';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%rb_han
case 26,
      set(rb_ret,'Value',0);
      set(rb_ham,'Value',0);
      set(rb_han,'Value',1);
      set(rb_bla,'Value',0);
      set(rb_bar,'Value',0);
      janela='han';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%rb_bla
case 27,
      set(rb_ret,'Value',0);
      set(rb_ham,'Value',0);
      set(rb_han,'Value',0);
      set(rb_bla,'Value',1);
      set(rb_bar,'Value',0);
      janela='bla';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));

%rb_fhpis
case 28,
      set(rb_fhpis,'Value',1);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR e o numero de pontos
			case {'fhpc_','fhp__','fhrc_','fhr__','lhp__','lhr__'},
				ordem_ar=round((mean(intervaloRR)/1000)*ordem_ar*fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((mean(intervaloRR)/1000)*N*fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhrc_','fhr__','fhris','lhr__'},
				maxP=maxP*100;minP=minP*100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));            
		end,
   	metodo='fhpis';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','on');
      set(te_fs,'Visible','on');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_fhpc
case 29,
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',1);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhrc_','fhr__','fhris','lhr__'},
				maxP=maxP*100;minP=minP*100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));
		end,
   	metodo='fhpc_';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_fhp
case 30,
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',1);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhrc_','fhr__','fhris','lhr__'},
				maxP=maxP*100;minP=minP*100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));
		end,
   	metodo='fhp__';
   	[psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_fhris
case 31,
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',1);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR e o numero de pontos
			case {'fhpc_','fhp__','fhrc_','fhr__','lhp__','lhr__'},
				ordem_ar=round((mean(intervaloRR)/1000)*ordem_ar*fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((mean(intervaloRR)/1000)*N*fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhpc_','fhp__','fhpis','lhp__'},
				maxP=maxP/100;minP=minP/100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));
		end,
   	metodo='fhris';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','on');
      set(te_fs,'Visible','on');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_fhrc
case 32,
     set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',1);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhpc_','fhp__','fhpis','lhp__'},
				maxP=maxP/100;minP=minP/100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));
		end,
   	metodo='fhrc_';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_fhr
case 33,
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',1);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhpc_','fhp__','fhpis','lhp__'},
				maxP=maxP/100;minP=minP/100;
		end,
   	metodo='fhr__';
   	[psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','on');
		set(tx_algoritmo,'Visible','on');
		set(rb_mar,'Visible','on');
		set(rb_dft,'Visible','on');
      set(rb_ambos,'Visible','on');      
		set(te_maxP,'Visible','on');
      set(tx_maxP,'Visible','on');
		set(te_minP,'Visible','on');
		set(tx_minP,'Visible','on');      

%rb_lhp
case 34,
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',1);
      set(rb_lhr,'Value',0);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhrc_','fhr__','fhris','lhr__'},
				maxP=maxP*100;minP=minP*100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));            
		end,
   	metodo='lhp__';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','off');
		set(tx_algoritmo,'Visible','off');
		set(rb_mar,'Visible','off');
		set(rb_dft,'Visible','off');
      set(rb_ambos,'Visible','off');      
		set(te_maxP,'Visible','off');
      set(tx_maxP,'Visible','off');
		set(te_minP,'Visible','off');
		set(tx_minP,'Visible','off');      
    
%rb_lhr
case 35,    
      set(rb_fhpis,'Value',0);
   	set(rb_fhpc,'Value',0);
      set(rb_fhp,'Value',0);
      set(rb_fhris,'Value',0);
   	set(rb_fhrc,'Value',0);
      set(rb_fhr,'Value',0);
      set(rb_lhp,'Value',0);
      set(rb_lhr,'Value',1);      
		switch metodo, %ajusta a ordem do modelo AR
			case {'fhpis','fhris'},
				ordem_ar=round((1000/mean(intervaloRR))*ordem_ar/fs);
            set(te_ordemAR,'String',num2str(ordem_ar));
            N=2.^round(log((1000/mean(intervaloRR))*N/fs)/log(2));
            set(te_N,'String',num2str(N));
		end,
		switch metodo, %ajusta a escala do espectro
			case {'fhpc_','fhp__','fhpis','lhp__'},
				maxP=maxP/100;minP=minP/100;
            set(te_minP, 'String',num2str(minP));
		      set(te_maxP, 'String',num2str(maxP));
		end,
   	metodo='lhr__';
      [psd_handle,N,PSD,F,line1,line2,line3,maxF]=espectralRR_espectrograma(psd_handle,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);
		set(te_maxF,'String',num2str(maxF));
      espectralRR_salva_cfg(filename,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,minP,maxP,algoritmo,metodo,fs,janela,N,fill);
		[aavlf,aalf,aahf,aatotal,avlf,alf,ahf,rlfhf,anlf,anhf]=espectralRR_calcula_areas(PSD,F,vlf2,lf2,hf2);
      set(tx_areas1,'String',espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo));
      set(tx_areas2,'String',espectralRR_sareas2(avlf,alf,ahf,rlfhf,length(intervaloRR_original),length(ebs_indices)));
      set(tx_areas3,'String',espectralRR_sareas3(anlf,anhf));
		set(tx_fs,'Visible','off');
      set(te_fs,'Visible','off');
		set(fr_algoritmo,'Visible','off');
		set(tx_algoritmo,'Visible','off');
		set(rb_mar,'Visible','off');
		set(rb_dft,'Visible','off');
      set(rb_ambos,'Visible','off');      
		set(te_maxP,'Visible','off');
      set(tx_maxP,'Visible','off');
		set(te_minP,'Visible','off');
		set(tx_minP,'Visible','off');      

%pb_html
case 36,
	espectralRR_gera_html(filename,prontuario,tempoRR,intervaloRR,verdadeiros,ebs_indices,vlf2,lf2,hf2,ordem_ar,escala,maxF,minF,maxP,minP,algoritmo,metodo,fs,janela,N,fill);      

%pb_versinal
case 37,
      temporalRR_intervalograma2(tempoRR(verdadeiros),intervaloRR(verdadeiros),eventos,'evnt',min(tempoRR),max(tempoRR),min(intervaloRR(verdadeiros))-25,max(intervaloRR(verdadeiros))+25);      
      
otherwise,
    
    
end;