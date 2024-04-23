function [indices_r,ebs_indices]=ecglabRR_marcaondaR(ecg_sinal,indices_r,ebs_indices,ecg_handle,eixox1,segundos_janela,segundos_sinal)
% usage:

global samplerate_ecg

eixox2=eixox1+segundos_janela;
tempo=(0:1/samplerate_ecg:segundos_sinal-1/samplerate_ecg)';

%precisao do mouse em pixels (para tras e para frente): 1->otima, 20->usuario vesgo
precisao_mouse_apagar=10;

%raio da clicada
x_range=0.01*(eixox2-eixox1);
y_range=0.04*2;
s_range=round(x_range*samplerate_ecg);

%le qual o ponto clicado no grafico do ecg
ponto=get(ecg_handle,'CurrentPoint');

x=ponto(1,1);
y=ponto(2,2);

%verifica se clicou dentro do ecg
if abs(y)<=1 & x>=eixox1 & x<eixox2,
   
   marca=find(ecg_sinal>=y-y_range & ecg_sinal<=y+y_range & tempo>=x-x_range & tempo<=x+x_range);
   
   if isempty(marca)~=1,
      
      emq=((x-tempo(marca))/(eixox2-eixox1)).^2+((y-ecg_sinal(marca))/2).^2;
	   marca=marca(find(emq==min(emq)));

      
   	%verifica se ha uma marcacao nessa regiao      
   	marcacao=find(indices_r>=marca-s_range & indices_r<=marca+s_range);
      
      %se nao houver, faz a marcacao
   	if isempty(marcacao),
			indices_r=sort([indices_r;marca]);
      
	   %se houver, apaga a marcacao
   	else
         apagaR=indices_r(marcacao(1));
			naotirar_r=find(indices_r~=apagaR);
 	      if isempty(naotirar_r)~=1,
     	      indices_r=indices_r(naotirar_r);
         else
            indices_r=[];
         end
         
         if isempty(ebs_indices)~=1,
	         naotirar_eb=find(ebs_indices~=apagaR);
   	      if isempty(naotirar_eb)~=1,
      	      ebs_indices=ebs_indices(naotirar_eb);
            else
               ebs_indices=[];
            end
         end
      end     
	end   
end