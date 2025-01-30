function [data] = prep_deletebadtrials(conf,data)
%% PREP_DELETEBADTRIALS
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function removes bad channels (eg. EOG channels) if needed.

fprintf('\n<strong> > Deleting channels...</strong>\n\n');

cfg.toilim  = conf.toilim.deletebadtrials;
cfg.ylim    = conf.ylim.deletebadtrials;

if strcmp(conf.deletebadtrials.mode,'automatic')
       data = ft_artifact_threshold (cfg, data);

elseif strcmp(conf.deletebadtrials.mode, 'semiautomatic')

       cfg.method = conf.method.deletebadtrials;
       cfg.channel = conf.channel.deletebadtrials;
       data = ft_rejectvisual (cfg, data);
         
else
       % manual
       badtrials = detect_badtrials (cfg, data);
       cfg.badtrials = badtrials;
       data = reject_badtrials (cfg, data);
        
end
    
% Save data if needed:
if conf.deletebadtrials.save

    save_subject_data(conf,data,conf.deletebadtrials.sdir);

end

end
