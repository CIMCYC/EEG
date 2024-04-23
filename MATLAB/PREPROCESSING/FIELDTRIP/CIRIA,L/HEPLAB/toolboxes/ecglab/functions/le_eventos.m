function eventos=le_eventos(filename)
%usage: 

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.evn'];

%tenta abrir o arquivo .evn correspondente (que contem os eventos)
fid=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .onr gravado, retorna vazio
if fid==-1,
   
   eventos=[]; 
   
else %caso contrario, le o vetor da marcacao R-R   
   
   eventos=fread(fid,'float32');
   fclose(fid);
   
   if isempty(eventos),
      eventos=[];
   end;
   
end