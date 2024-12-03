function events = prep_rename_events (events)
%% RENAME_EVENTS
% -------------------------------------------------------------------------
% You can edit this script or do another in order to rename your events.
% This function returns the renamed events:

fprintf('\n<strong> > Renaming events...</strong>\n\n');

for i = 1 : length(events)
    
    event_code = events(i).code;
    event_id = events(i).type;
    
    if strcmp(event_code,'Stimulus')
        
        if strcmp(event_id,'S  1') % Replace by your own
            str = 'CUE_ANIMAL_SYMBOL_INT';
%         elseif strcmp(event_id,'S  2')
%             str = 'CUE_TOOL_SYMBOL_INT';
%         elseif strcmp(event_id,'S  3')
%             str = 'CUE_ANIMAL_LETTER_INT';  
%         elseif strcmp(event_id,'S  4')
%             str = 'CUE_TOOL_LETTER_INT';
%         elseif strcmp(event_id,'S  5')
%             str = 'CUE_ANIMAL_SYMBOL_SEL'; 
%         elseif strcmp(event_id,'S  6')
%             str = 'CUE_TOOL_SYMBOL_SEL';
%         elseif strcmp(event_id,'S  7')
%             str = 'CUE_ANIMAL_LETTER_SEL';
%         elseif strcmp(event_id,'S  8')
%             str = 'CUE_TOOL_LETTER_SEL';
        end
        
        events(i).type = str;
        
    end
    
end

end