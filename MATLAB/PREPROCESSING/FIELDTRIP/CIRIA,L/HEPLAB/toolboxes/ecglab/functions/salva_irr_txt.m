function trr_filename=salva_irr_txt(intervaloRR,ebs,trr_filename)

ponto=find(trr_filename=='.');
trr_filename=[trr_filename(1:ponto(length(ponto))-1),'.txt'];

arquivo=[];
for i=1:length(intervaloRR),
   
   if isempty(ebs),
      arquivo=[arquivo,num2str(intervaloRR(i)),'\n'];
   elseif isempty(find(ebs==i)),
      arquivo=[arquivo,num2str(intervaloRR(i)),'\n'];
   else
      arquivo=[arquivo,num2str(intervaloRR(i)),' batimento ectopico!\n'];
   end
end

fid = fopen(trr_filename,'w');
fprintf(fid,arquivo,'char');
fclose(fid);