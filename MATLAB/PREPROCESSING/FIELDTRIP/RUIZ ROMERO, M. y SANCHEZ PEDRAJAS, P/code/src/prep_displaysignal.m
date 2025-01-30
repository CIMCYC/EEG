function data = prep_displaysignal(conf,data)
%% PREP_DISPLAYSIGNAL
% -------------------------------------------------------------------------
% María Ruiz and María del Pilar Sánchez
% mariaruizromero@ugr.es, pilarsanpe@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% This function removes bad channels (eg. EOG channels) if needed.

fprintf('\n<strong> > View signal...</strong>\n\n');

cfg.viewmode    = conf.viewmode; 

ft_databrowser (cfg, data);   
