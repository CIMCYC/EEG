function data = prep_rereference(cfg,data)
%% PREP_REREFERENCE
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
%
% Recover reference electrode manually:

subject_idx = str2double(data.subject.id(end-2:end));
interpolated_channels = cfg.interpole.channels{subject_idx};
ignoredchannels = setdiff(cfg.ignoredchannels{subject_idx},interpolated_channels);

if cfg.refelec.flag

   fprintf('\n<strong> > Recovering reference electrode...</strong>\n\n');

   data = pop_chanedit(data, 'append',cfg.refelec.chan-1,...
        'changefield',{cfg.refelec.chan 'labels' cfg.refelec.label},...
        'changefield',{cfg.refelec.chan 'X' num2str(cfg.refelec.X)},...
        'changefield',{cfg.refelec.chan 'Y' num2str(cfg.refelec.Y)},...
        'changefield',{cfg.refelec.chan 'Z' num2str(cfg.refelec.Z)},...
        'changefield',{cfg.refelec.chan 'sph_theta' num2str(cfg.refelec.sph_theta)},...
        'changefield',{cfg.refelec.chan 'sph_phi' num2str(cfg.refelec.sph_phi)},...
        'changefield',{cfg.refelec.chan 'sph_radius' num2str(cfg.refelec.sph_radius)},...
        'changefield',{cfg.refelec.chan 'type' cfg.refelec.type});
end

% Compute re-reference:

if cfg.reref.flag
    fprintf('\n<strong> > Computing re-reference...</strong>\n\n');
    data = pop_reref(data,cfg.reref.chan,'refloc',struct(...
        'labels',{cfg.refelec.label},...
        'sph_radius',{cfg.refelec.sph_radius},...
        'sph_theta',{cfg.refelec.sph_theta},...
        'sph_phi',{cfg.refelec.sph_phi},...
        'theta',{cfg.refelec.theta},...
        'radius',{cfg.refelec.radius},...
        'X',{cfg.refelec.X},...
        'Y',{cfg.refelec.Y},...
        'Z',{cfg.refelec.Z},...
        'type',{cfg.refelec.type},...
        'ref',{''},...
        'urchan',{[]},'datachan',{0}),...
        'exclude',ignoredchannels);
end

% Save data if needed:
if cfg.reref.save
   save_subject_data(cfg,data,cfg.reref.sdir);
end

end

