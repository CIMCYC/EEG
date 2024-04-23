function s=espectralRR_sareas3(anlf,anhf)

if anlf<10,
   label2='\nLF:  ';
else,
   label2='\nLF: ';
end,

if anhf<10,
   label3=' n.u.\nHF:  ';
else,
   label3=' n.u.\nHF: ';
end,

label4=[];

if round(anlf)==anlf,label3=['.0',label3];end,
if round(anhf)==anhf,label4=['.0',label4];end,   

%constroi a string
s=sprintf(['Normalized Areas\n',label2,num2str(anlf),label3,num2str(anhf),' n.u.']);
