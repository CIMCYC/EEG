function ebs_indices=ectopics_marcaeb_mouse(ebs_indices,intervaloRR,eixox1,eixox2)
%usage:

marca=[];
temp=[];
x_range=round(0.01*(eixox2-eixox1));
y_range=round(0.04*(max(intervaloRR)-min(intervaloRR)));
i=0;

nRR=(1:length(intervaloRR))';

while (i==0), %repete ate clicar dentro da area valida
   [x,y]=ginput(1); %le do mouse (com cursor)
   %se o click foi na area valida...
  	if ( x>=eixox1 & x<=eixox2 & y>=min(intervaloRR(eixox1:eixox2))-75 & y<=max(intervaloRR(eixox1:eixox2))+75), 
      marca=find(intervaloRR>=y-y_range & intervaloRR<=y+y_range & nRR>=x-x_range & nRR<=x+x_range);
      i=i+1; %marcacao completada
   end,
end,

if isempty(marca)~=1,
   
   emq=((x-nRR(marca))/(eixox2-eixox1)).^2+((y-intervaloRR(marca))/(max(intervaloRR)-min(intervaloRR))).^2;
   marca=marca(find(emq==min(emq)));

	%marca ou apaga o intervalo clicado
	if isempty(ebs_indices),
	   k=[];
	else,
	   k=find(ebs_indices==marca);
	end,
	if isempty(k),
	   ebs_indices=[ebs_indices;marca];
	else
	   if k==1 & length(ebs_indices)==1,
   	   ebs_indices=[];
	   elseif k==1,
   	   ebs_indices=ebs_indices(k+1:length(ebs_indices));
	   elseif k<length(ebs_indices),
   	   ebs_indices=[ebs_indices(1:k-1);ebs_indices(k+1:length(ebs_indices))];
	   else
      	ebs_indices=ebs_indices(1:k-1);
   	end
	end

end