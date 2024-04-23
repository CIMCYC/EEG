% original 'mat2txt_maga.m', modified by
% Pandelis 21-4-2011

[filename, filepath] = uigetfile('*.mat' ,...
    'MultiSelect', 'on');

l=size(filename,2);
for i=1:l
    load([filepath filename{i}]);
    %data = data';
    ecg=data(:,1);
    %emg=data(:,2);
    %temp=data(:,3);
    %condut=data(:,4);
    %pulso=data(:,5);
    %resp=data(:,6);
    trg=data(:,7);

    point=find(filename{i}=='.');
    name=filename{i}; name=name(1:point-1);

    % marcas de inicio
    trginicio=[];
    for i=1:length(trg)-1
        if trg(i)==0 && trg(i+1)>0.1
            trginicio=[trginicio;i+1];
        end
    end
    
    plot (trg); hold on; plot(trginicio,trg(trginicio),'ro')
    
    triggers=trginicio/1000;
    fs=1000;
    
    conds={'ini'};    
    
    %export
    save ([name '_ecg.mat'],'ecg','fs');
    save ([name '_trg.mat'],'triggers','conds');
    
%     % export
%     save (['a' name '.trg'], 'marcas', '-ascii')
%     %save (['a' name '.rsp'], 'resp', '-ascii')
%     %save (['a' name '.emg'], 'emg', '-ascii')
%     %save (['a' name '.pul'], 'pulso', '-ascii')
%     %save (['a' name '.tmp'], 'temp', '-ascii')
%     %save (['a' name '.scr'], 'condut', '-ascii')
%     %save (['a' name '.ecg'], 'ecg', 'fs')
%     ecgconvert(ecg(:,1),['a' name],1,length(ecg(:,1)));
   end

