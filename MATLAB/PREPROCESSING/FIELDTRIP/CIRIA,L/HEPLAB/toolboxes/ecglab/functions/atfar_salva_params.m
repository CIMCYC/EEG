function atfar_salva_params(params);

%ponto=find(filename=='.');
%filename=[filename(1:ponto(length(ponto))-1),'.arc'];

%tenta abrir o arquivo .trc correspondente (que contem os eventos)
%fid=fopen(filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%escreve as variaveis no arquivo
%fwrite(fid,[params.fsRR, params.winlen, params.fsAR, params.vlf, params.lf, params.hf, params.maxfreq],'float32');
%fwrite(fid,[params.ordemAR, params.Npts, params.wintype],'uint16');

%fecha o arquivo
%fclose(fid);

save atfar_params.mat params;