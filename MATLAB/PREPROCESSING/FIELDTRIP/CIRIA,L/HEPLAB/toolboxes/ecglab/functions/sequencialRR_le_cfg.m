function eixo=sequencialRR_le_cfg(filename,intervaloRR)

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.src'];

%tenta abrir o arquivo .trc correspondente (que contem os eventos)
fid=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .trc gravado, retorna padrao
if fid==-1,
   
   diferencas=intervaloRR(2:length(intervaloRR))-intervaloRR(1:length(intervaloRR)-1);
   eixo=ceil(max(diferencas)+.2*max(diferencas));
   
else %caso contrario, le o vetor da marcacao R-R   
   
   eixo=fread(fid,1,'int16');
   fclose(fid);
   
end