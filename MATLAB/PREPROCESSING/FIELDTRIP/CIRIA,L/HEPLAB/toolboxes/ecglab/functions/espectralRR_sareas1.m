function s=espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo)

%constroi a string
switch metodo,
	case {'fhpis','fhpc_','fhp__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),' ms�\nLF:  ',num2str(aalf),...
      	' ms�\nHF:  ',num2str(aahf),' ms�\n\nTotal: ',num2str(aatotal),' ms�']);		
	case {'fhris','fhrc_','fhr__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),' bpm�\nLF:  ',num2str(aalf),...
      	' bpm�\nHF:  ',num2str(aahf),' bpm�\n\nTotal: ',num2str(aatotal),' bpm�']);		
	case {'lhp__','lhr__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),'\nBF:  ',num2str(aalf),...
      	'\nHF:  ',num2str(aahf),'\n\nTotal: ',num2str(aatotal),'']);
end
   



