function atfar_callbacks(id)

global te_file filename RR tk normais ebs_indices tx_mensagens
global params csastruct handle1 handle2 handle3 eventos prontuario pro_filename fr_prontuario tx_prontlabel pb_edita
global pb_atualiza pb_indices fr_janelas tx_janela1 pu_janela1 tx_janela2 pu_janela2 tx_janela3 pu_janela3
global tx_vlf tx_lf tx_hf tx_hz tx_maxF tx_maxFhz fr_params te_vlf te_lf te_hf te_maxF te_N te_fsAR tx_PSD 
global tx_N tx_fsAR tx_winlen te_winlen tx_wintype pu_wintype tx_fsRR te_fsRR fr_deslocador tx_janela_label
global pb_deslocadir pb_deslocaesq pb_eixoy te_janela_inicio te_janela_fim tx_janela_min tx_janela_max
global fr_eixoy pb_eixoyok te_eixoymin1 te_eixoymax1 te_eixoymin2 te_eixoymax2 te_eixoymin3 te_eixoymax3   
global tx_eixoy1 tx_eixoy2 tx_eixoy3 tx_mensagem pb_eixoyauto1 pb_eixoyauto2 pb_eixoyauto3 cb_rmvect
global rb_AR rb_FFT tx_ordemAR te_ordemAR main_window

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
      [RR,tk,normais,ebs_indices]=le_IRR(filename);
      if RR(1)~=-1,
         atfar_PbAbrirIf;
         else,
	      set(tx_mensagens, 'String','This file does not contain RR intervals, or it does not exist!');
         atfar_PbAbrirElse;
         end,

    %pb_abrir_rr
    case 2,
      filename=get(te_file,'String');
      [RR,tk,normais,ebs_indices]=readRRmat(filename);
      if RR(1)~=-1,
         atfar_PbAbrirIf;
      else,
         set(tx_mensagens,'String','This file does not contain RR intervals, or it does not exist!');
         atfar_PbAbrirElse;
     end,
    
     %pb_edita
 case 3,
   	dos(['write ',pro_filename]);
    set(tx_mensagens,'String','When finished editing patient info on Wordpad, save the file and click on UPDATE.');

    %pb_edita
 case 4,
    prontuario=le_prontuario(pro_filename,eventos);
    mostrar_prontuario(prontuario);
    set(tx_mensagens,'String',' ');
      
  %pb_indices
case 5,
  atfar_indices(main_window,csastruct);
    
  %pu_janela1
case 6,
    params.janela1=get(pu_janela1,'Value');
    handle1=atfar_plotar(1,handle1,csastruct,params);
   A=get(handle1,'YLim');
   set(te_eixoymin1,'String',num2str(A(1)));
   set(te_eixoymax1,'String',num2str(A(2)));
   A=get(handle2,'YLim');
   set(te_eixoymin2,'String',num2str(A(1)));
   set(te_eixoymax2,'String',num2str(A(2)));
   A=get(handle3,'YLim');
   set(te_eixoymin3,'String',num2str(A(1)));
   set(te_eixoymax3,'String',num2str(A(2)));
   atfar_salva_params(params);

  %pu_janela2
case 7,
    params.janela2=get(pu_janela2,'Value');
    handle2=atfar_plotar(2,handle2,csastruct,params);
   A=get(handle1,'YLim');
   set(te_eixoymin1,'String',num2str(A(1)));
   set(te_eixoymax1,'String',num2str(A(2)));
   A=get(handle2,'YLim');
   set(te_eixoymin2,'String',num2str(A(1)));
   set(te_eixoymax2,'String',num2str(A(2)));
   A=get(handle3,'YLim');
   set(te_eixoymin3,'String',num2str(A(1)));
   set(te_eixoymax3,'String',num2str(A(2)));
   atfar_salva_params(params);

     %pu_janela3
case 8,
    params.janela3=get(pu_janela3,'Value');
    handle3=atfar_plotar(3,handle3,csastruct,params);
   A=get(handle1,'YLim');
   set(te_eixoymin1,'String',num2str(A(1)));
   set(te_eixoymax1,'String',num2str(A(2)));
   A=get(handle2,'YLim');
   set(te_eixoymin2,'String',num2str(A(1)));
   set(te_eixoymax2,'String',num2str(A(2)));
   A=get(handle3,'YLim');
   set(te_eixoymin3,'String',num2str(A(1)));
   set(te_eixoymax3,'String',num2str(A(2)));
   atfar_salva_params(params);

   %te_maxF
