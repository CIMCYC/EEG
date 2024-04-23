function [prontuario,filename]=le_prontuario(filename,eventos)
%usage:

ponto=find(filename=='.');
filename=[filename(1:ponto(length(ponto))-1),'.pro'];

%tenta abrir o arquivo .pro correspondente (que contem o prontuario)
fid=fopen(filename,'r'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1

%se nao tiver arquivo .pro gravado, retorna -1
if fid==-1,
   
   
   minutos=floor(eventos/60);
	segundos=floor(eventos-minutos*60);
	milesimos=floor(1000*(eventos-(minutos*60+segundos)));

	eventos_texto=[];
	for i=1:length(eventos),
   	if minutos(i)<10,
      	eventos_texto=[eventos_texto,'>0:0',num2str(minutos(i))];
  		else
      	eventos_texto=[eventos_texto,'>0:',num2str(minutos(i))];
	   end 
   	if segundos(i)<10,
	      eventos_texto=[eventos_texto,':0',num2str(segundos(i)),''''];
   	else
      	eventos_texto=[eventos_texto,':',num2str(segundos(i)),''''];
	   end
   	if milesimos(i) <10,
      	eventos_texto=[eventos_texto,'00',num2str(milesimos(i)),'" -\n'];
	   elseif milesimos(i) <100,
   	   eventos_texto=[eventos_texto,'0',num2str(milesimos(i)),'" -\n'];
	   else
   	   eventos_texto=[eventos_texto,num2str(milesimos(i)),'" -\n'];
	   end
	end

	prontuario=[...
		'Patient Record\n\n',...
	   'Name:\nAge:\nGender:\nPlace of Origin:\nAddress:\nPhone:\nDate of Exam:\n\n',...
   	'Clinical History:\n\n',...
	   'Personal History:\n\n',...
   	'Family History:\n\n',...
	   'Physical Exam:\n\n',...
   	'Events on Recorded ECG:\n',eventos_texto,...
	   '\nExperimental Protocol:'];
	fid=fopen(filename,'w'); %permissions: r,w,a,r+,w+,a+,W,A %se erro fid=-1
   prontuario=sprintf(prontuario);   
   fwrite(fid,prontuario,'char');
else %caso contrario, le o arquivo
   prontuario=sprintf('%s',fread(fid,'char'));
   prontuario=prontuario(find(prontuario~=13));  %apaga os 13
end

fclose(fid);


