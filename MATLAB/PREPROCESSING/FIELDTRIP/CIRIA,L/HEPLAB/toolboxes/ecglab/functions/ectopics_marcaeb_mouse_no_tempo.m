function ebs_indices=ectopics_marcaeb_mouse(ebs_indices,intervaloRR,tempoRR)
%usage: ebs_indices=ectopics_marcaeb_mouse(ebs_indices,intervaloRR,tempoRR);

marca=[];
temp=[];
x_range=max(tempoRR)/600;
y_range=10;
i=0;

while (i==0), %repete ate clicar dentro da area valida
   [x,y]=ginput(1); %le do mouse (com cursor)
   %se o click foi na area valida...
  	if ( x>=min(tempoRR) & x<=max(tempoRR) & y>=200 & y<=2000), 
		k=y_range;
		while isempty(marca)==1,
		   marca=find( intervaloRR>=y-k & intervaloRR<=y+k );
		   k=k+2;
		end        
      i=i+1; %marcacao completada
   end,
end,

%apos escolher alguns intervalos pelo eixo y, esolhe o mais proximo pelo eixo x
k=x_range;
while isempty(temp) ==1,
	temp=find( tempoRR(marca) > x-k  &  tempoRR(marca) < x+k  );
   k=k+0.1;
end
marca=marca(temp(1));

%marca ou apaga o intervalo clicado
k=find(ebs_indices==marca);
if isempty(k)==1,
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
