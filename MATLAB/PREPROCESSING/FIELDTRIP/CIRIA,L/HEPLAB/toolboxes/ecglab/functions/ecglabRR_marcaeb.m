function ebs_indices=ecglabRR_marcaeb(ebs_indices,ecg_ondar,ecg_sinal,posicao,tam_janela)

%inicializa variaveis
global samplerate_ecg

if isempty(ebs_indices),
   ebs_indices=-1;
end

ebs_indices_anterior=ebs_indices;

while length(ebs_indices)==length(ebs_indices_anterior),
   i=0;
	while (i==0), %repete ate clicar dentro da area valida
	   [x,y]=ginput(1); %le do mouse (com cursor)
	   %se o click foi na area valida...
   	if (x>=posicao & x<posicao+tam_janela & y>=-1 & y<=1), 
         marca=round(x*1000)/1000; %deixa só 3 casas decimais
         indice=round(marca*samplerate_ecg)+1; %calcula o indice da amostra
         
         %procura onda R proxima
         maior=sort(find(ecg_ondar>=indice));
         maior=ecg_ondar(maior(1));
         menor=sort(find(ecg_ondar<indice));
         menor=ecg_ondar(menor(length(menor)));
         if maior-indice < indice-menor,
            indice=maior;
         else
            indice=menor;
         end
         
         if isempty(find(ebs_indices==indice)),
            ebs_indices=[ebs_indices;indice]; %marca a amostra
            i=1; %marcacao completada
         end
	   end,
	end,
end,

ebs_indices=ebs_indices(find(ebs_indices~=-1));