function salva_ondar(ecg_ondar,onr_filename,segundos_sinal,ebs)
%usage: salva_ondar(ecg_ondar,filename);

global samplerate_ecg

ponto=find(onr_filename=='.');
onr_filename=[onr_filename(1:ponto(length(ponto))-1),'.onr'];

fid=fopen(onr_filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
fwrite(fid,ecg_ondar,'int32');
fclose(fid);

%calcula os intervalos R-R
[intervaloRR, tempoRR]=calcula_IRR(ecg_ondar,segundos_sinal);

%localiza os intervalos marcados
ebs_indices=[];
t=round(1000*(0:1/samplerate_ecg:segundos_sinal-1/samplerate_ecg)');
tRR=round(1000*tempoRR);
if isempty(ebs)~=1,
	for a=1:length(ebs),
		A=ebs(a);
	   ebs_indices=[ebs_indices;find(tRR==t(A))];
	end,
end,

%determina os intervalos normais
verdadeiros=(1:length(intervaloRR))';
for i=1:length(ebs_indices),
   verdadeiros=verdadeiros(find(verdadeiros~=ebs_indices(i)));
end,

%salva os intervalos em arquivo .irr
salva_IRR(intervaloRR,tempoRR,verdadeiros,ebs_indices,onr_filename);