case 9,
      A=str2num(get(te_maxF,'String'));
      if length(A)==1,
       	if A <= params.fsRR/2 & A > 0,
            params.maxfreq=round(A*1000)/1000; %deixa só 3 casas decimais
            params.eixoymax(3)=params.maxfreq;
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if(params.janela1==3), set(te_eixoymax1, 'String',num2str(params.maxfreq)); end;
            if(params.janela2==3), set(te_eixoymax2, 'String',num2str(params.maxfreq)); end;
            if(params.janela3==3), set(te_eixoymax3, 'String',num2str(params.maxfreq)); end;
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,
      end,
  end,
      set(te_maxF, 'String',num2str(params.maxfreq));

      %te_vlf
  case 10,
      A=str2num(get(te_vlf,'String'));
      if length(A)==1,
	   	if A < params.lf & A >=0,
            params.vlf=round(A*1000)/1000; %deixa só 3 casas decimais
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_vlf, 'String',num2str(params.vlf));      

%te_lf
case 11,
      A=str2num(get(te_lf,'String'));
      if length(A)==1,
	   	if A < params.hf & A >params.vlf,
            params.lf=round(A*1000)/1000; %deixa só 3 casas decimais
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_lf, 'String',num2str(params.lf));      

    %te_hf
case 12,
      A=str2num(get(te_hf,'String'));
      if length(A)==1,
	   	if A <= params.maxfreq & A >params.lf,
            params.hf=round(A*1000)/1000; %deixa só 3 casas decimais
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_hf, 'String',num2str(params.hf));

      %te_N
  case 13,
      A=str2num(get(te_N,'String'));
      if length(A)==1,
	   	if round(A) <= 2^15 & round(A) >=8,
         	params.Npts=round(A); %converte para potencia de 2
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_N, 'String',num2str(params.Npts));      

%te_fsAR
case 14,
      A=str2num(get(te_fsAR,'String'));
      if length(A)==1,
	   	if A <= params.fsRR & A > 0,
         	params.fsAR=A;
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_fsAR, 'String',num2str(params.fsAR));      

%te_winlen
case 15,
      A=str2num(get(te_winlen,'String'));
      if length(A)==1,
	   	if A <= 3/4*tk(end) & A > 0,
         	params.winlen=A; %converte para potencia de 2
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_winlen, 'String',num2str(params.winlen));      

%pu_wintype
case 16,
      params.wintype=get(pu_wintype,'Value');
      atfar_salva_params(params);
      csastruct=atfar_calcula_csa(tk,RR,normais,params);
      handle1=atfar_plotar(1,handle1,csastruct,params);
      handle2=atfar_plotar(2,handle2,csastruct,params);
      handle3=atfar_plotar(3,handle3,csastruct,params);
      if ~isempty(find(get(0,'children')==main_window+1)),
        atfar_indices(main_window,csastruct);
    end,            

%te_ordemAR
case 17,
      A=str2num(get(te_ordemAR,'String'));
      if length(A)==1,
	   	if round(A) <= 200 & round(A) >=2,
         	params.ordemAR=round(A);
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_ordemAR, 'String',num2str(params.ordemAR));      

%te_fsRR
case 18,
      A=str2num(get(te_fsRR,'String'));
      if length(A)==1,
	   	if A <= 32 & A >= 0.5,
            params.fsRR=A;
            if(A/2<params.maxfreq),params.maxfreq=A/2;set(te_maxF,'String',num2str(A/2));end;
            if(A<params.fsAR),params.fsAR=A;set(te_fsAR,'String',num2str(A));end;
            atfar_salva_params(params);
            csastruct=atfar_calcula_csa(tk,RR,normais,params);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
            if ~isempty(find(get(0,'children')==main_window+1)),
              atfar_indices(main_window,csastruct);
          end,            
      end,
  end,
      set(te_fsRR, 'String',num2str(params.fsRR));      

      %te_janela_inicio
  case 19,
      A=str2num(get(te_janela_inicio,'String'));
      if length(A)==1,
         if A(1) <= params.janela_fim & A(1)>= 0,
   			params.janela_inicio=A(1);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);
        end,
    end,
      set(te_janela_inicio, 'String',num2str(params.janela_inicio));

        %te_janela_fim
  case 20,
      A=str2num(get(te_janela_fim,'String'));
      if (length(A)==1) & (A(1) >= params.janela_inicio+csastruct.T(3)-csastruct.T(1)) & (A(1)<=2*csastruct.tk(end)),
            params.janela_fim = A(1);
            handle1=atfar_plotar(1,handle1,csastruct,params);
            handle2=atfar_plotar(2,handle2,csastruct,params);
            handle3=atfar_plotar(3,handle3,csastruct,params);      
        end;
      set(te_janela_fim,'String',num2str(params.janela_fim));

  %pb_deslocaesq
