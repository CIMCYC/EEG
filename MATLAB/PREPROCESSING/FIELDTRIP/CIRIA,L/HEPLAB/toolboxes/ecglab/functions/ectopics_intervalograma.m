function ebs_handle=ectopics_intervalograma(tempoRR,intervaloRR,ebs_indices,ebs_handle,eixox1,eixox2)
%usage: 
% usado na hora da correcao e validacao do hrv

posicao=[60 210 950 480];

%apaga o plot anterior
if ebs_handle~=-1,
   delete(ebs_handle);
end

%cria o handle da regiao do plot
ebs_handle=axes('Units','pixels','Position',posicao);

plot(1:length(intervaloRR),intervaloRR,'k:');
hold on
set(plot(1:length(intervaloRR),intervaloRR,'k.'),'MarkerSize',5);
%set(plot(tempoRR,intervaloRR,'b+'),'MarkerSize',5);
if isempty(ebs_indices)~=1,
   plot(ebs_indices,intervaloRR(ebs_indices),'r.');
end
hold off
axis([eixox1 eixox2 min(intervaloRR(eixox1:eixox2))-75 max(intervaloRR(eixox1:eixox2))+75]);
xlabel('R-R interval number'),
ylabel('R-R interval duration (ms)'),
grid,