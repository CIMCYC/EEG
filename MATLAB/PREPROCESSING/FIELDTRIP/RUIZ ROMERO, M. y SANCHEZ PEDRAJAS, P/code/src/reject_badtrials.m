function [dataclean] = reject_badtrials (cfg, data)

% Elimina de los datos la lista de badtrials que le demos
% 
% Opciones:
% cfg.badtrials  = número de los ensayos que queremos eliminar
%
% Almudena Capilla, UAM

if ~isfield(cfg, 'badtrials'), 
    error ('Por favor, especifica los ensayos que quieres eliminar en cfg.badtrials')
end

alltrials = ones(1,length(data.trial));
alltrials(cfg.badtrials) = 0;
goodtrials = find(alltrials==1);

cfg = [];
cfg.trials = goodtrials;
dataclean = ft_redefinetrial(cfg,data);
