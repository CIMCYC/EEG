function ecg_ondar=le_ondar(filename)
%usage: ecg_ondar=le_ondar(filename);

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.onr'];

%tenta abrir o arquivo .onr correspondente (que contem a marcacao R-R)
fid_ondar=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .onr gravado, retorna vazio
if fid_ondar==-1,
   
   ecg_ondar=[]; 
   
else %caso contrario, le o vetor da marcacao R-R   
   
   ecg_ondar=fread(fid_ondar,'int32');
   fclose(fid_ondar);
   
   if isempty(ecg_ondar),
      ecg_ondar=[];
   end;
   
end