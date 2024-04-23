function [intervaloRR, tempoRR,verdadeiros,ebs_indices]=le_IRR(irr_filename)
%usage:    [intervaloRR, tempoRR,verdadeiros,ebs_indices]=le_IRR(filename)

ponto=find(irr_filename=='.');
irr_filename=[irr_filename(1:ponto(length(ponto))-1),'.irr'];

%tenta abrir os arquivo .irr e .trr correspondentes (que contem os intervalos R-R e o eixo do tempoRR)
fid_irr=fopen(irr_filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .irr gravado, retorna -1
if fid_irr==-1,
   intervaloRR=-1;
   tempoRR=-1;
   verdadeiros=-1;
   ebs_indices=[];
else %caso contrario, le os vetores
	sizes=fread(fid_irr,4,'uint16');
   intervaloRR=fread(fid_irr,sizes(1),'uint16');
   tempoRR=fread(fid_irr,sizes(2),'float32');
   verdadeiros=fread(fid_irr,sizes(3),'uint16');
   ebs_indices=fread(fid_irr,sizes(4),'uint16');
   fclose(fid_irr);
end

%checa se os dois vetores tem o mesmo numero de amostras
if length(intervaloRR) ~= length(tempoRR),
   intervaloRR=-1;
   tempoRR=-1;
   verdadeiros=-1;
   ebs_indices=[];
end