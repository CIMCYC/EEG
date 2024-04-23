function ebs_handle=ectopics_intervalograma2(tempoRR,intervaloRR,ebs_indices,verdadeiros,ebs_handle)
%usage: 
% usado na hora da correcao e validacao do hrv

posicao=[60 210 950 480];

%apaga o plot anterior
if ebs_handle~=-1,
   delete(ebs_handle);
end

%cria o handle da regiao do plot
ebs_handle=axes('Units','pixels','Position',posicao);

plot(verdadeiros,intervaloRR(verdadeiros),'b-')
hold on
set(plot(ebs_indices,intervaloRR(ebs_indices),'r.'),'MarkerSize',5);
hold off
axis([1 length(intervaloRR) min(intervaloRR)-75 max(intervaloRR)+75]);
xlabel('R-R interval number'),
ylabel('R-R interval duration (ms)'),
grid,