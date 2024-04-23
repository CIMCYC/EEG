function [A,E,N]=le_sinal(filename)
%LESINAL le do disco, retira os eventos e converte para -9:9
%		usage: [A,E,N]=le_sinal(filename)

%			N=numero de amostras lidas
%			A=sinal de N amostras, sem eventos e convertido para a escala -9V : 9V
%			E=vetor com os indices de onde há evento
%			filename=nome do arquivo a ser aberto

global samplerate_ecg

[fid,fileerrormsg]=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
if fid==-1,
   A=fileerrormsg;
   E=[];
   N=-1;
else
   [A, N]=fread(fid,'uint16');
   fclose(fid);
   E=(find((bitand(A,32768))~=0)-1)/samplerate_ecg;
   A=bitand(A,4095);
   A = A - mean(A);
   A = A/max(abs(A));
end % este end diz respeito ao procedimento tomado quando os arquivos rsp e ecg sao lidos com sucesso