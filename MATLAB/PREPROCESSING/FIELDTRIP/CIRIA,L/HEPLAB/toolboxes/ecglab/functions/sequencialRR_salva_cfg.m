function sequencialRR_salva_cfg(filename,eixo)

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.src'];

fid=fopen(filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
fwrite(fid,eixo,'int16');
fclose(fid);
