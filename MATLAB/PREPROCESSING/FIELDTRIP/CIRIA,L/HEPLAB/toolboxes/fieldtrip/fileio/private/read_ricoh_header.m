function hdr = read_ricoh_header(filename)

%% READ_RICOH_HEADER reads the header information from continuous
%% or averaged MEG data generated by the Ricoh MEG system and software
%% and allows the data to be used in FieldTrip.
%%
%% Use as
%%  [hdr] = read_ricoh_header(filename)
%%
%% This is a wrapper function around the functions
%% getRHdrSystem
%% getRHdrChannel
%% getRHdrAcqCond
%% getRHdrCoregist
%% getRHdrDigitize
%% getRHdrSource
%%
%% See also READ_RICOH_DATA, READ_RICOH_EVENT

% ensure that the required toolbox is on the path
ft_hastoolbox('ricoh_meg_reader', 1);

% define several constants listed below
handles = definehandles;

sys_info = getRHdrSystem(filename);
id = sys_info.system_id;
ver = sys_info.version;
rev = sys_info.revision;
sys_name = sys_info.system_name;
model_name = sys_info.model_name;
clear('sys_info'); % remove structure as local variables are collected in the end

channel_info = getRHdrChannel(filename);
channel_count = channel_info.channel_count;

acq_cond = getRHdrAcqCond(filename);
acq_type = acq_cond.acq_type;

% these depend on the data type
sample_rate        = [];
sample_count       = [];
pretrigger_length  = [];
averaged_count     = [];
actual_epoch_count = [];

switch acq_type
  case handles.AcqTypeContinuousRaw
    sample_rate = acq_cond.sample_rate;
    sample_count = acq_cond.sample_count;
    if isempty(sample_rate) || isempty(sample_count)
      ft_error('invalid sample rate or sample count in ', filename);
      return;
    end
    pretrigger_length = 0;
    averaged_count = 1;
    
  case handles.AcqTypeEvokedAve
    sample_rate = acq_cond.sample_rate;
    sample_count = acq_cond.frame_length;
    pretrigger_length = acq_cond.pretrigger_length;
    averaged_count = acq_cond.average_count;
    if isempty(sample_rate) || isempty(sample_count) || isempty(pretrigger_length) || isempty(averaged_count)
      ft_error('invalid sample rate or sample count or pre-trigger length or average count in ', filename);
      return;
    end
    
  otherwise
    ft_error('unknown data type');
end
clear('acq_cond'); % remove structure as local variables are collected in the end

coregist = getRHdrCoregist(filename);
digitize = getRHdrDigitize(filename);
source = getRHdrSource(filename);

% put all local variables into a structure, this is a bit unusual matlab programming style
tmp = whos;
orig = [];
for i=1:length(tmp)
  if isempty(strmatch(tmp(i).name, {'tmp', 'ans', 'handles'}))
    orig = setfield(orig, tmp(i).name, eval(tmp(i).name));
  end
end

% convert the original header information into something that FieldTrip understands
hdr = [];
hdr.orig         = orig;                % also store the original full header information
hdr.Fs           = orig.sample_rate;    % sampling frequency
hdr.nChans       = orig.channel_count;  % number of channels
hdr.nSamples     = [];                  % number of samples per trial
hdr.nSamplesPre  = [];                  % number of pre-trigger samples in each trial
hdr.nTrials      = [];                  % number of trials

switch orig.acq_type
  case handles.AcqTypeEvokedAve
    hdr.nSamples    = orig.sample_count;
    hdr.nSamplesPre = orig.pretrigger_length;
    hdr.nTrials     = 1;                % only the average, which can be considered as a single trial
  case handles.AcqTypeContinuousRaw
    hdr.nSamples    = orig.sample_count;
    hdr.nSamplesPre = 0;                % there is no fixed relation between triggers and data
    hdr.nTrials     = 1;                % the continuous data can be considered as a single very long trial
  otherwise
    ft_error('unknown acquisition type');
end

