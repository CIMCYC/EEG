function [P,freq]=lomb(y,t,freq)
%usage: P=lomb(y,t,freq)
%
% freq: vetor das frequencias em Hz
%
%       -> a componente DC será trocada por uma
%          componente de baixissima frequencia
%
% y(t): sinal de entrada
%
% P(freq): funcao de saida (periodograma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AJUSTA AS VARIAVEIS DE ENTRADA PARA AS NECESSIDADES DO ALGORITMO
%

%verifica se y e t sao ambos vetores linha ou vetores coluna
if size(y)~=size(t)
   error('Y e T não são vetores de mesmas dimensoes MxN!'),
end

% y e t devem ser vetores coluna
temp=size(y);
if temp(1)==temp(2),
   error('Y e T devem ser vetores, e nao matrizes!')
elseif temp(1)==1,
   y=y';
   t=t';
end

%freq deve ser vetor linha
temp=size(freq);
if temp(1)==temp(2),
   error('FREQ deve ser um vetor, e nao uma matriz ou uma constante!')
elseif temp(2)==1,
   freq=freq';
   transposta=1; %para indicar que deve fazer a transposta da saida no final
else, transposta=0; end

%se ele pedir o valor da componente DC,
%substitui por uma componente de frequencia
%muito baixa para evitar divisao por zero
if freq(1)==0,
   freq(1)=10^-6*freq(2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcula o PSD
%

%calcula media, variancia, comprimento de y e vetor w
variancia=var(y);
media=mean(y);
ylen=length(y);
w=2*pi*freq;

%meu metodo

%reconstroi as matrizes t, y e w replicando seus valores
%t=repmat(t,[1 length(w)]);
%y=repmat(y,[1 length(w)]);
%w=repmat(w,[ylen 1]);

% calculo do y'
%ylinha=(y-media)/media; %paper do shin
%ylinha=y-media; %paper do laguna

% tan(2*w*tau)
%tan2wtau=(sum(sin(2*w.*t)))./(sum(cos(2*w.*t)));

% tau
%tau=atan(tan2wtau)./(2*w(1,:)); %calcula o tau
%tau=repmat(tau,[ylen 1]); %replica os valores de tau

%calculo do espectro
%Pcos= sum( ylinha.*cos(w.*(t-tau)) ).^2  ./  sum( cos(w.*(t-tau)).^2 ) ;
%Psin= sum( ylinha.*sin(w.*(t-tau)) ).^2  ./  sum( sin(w.*(t-tau)).^2 ) ;
%P=(Pcos+Psin)/(2*variancia);

%metodo do adson
ylinha=y-media;
for n=1:length(w);
	tan2wtau=(sum(sin(2*w(n)*t)))/(sum(cos(2*w(n)*t)));
	tau=atan(tan2wtau)/(2*w(n));
	Pcos=((sum(ylinha.*cos(w(n)*(t-tau)))).^2)/(sum(cos(w(n)*(t-tau)).^2));
	Psin=((sum(ylinha.*sin(w(n)*(t-tau)))).^2)/(sum(sin(w(n)*(t-tau)).^2));
	P(n)=(Pcos+Psin)/(2*variancia);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% retorna os valores
%

%pega soh um vetor linha da matriz w e converte para freq
freq=w(1,:)/(2*pi);

%faz a transposta do resultado se necessario
if transposta==1,
   P=P';
   freq=freq';
end