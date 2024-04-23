function events = prep_rename_events (events)
%% RENAME_EVENTS - only works for InstComp experiment
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
% You have to change every event_names according to task
% This function returns the renamed events:

fprintf('\n<strong> > Renaming events...</strong>\n\n');
event_names = {events.type};

% Main task:
cnt = 0;
for att = {'SEL','INT'} 
    for cat = {'ANIM','INAN'}
        for feat = {'C','S'}
            cnt = cnt + 1;
            event_names(strcmp(event_names,['S 1' num2str(cnt)])) = ...
                {['Inst_1_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 2' num2str(cnt)])) = ...
                {['ISI_Inst_1_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 3' num2str(cnt)])) = ...
                {['Inst_2_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 4' num2str(cnt)])) = ...
                {['ISI_Inst_2_' att{1} '_' cat{1} '_' feat{1}]};        
            event_names(strcmp(event_names,['S 5' num2str(cnt)])) = ...
                {['Inst_3_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 6' num2str(cnt)])) = ...
                {['ISI_Inst_3_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 7' num2str(cnt)])) = ...
                {['Inst_4_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S 8' num2str(cnt)])) = ...
                {['ISI_Inst_4_' att{1} '_' cat{1} '_' feat{1}]};            
            event_names(strcmp(event_names,['S 9' num2str(cnt)])) = ...
                {['PREP_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S10' num2str(cnt)])) = ...
                {['PROBE_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S11' num2str(cnt)])) = ...
                {['PROBE_FIX_' att{1} '_' cat{1} '_' feat{1}]};
            event_names(strcmp(event_names,['S14' num2str(cnt)])) = ...
                {['ITI_' att{1} '_' cat{1} '_' feat{1}]};
        end
    end
end
event_names(strcmp(event_names,'S254')) = {'Response'};

% Localizer
event_names(strcmp(event_names,'S151')) = {'LOC_PROBE_mammal_0_1'};
event_names(strcmp(event_names,'S152')) = {'LOC_PROBE_mammal_0_2'};
event_names(strcmp(event_names,'S153')) = {'LOC_PROBE_sea_0_3'};
event_names(strcmp(event_names,'S154')) = {'LOC_PROBE_sea_0_4'};
event_names(strcmp(event_names,'S155')) = {'LOC_PROBE_tool_0_5'};
event_names(strcmp(event_names,'S156')) = {'LOC_PROBE_tool_0_6'};
event_names(strcmp(event_names,'S157')) = {'LOC_PROBE_instr_0_7'};
event_names(strcmp(event_names,'S158')) = {'LOC_PROBE_instr_0_8'};

event_names(strcmp(event_names,'S161')) = {'LOC_PROBE_FIX_mammal_0_1'};
event_names(strcmp(event_names,'S162')) = {'LOC_PROBE_FIX_mammal_0_2'};
event_names(strcmp(event_names,'S163')) = {'LOC_PROBE_FIX_sea_0_3'};
event_names(strcmp(event_names,'S164')) = {'LOC_PROBE_FIX_sea_0_4'};
event_names(strcmp(event_names,'S165')) = {'LOC_PROBE_FIX_tool_0_5'};
event_names(strcmp(event_names,'S166')) = {'LOC_PROBE_FIX_tool_0_6'};
event_names(strcmp(event_names,'S167')) = {'LOC_PROBE_FIX_instr_0_7'};
event_names(strcmp(event_names,'S168')) = {'LOC_PROBE_FIX_instr_0_8'};

event_names(strcmp(event_names,'S171')) = {'LOC_PROBE_mammal_1_1'};
event_names(strcmp(event_names,'S172')) = {'LOC_PROBE_mammal_1_2'};
event_names(strcmp(event_names,'S173')) = {'LOC_PROBE_sea_1_3'};
event_names(strcmp(event_names,'S174')) = {'LOC_PROBE_sea_1_4'};
event_names(strcmp(event_names,'S175')) = {'LOC_PROBE_tool_1_5'};
event_names(strcmp(event_names,'S176')) = {'LOC_PROBE_tool_1_6'};
event_names(strcmp(event_names,'S177')) = {'LOC_PROBE_instr_1_7'};
event_names(strcmp(event_names,'S178')) = {'LOC_PROBE_instr_1_8'};

event_names(strcmp(event_names,'S181')) = {'LOC_PROBE_FIX_mammal_1_1'};
event_names(strcmp(event_names,'S182')) = {'LOC_PROBE_FIX_mammal_1_2'};
event_names(strcmp(event_names,'S183')) = {'LOC_PROBE_FIX_sea_1_3'};
event_names(strcmp(event_names,'S184')) = {'LOC_PROBE_FIX_sea_1_4'};
event_names(strcmp(event_names,'S185')) = {'LOC_PROBE_FIX_tool_1_5'};
event_names(strcmp(event_names,'S186')) = {'LOC_PROBE_FIX_tool_1_6'};
event_names(strcmp(event_names,'S187')) = {'LOC_PROBE_FIX_instr_1_7'};
event_names(strcmp(event_names,'S188')) = {'LOC_PROBE_FIX_instr_1_8'};

event_names(strcmp(event_names,'S199')) = {'LOC_ITI'};

for i = 1:length(events)
    events(i).type = event_names{i};
end

end