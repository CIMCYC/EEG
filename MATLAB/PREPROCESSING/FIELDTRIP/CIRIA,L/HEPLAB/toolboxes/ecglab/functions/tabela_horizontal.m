function stabela=tabela_horizontal(A,linhas,colunas)
%tabela com dados na horizontal
% -> -> -> -> -> ->
% -> -> -> -> -> ->
% -> -> -> -> -> ->

%deixa só os ultimos elementos da tabela, se nao couber tudo
if length(A)>(linhas*colunas),
   A=A(length(A)-linhas*colunas+1:length(A));
end

%inicia a tabela
stabela='';

%faz a tabela (string)
for i=1:length(A),
   valor=num2str(A(i));
   switch length(valor)
	   case 1,
         stabela=[stabela,'    ',valor];
      case 2,
         stabela=[stabela,'   ',valor];
      case 3,
         stabela=[stabela,'  ',valor];
      otherwise
         stabela=[stabela,' ',valor];
   end
   
  if mod(i,colunas)==0,
     stabela=[stabela,'\n'];
  end
 
end

%retorna o valor formatado
stabela=sprintf(stabela);