function salva_IRR(intervaloRR,tempoRR,verdadeiros,ebs_indices,irr_filename)
%usage: salva_IRR(intervaloRR,tempoRR,verdadeiros,ebs_indices,irr_filename);

ponto=find(irr_filename=='.');
irr_filename=[irr_filename(1:ponto(length(ponto))-1),'.irr'];

fid_irr=fopen(irr_filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

fwrite(fid_irr,length(intervaloRR),'uint16');
fwrite(fid_irr,length(tempoRR),'uint16');
fwrite(fid_irr,length(verdadeiros),'uint16');
fwrite(fid_irr,length(ebs_indices),'uint16');
fwrite(fid_irr,intervaloRR,'uint16');
fwrite(fid_irr,tempoRR,'float32');
fwrite(fid_irr,verdadeiros,'uint16');
fwrite(fid_irr,ebs_indices,'uint16');
fclose(fid_irr);

%salva os intervalos em ASCII
salva_irr_txt(intervaloRR,ebs_indices,irr_filename);