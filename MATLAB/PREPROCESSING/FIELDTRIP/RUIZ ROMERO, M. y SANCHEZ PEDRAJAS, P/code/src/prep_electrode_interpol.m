function [data, neighbours] = prep_electrode_interpol(conf,data)
%% PREP_ELECTRODE_INTERPOL
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% This function interpoles the indicated bad channels:

fprintf('\n<strong> > Electrode interpolation...</strong>\n\n');

% The configuration for manual can contain this cfg for ft_prepare_neighbours:
cfg = [];
cfg.method = conf.method.interpole; 
cfg.layout = conf.layout;

neighbours = ft_prepare_neighbours(cfg, data);      % This structure of neighbours electrodes is for any condition.

cfg = [];
cfg.neighbours = neighbours;                        % Neighbourhood structure, see FT_PREPARE_NEIGHBOURS for details
cfg.badchannel = conf.badchannels;
cfg.elecfile = conf.elecfile;
    
data = ft_channelrepair (cfg, data);

cfg = [];
cfg.viewmode = conf.viewmode; 

ft_databrowser (cfg, data);                         %  View of data with correct electrodes.

% Save data if needed:

if conf.interpole.save

    save_subject_data(conf,data,conf.interpole.sdir);
    sdir = [conf.datapath filesep 'derivatives' filesep  conf.subject.id filesep 'eeg'];
    save([sdir filesep 'neighbours.mat'],'neighbours');

end 

end