case 21,
         A=(params.janela_fim-params.janela_inicio);
         if params.janela_inicio - A  >= 0,
            params.janela_inicio=params.janela_inicio-A;
            params.janela_fim=params.janela_fim-A;
        else,
            params.janela_inicio=0;
         	params.janela_fim=A;         
        end, 
         handle1=atfar_plotar(1,handle1,csastruct,params);
         handle2=atfar_plotar(2,handle2,csastruct,params);
         handle3=atfar_plotar(3,handle3,csastruct,params);      
         set(te_janela_inicio, 'String',num2str(params.janela_inicio));
         set(te_janela_fim, 'String',num2str(params.janela_fim));

%pb_deslocadir
case 22,
         A=(params.janela_fim-params.janela_inicio);      
         if params.janela_inicio+A <= csastruct.tk(end)-A,
	   		params.janela_inicio=params.janela_inicio+A;
            params.janela_fim=params.janela_fim+A;
        else,
         	params.janela_inicio=csastruct.tk(end)-A;
         	params.janela_fim=csastruct.tk(end);
        end,
         if params.janela_inicio<0,params.janela_inicio=0;params.janela_fim=A;end;
         handle1=atfar_plotar(1,handle1,csastruct,params);
         handle2=atfar_plotar(2,handle2,csastruct,params);
         handle3=atfar_plotar(3,handle3,csastruct,params);      
         set(te_janela_inicio, 'String',num2str(params.janela_inicio));
         set(te_janela_fim, 'String',num2str(params.janela_fim));

     %pb_eixoy
 case 23,
   set(fr_eixoy,'Visible','on');
   set(pb_eixoyok,'Visible','on');
   A=get(handle1,'YLim');
   set(te_eixoymin1,'Visible','on','String',num2str(A(1)));
   set(te_eixoymax1,'Visible','on','String',num2str(A(2)));
   A=get(handle2,'YLim');   
   set(te_eixoymin2,'Visible','on','String',num2str(A(1)));
   set(te_eixoymax2,'Visible','on','String',num2str(A(2)));
   A=get(handle3,'YLim');   
   set(te_eixoymin3,'Visible','on','String',num2str(A(1)));
   set(te_eixoymax3,'Visible','on','String',num2str(A(2)));   
   set(tx_eixoy1,'Visible','on');
   set(tx_eixoy2,'Visible','on');
   set(tx_eixoy3,'Visible','on');   
   set(pb_eixoyauto1,'Visible','on');
   set(pb_eixoyauto2,'Visible','on');
   set(pb_eixoyauto3,'Visible','on');

%pb_eixoyok
case 24,
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
   set(pb_eixoyauto1,'Visible','off');
   set(pb_eixoyauto2,'Visible','off');
   set(pb_eixoyauto3,'Visible','off');

%te_eixoymin1
case 25,
      A=str2num(get(te_eixoymin1,'String'));
      B=get(handle1,'YLim');
      if (length(A)==1) & (A(1) >= 0) & (A(1) < B(2)),
        set(handle1,'YLim',[A(1) B(2)]);
        set(te_eixoymin1, 'String',num2str(A(1)));
        params.eixoymin(params.janela1)=A(1);
        atfar_salva_params(params);  
    else,
        set(te_eixoymin1, 'String',num2str(B(1)));
    end;        
    
%te_eixoymax1
case 26,    
      A=str2num(get(te_eixoymax1,'String'));
      B=get(handle1,'YLim');
      if (length(A)==1) & (A(1) > B(1)),
        set(handle1,'YLim',[B(1) A(1)]);
        set(te_eixoymax1, 'String',num2str(A(1)));
        params.eixoymax(params.janela1)=A(1);
        atfar_salva_params(params);  
    else,
        set(te_eixoymax1, 'String',num2str(B(2)));
    end; 
    
%te_eixoymin2
case 27,
      A=str2num(get(te_eixoymin2,'String'));
      B=get(handle2,'YLim');
      if (length(A)==1) & (A(1) >= 0) & (A(1) < B(2)),
        set(handle2,'YLim',[A(1) B(2)]);
        set(te_eixoymin2, 'String',num2str(A(1)));
        params.eixoymin(params.janela2)=A(1);
        atfar_salva_params(params);   
    else,
        set(te_eixoymin2, 'String',num2str(B(1)));
    end;
        
%te_eixoymax2
case 28,
      A=str2num(get(te_eixoymax2,'String'));
      B=get(handle2,'YLim');
      if (length(A)==1) & (A(1) > B(1)),
        set(handle2,'YLim',[B(1) A(1)]);
        set(te_eixoymax2, 'String',num2str(A(1)));
        params.eixoymax(params.janela2)=A(1);
        atfar_salva_params(params);   
    else,
        set(te_eixoymax2, 'String',num2str(B(2)));
    end;
    
