function s=espectralRR_sareas2(avlf,alf,ahf,rlfhf,NRR,Neb)

if avlf<10,
   label1='\nVLF:  ';
else,
   label1='\nVLF: ';
end,

if alf<10,
   label2=' %%\nLF:   ';
else,
   label2=' %%\nLF:  ';
end,

if ahf<10,
   label3=' %%\nHF:   ';
else,
   label3=' %%\nHF:  ';
end,

label4=' %%\n\n      LF/HF Ratio: ';
label5='\n\n';
label6=' R-R intervals (';
label7=' marked)';


if round(avlf)==avlf,label2=['.0',label2];end,
if round(alf)==alf,label3=['.0',label3];end,
if round(ahf)==ahf,label4=['.0',label4];end,   

%constroi a string
s=sprintf(['Relative Areas\n',label1,num2str(avlf),label2,num2str(alf),...
      label3,num2str(ahf),label4,num2str(rlfhf),label5,num2str(NRR),label6,num2str(Neb),label7]);
