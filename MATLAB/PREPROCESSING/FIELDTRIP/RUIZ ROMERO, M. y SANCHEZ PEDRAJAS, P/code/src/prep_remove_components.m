function  data = prep_remove_components(conf,comp,data,badicas)
%% PREP_REMOVE_COMPONENTS 
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function removes the identified artifactual components after ICA
% decomposition:

fprintf('\n<strong> > Removing artifuactual ICA components...</strong>\n\n');

cfg.component = badicas;

data = ft_rejectcomponent (cfg, comp, data);

% Save data if needed:
if conf.ica.badcomponents.save

    save_subject_data(conf,data,conf.ica.badcomponents.sdir);

end
    
end