%te_eixoymin3
case 29,
      A=str2num(get(te_eixoymin3,'String'));
      B=get(handle3,'YLim');
      if (length(A)==1) & (A(1) >= 0) & (A(1) < B(2)),
        set(handle3,'YLim',[A(1) B(2)]);
        set(te_eixoymin3, 'String',num2str(A(1)));
        params.eixoymin(params.janela3)=A(1);
        atfar_salva_params(params);   
    else,
        set(te_eixoymin3, 'String',num2str(B(1)));
    end;
        
%te_eixoymax3
case 30,
      A=str2num(get(te_eixoymax3,'String'));
      B=get(handle3,'YLim');
      if (length(A)==1) & (A(1) > B(1)),
        set(handle3,'YLim',[B(1) A(1)]);
        set(te_eixoymax3, 'String',num2str(A(1)));
        params.eixoymax(params.janela3)=A(1);
        atfar_salva_params(params);        
    else,
        set(te_eixoymax3, 'String',num2str(B(2)));
    end;
 
%pb_eixoyauto1
case 31,
      params.eixoyauto=1;
      handle1=atfar_plotar(1,handle1,csastruct,params);
      params.eixoyauto=0;
      A=get(handle1,'YLim');
      params.eixoymin(params.janela1)=A(1);        
      params.eixoymax(params.janela1)=A(2);
      atfar_salva_params(params);        
      set(te_eixoymin1,'String',num2str(A(1)));
      set(te_eixoymax1,'String',num2str(A(2)));
       
%pb_eixoyauto2
case 32,
      params.eixoyauto=1;
      handle2=atfar_plotar(2,handle2,csastruct,params);
      params.eixoyauto=0;
      A=get(handle2,'YLim');
      params.eixoymin(params.janela2)=A(1);        
      params.eixoymax(params.janela2)=A(2);
      atfar_salva_params(params);        
      set(te_eixoymin2,'String',num2str(A(1)));
      set(te_eixoymax2,'String',num2str(A(2)));
 
%pb_eixoyauto3
case 33,
      params.eixoyauto=1;
      handle3=atfar_plotar(3,handle3,csastruct,params);
      params.eixoyauto=0;
      A=get(handle3,'YLim');
      params.eixoymin(params.janela3)=A(1);        
      params.eixoymax(params.janela3)=A(2);
      atfar_salva_params(params);        
      set(te_eixoymin3,'String',num2str(A(1)));
      set(te_eixoymax3,'String',num2str(A(2)));
       
%cb_rmvect
case 34,
      if(get(cb_rmvect,'Value')==1),
        params.rmvect = 0;
    else,   
         params.rmvect = 1;
     end;   
     atfar_salva_params(params);
       csastruct=atfar_calcula_csa(tk,RR,normais,params);
       handle1=atfar_plotar(1,handle1,csastruct,params);
       handle2=atfar_plotar(2,handle2,csastruct,params);
       handle3=atfar_plotar(3,handle3,csastruct,params);
       if ~isempty(find(get(0,'children')==main_window+1)),
         atfar_indices(main_window,csastruct);
     end,

%rb_AR
case 35,
       params.alg='ar';
       set(rb_AR ,'Value',1);
       set(rb_FFT,'Value',0);
       set(tx_ordemAR,'Visible','on');         
       set(te_ordemAR,'Visible','on');         
       atfar_salva_params(params);
       csastruct=atfar_calcula_csa(tk,RR,normais,params);
       handle1=atfar_plotar(1,handle1,csastruct,params);
       handle2=atfar_plotar(2,handle2,csastruct,params);
       handle3=atfar_plotar(3,handle3,csastruct,params);
       if ~isempty(find(get(0,'children')==main_window+1)),
         atfar_indices(main_window,csastruct);
     end,

%rb_FFT
case 36,
       params.alg='ft';
       set(rb_AR ,'Value',0);
       set(rb_FFT,'Value',1);
       set(tx_ordemAR,'Visible','off');         
       set(te_ordemAR,'Visible','off');
       atfar_salva_params(params);
       csastruct=atfar_calcula_csa(tk,RR,normais,params);
       handle1=atfar_plotar(1,handle1,csastruct,params);
       handle2=atfar_plotar(2,handle2,csastruct,params);
       handle3=atfar_plotar(3,handle3,csastruct,params);
       if ~isempty(find(get(0,'children')==main_window+1)),
         atfar_indices(main_window,csastruct);
     end,   

    otherwise,
end