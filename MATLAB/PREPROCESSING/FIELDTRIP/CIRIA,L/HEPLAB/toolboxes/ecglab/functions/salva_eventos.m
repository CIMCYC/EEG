function salva_eventos(eventos,filename)
%usage:

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.evn'];

fid=fopen(filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
fwrite(fid,eventos,'float32');
fclose(fid);