function acq2ecglab(ecgchn)

[filename,filepath]=uigetfile('*.acq','Multiselect','on');
l=size(filename,2);

if iscell(filename)

    for i=1:l
        file=filename{i};
        DATA=pop_biosig([filepath file]);
        ecg=DATA.data(ecgchn,:)';
        fs=DATA.srate;
        point=find(file=='.');
        newname=file(1:point-1);
        save([newname '.mat'],'ecg','fs');
    end

else
    file=filename;
    DATA=pop_biosig([filepath file]);
    ecg=DATA.data(ecgchn,:)';
    fs=DATA.srate;

    point=find(file=='.');
    newname=file(1:point-1);
    save([newname '.mat'],'ecg','fs');
end


