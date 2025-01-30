function events = prep_rename_events (events)
%% RENAME_EVENTS
% -------------------------------------------------------------------------
%  This function returns the renamed events. You have to change according with your events names:

fprintf('\n<strong> > Renaming events...</strong>\n\n');

for i = 1 : length(events)
    
%     event_code = events(i).code;
%     event_id = events(i).type;
    
    if strcmp(event_code,'Stimulus')
        
        % if strcmp(event_id,'S  1') % Change according with your experiment
%             str = 'CUE_ANIMAL_SYMBOL_INT';
%         elseif strcmp(event_id,'S  2')
%             str = 'CUE_TOOL_SYMBOL_INT';
%         elseif strcmp(event_id,'S  3')
%             str = 'CUE_ANIMAL_LETTER_INT';  
%         elseif strcmp(event_id,'S  4')
%             str = 'CUE_TOOL_LETTER_INT';
%         end
        
%         events(i).type = str;
        
    end
    
end

end