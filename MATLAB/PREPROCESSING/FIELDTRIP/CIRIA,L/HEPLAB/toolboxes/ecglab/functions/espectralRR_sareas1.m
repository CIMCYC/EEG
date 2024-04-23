function s=espectralRR_sareas1(aavlf,aalf,aahf,aatotal,metodo)

%constroi a string
switch metodo,
	case {'fhpis','fhpc_','fhp__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),' ms²\nLF:  ',num2str(aalf),...
      	' ms²\nHF:  ',num2str(aahf),' ms²\n\nTotal: ',num2str(aatotal),' ms²']);		
	case {'fhris','fhrc_','fhr__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),' bpm²\nLF:  ',num2str(aalf),...
      	' bpm²\nHF:  ',num2str(aahf),' bpm²\n\nTotal: ',num2str(aatotal),' bpm²']);		
	case {'lhp__','lhr__'},
		s=sprintf(['Absolute Areas\n','\nVLF: ',num2str(aavlf),'\nBF:  ',num2str(aalf),...
      	'\nHF:  ',num2str(aahf),'\n\nTotal: ',num2str(aatotal),'']);
end
   



