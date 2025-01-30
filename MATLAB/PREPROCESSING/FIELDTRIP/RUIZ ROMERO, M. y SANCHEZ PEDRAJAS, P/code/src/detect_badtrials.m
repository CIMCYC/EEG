function [badtrials] = detect_badtrials (cfg, data)

% Inspección manual de ensayos artefactados de datos en formato Fieldtrip
% La función va mostrando ensayo tras ensayo los canales de: EEG, VEOG y HEOG
% 
% Para marcar como malo un ensayo pulsar con el botón izquierdo del ratón
% Para marcar como bueno un ensayo pulsar con una tecla del teclado
% Para cortar el script si fuera necesario, pulsar ctrl + C
%
% Automáticamente la lista de ensayos malos (badtrials) se guardará en la
% carpeta del sujeto (en la que estemos trabajando) 
% 
% Opciones:
% cfg.toilim  = ventana temporal que se quiere visualizar, [t1 t2] en segundos; default la época completa
% cfg.ylim    = amplitud de voltaje para visualizar los datos; default [-100 +100] en muV 
%
% Almudena Capilla, UAM

time  = data.time{1};
label = data.label;

if isfield(cfg, 'toilim')
    t1 = cfg.toilim(1);      
    t2 = cfg.toilim(2);   
else
    t1 = time(1);     
    t2 = time(end); 
end

if isfield(cfg, 'ylim')
    v1 = cfg.ylim(1);      
    v2 = cfg.ylim(2);   
else
    v1 = -100;     
    v2 = +100; 
end

badtrials=[];

VEOG = find(strcmp(label,'VEOG')==1);
HEOG = find(strcmp(label,'HEOG')==1);
channels = ones(1,length(label)) ;
channels([VEOG,HEOG]) = 0;
EEG = find(channels==1) ;     % todos los canales que no son EOG

figure
count=1;
badtrials=[];
tr = 1;
while tr <= length(data.trial)
    subplot(3,1,1)           % EEG channels
    plot(time,data.trial{tr}(EEG,:))
    set(gca,'XLim',[t1 t2])
    set(gca,'YLim',[v1 v2])
    title(['Trial number ' num2str(tr) ' / ' num2str(length(data.trial))])
    
%     subplot(3,1,2)           % VEOG channels
%     plot(time,data.trial{tr}(VEOG,:))
%     set(gca,'XLim',[t1 t2])
%     set(gca,'YLim',[v1 v2])
%     title('VEOG')
%     
%     subplot(3,1,3)           % HEOG channels
%     plot(time,data.trial{tr}(HEOG,:))
%     set(gca,'XLim',[t1 t2])
%     set(gca,'YLim',[v1 v2])
%     title('HEOG')
    
    keydown = waitforbuttonpress;
    value = double(get(gcf,'CurrentCharacter'));
    if (keydown == 0)
        badtrials(count)=tr;
        count=count+1;
    elseif value == 28
         disp(value);
         tr = tr-2;
    end
    tr = tr+1;      
end

save badtrials badtrials

close(clf)

