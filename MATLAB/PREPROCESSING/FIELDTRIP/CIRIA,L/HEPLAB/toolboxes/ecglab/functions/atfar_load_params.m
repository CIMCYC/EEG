function params=atfar_load_params(tk);

%ponto=find(filename=='.');
%filename=[filename(1:ponto(length(ponto))-1),'.arc'];

%tenta abrir o arquivo .trc correspondente (que contem os eventos)
%fid=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .trc gravado, cria as variaveis com os valores iniciais
%if fid==-1,
   
 %  params.fsRR = 4;
  % params.winlen = 32;
   %params.fsAR = 0.5;
   %params.vlf = 0.04;
   %params.lf = 0.15;
   %params.hf = 0.5;
   %params.maxfreq = 0.5;
%   params.ordemAR = 16;
 %  params.Npts = 800;
  % params.wintype = 5;
   
%else %caso contrario, le as variaveis o arquivo 
   
	%le variaveis do arquivo
%   params.fsRR = fread(fid,1,'float32');
 %  params.winlen = fread(fid,1,'float32');
  % params.fsAR = fread(fid,1,'float32');
   %params.vlf = fread(fid,1,'float32');
%   params.lf = fread(fid,1,'float32');
 %  params.hf = fread(fid,1,'float32');
  % params.maxfreq = fread(fid,1,'float32');
   %params.ordemAR = fread(fid,1,'uint16');
%   params.Npts = fread(fid,1,'uint16');
 %  params.wintype = fread(fid,1,'uint16');
   
	%fecha o arquivo
   %fclose(fid);
%end

load atfar_params.mat;
params.janela_inicio = tk(1);
params.janela_fim = tk(end);

