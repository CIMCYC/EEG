function ebs_indices=ecglabRR_apagaeb(ebs_indices,ecg_ondar,ecg_sinal,posicao,tam_janela)

%inicializa variaveis
global samplerate_ecg

ms=0.150;
ebs_indices=[ebs_indices;-1];
ebs_indices_anterior=ebs_indices;

   i=0;
	while (i==0), %repete ate clicar dentro da area valida
	   [x,y]=ginput(1); %le do mouse (com cursor)
	   %se o click foi na area valida...
   	if (x>=posicao & x<posicao+tam_janela & y>=-1 & y<=1), 
         marca=round(x*1000)/1000; %deixa só 3 casas decimais
         indice=round(marca*samplerate_ecg)+1; %calcula o indice da amostra
         
         %procura ectopico proximo
         maior=sort(find(ebs_indices>=indice & ebs_indices<=indice+ms*samplerate_ecg));
         if length(maior)>=1,
            maior=ebs_indices(maior(1));
         end
         menor=sort(find(ebs_indices<indice & ebs_indices>=indice-ms*samplerate_ecg));
	      if length(menor)>=1,
	         menor=ebs_indices(menor(length(menor)));
         end
         
         if isempty(maior)~=1,
            indice=maior;
            ebs_indices=ebs_indices(find(ebs_indices~=indice)); %marca a amostra
         elseif isempty(menor)~=1,
            indice=menor;
            ebs_indices=ebs_indices(find(ebs_indices~=indice)); %marca a amostra
         else
            indice=[];
         end
         
         i=1; %marcacao completada
	   end,
	end,
   
ebs_indices=ebs_indices(find(ebs_indices~=-1));