% construct a cell-array with labels of each channel
% this should be consistent with the predefined list in ft_senslabel,
% with ricoh2grad and with ft_channelselection
for i=1:hdr.nChans
  if     hdr.orig.channel_info.channel(i).type == handles.NullChannel
    prefix = '';
  elseif hdr.orig.channel_info.channel(i).type == handles.MagnetoMeter
    prefix = 'M';
  elseif hdr.orig.channel_info.channel(i).type == handles.AxialGradioMeter
    prefix = 'AG';
  elseif hdr.orig.channel_info.channel(i).type == handles.PlannerGradioMeter
    prefix = 'PG';
  elseif hdr.orig.channel_info.channel(i).type == handles.RefferenceMagnetoMeter
    prefix = 'RM';
  elseif hdr.orig.channel_info.channel(i).type == handles.RefferenceAxialGradioMeter
    prefix = 'RAG';
  elseif hdr.orig.channel_info.channel(i).type == handles.RefferencePlannerGradioMeter
    prefix = 'RPG';
  elseif hdr.orig.channel_info.channel(i).type == handles.TriggerChannel
    prefix = 'TRIG';
  elseif hdr.orig.channel_info.channel(i).type == handles.EegChannel
    prefix = 'EEG';
  elseif hdr.orig.channel_info.channel(i).type == handles.EcgChannel
    prefix = 'ECG';
  elseif hdr.orig.channel_info.channel(i).type == handles.EtcChannel
    prefix = 'ETC';
  end
  hdr.label{i} = sprintf('%s%03d', prefix, i);
  
  % overwrite EEG-channel labels
  if hdr.orig.channel_info.channel(i).type == handles.EegChannel
    if ~isempty(hdr.orig.channel_info.channel(i).data.name)
      hdr.label{i} = hdr.orig.channel_info.channel(i).data.name;
    end
  end
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this defines several useful constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = definehandles
handles.output = [];
handles.sqd_load_flag = false;
handles.mri_load_flag = false;
handles.NullChannel         = 0;
handles.MagnetoMeter        = 1;
handles.AxialGradioMeter    = 2;
handles.PlannerGradioMeter  = 3;
handles.RefferenceChannelMark = hex2dec('0100');
handles.RefferenceMagnetoMeter       = bitor( handles.RefferenceChannelMark, handles.MagnetoMeter );
handles.RefferenceAxialGradioMeter   = bitor( handles.RefferenceChannelMark, handles.AxialGradioMeter );
handles.RefferencePlannerGradioMeter = bitor( handles.RefferenceChannelMark, handles.PlannerGradioMeter );
handles.TriggerChannel      = -1;
handles.EegChannel          = -2;
handles.EcgChannel          = -3;
handles.EtcChannel          = -4;
handles.NonMegChannelNameLength = 32;
handles.DefaultMagnetometerSize       = (4.0/1000.0);       % Square of 4.0mm in length
handles.DefaultAxialGradioMeterSize   = (15.5/1000.0);      % Circle of 15.5mm in diameter
handles.DefaultPlannerGradioMeterSize = (12.0/1000.0);      % Square of 12.0mm in length
handles.AcqTypeContinuousRaw = 1;
handles.AcqTypeEvokedAve     = 2;
handles.AcqTypeEvokedRaw     = 3;
handles.sqd = [];
handles.sqd.selected_start  = [];
handles.sqd.selected_end    = [];
handles.sqd.axialgradiometer_ch_no      = [];
handles.sqd.axialgradiometer_ch_info    = [];
handles.sqd.axialgradiometer_data       = [];
handles.sqd.plannergradiometer_ch_no    = [];
handles.sqd.plannergradiometer_ch_info  = [];
handles.sqd.plannergradiometer_data     = [];
handles.sqd.eegchannel_ch_no   = [];
handles.sqd.eegchannel_data    = [];
handles.sqd.nullchannel_ch_no   = [];
handles.sqd.nullchannel_data    = [];
handles.sqd.selected_time       = [];
handles.sqd.sample_rate         = [];
handles.sqd.sample_count        = [];
handles.sqd.pretrigger_length   = [];
handles.sqd.matching_info   = [];
handles.sqd.source_info     = [];
handles.sqd.mri_info        = [];
handles.mri                 = [];
