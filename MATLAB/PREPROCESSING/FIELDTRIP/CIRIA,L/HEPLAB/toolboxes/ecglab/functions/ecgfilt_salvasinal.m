function ecgfilt_salvasinal(filename,A,E)
%usage: ecgfilt_salvasinal(filename,A,E)
%			A=sinal convertido para a escala [-1000 1000]
%			E=vetor com os insantes no tempo onde há eventos
%			filename=nome do arquivo a ser salvo

global samplerate_ecg

fs = samplerate_ecg;
ecg = A;
ponto=find(filename=='.');filename=[filename(1:ponto(length(ponto))-1),'_filtered.mat']; %adapta a extensao
save(filename,'ecg','fs');

salva_eventos(E,filename);

% [fid,fileerrormsg]=fopen(filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
% if fid~=-1,
%    
%    %converte para 12 bits
%    A=A-min(A); A=A/max(A);
%    A=round(A*(2^12-1));
%    
%    %marca os eventos no bit mais signifcativo
%    indices_E=round(E*samplerate_ecg+1);
%    A(indices_E)=A(indices_E)+32768;
%    
%    %grava o sinal
%    fwrite(fid,A,'uint16');
%    fclose(fid);   
%    
% end % este end diz respeito ao procedimento tomado quando os arquivos rsp e ecg sao lidos com sucesso