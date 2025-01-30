function [badicas] = detect_badicas (cfg, data, comp)

% Inspección visual de ICAs 
% Previamente se tiene que haber aplicado ICA con ft_componentanalysis (el
% resultado comp es uno de los input de esta función)
% 
% Para marcar como malo un IC pulsar con el botón izquierdo del ratón
% Para marcar como bueno un IC pulsar con una tecla del teclado
% Para cortar el script si fuera necesario, pulsar ctrl + C
%
% Automáticamente la lista de icas malos (badicas) se guardará en la
% carpeta del sujeto (en la que estemos trabajando) 
% 
% Opciones:
% cfg.layout  = layout para visualizar topografías; default elec1005.lay
%
% Almudena Capilla, UAM

if isfield(cfg, 'layout')
    lay = cfg.layout;      
else
    lay = 'elec1005.lay';     
end

if isfield(cfg, 'toilim')
    t1r = cfg.toilim(1);      
    t2r = cfg.toilim(2);   
else
    t1r = time(1);     
    t2r = time(end); 
end

if isfield(cfg, 'ylim') 
    v1 = cfg.ylim(1);      
    v2 = cfg.ylim(2);   
else
    v1 = -10;     
    v2 = 10; 
end

cfgx = cfg;

cfg    = [];
cfg.vartrllength  =  1 ;
davg   = ft_timelockanalysis(cfg,data);    
t1 = davg.time(1);
t2 = davg.time(end);

figure
count = 1;
badicas = [];
ic = 1;

while ic <= size(comp.trial{1},1)   
      
    % 1 ------------ trials x time ------------%
    
    subplot(6,2,[1 3 5])
    
    trials_ica = zeros(length(comp.trial),size(comp.trial{1},2));
    ntr        = length(comp.trial);
    
    for tr = 1:ntr
        trials_ica(tr,:) = comp.trial{tr}(ic,:);
    end
    
    imagesc(trials_ica)    % x axis: time; y axis: trials
    title('trials x time','FontWeight','bold','FontSize',12)
     
    % 2 ------------- topography -------------%
    
%     subplot(6,2,[2 4 6])
%         
%     topo_ica = comp.topo(:,ic);
%     
%     data2 = davg;
%     data2.avg = repmat(topo_ica,[1 size(davg.avg,2)]);
%     
%     cfg = [];
%     cfg.layout = lay;
%     cfg.figure = 'gca';
% 
%     ft_topoplotER(cfg,data2)    
%     title(['IC #  ' num2str(ic)],'FontWeight','bold','FontSize',16)
%     colorbar
%    
    % 3 -------------  average  --------------%
    
    subplot(6,2,[7 9 11])
    
    avg_ica = mean(trials_ica,1);
    
    plot(comp.time{1},avg_ica)          % independent component average waveform
    set(gca,'XLim',[t1r t2r])
    title('average','FontWeight','bold','FontSize',12)
    set(gca,'YLim',[v1 v2])
    
    % 4 -------------  single trials  --------------% 
 
    tr1=round(ntr/4);    
    tr2=round(2*ntr/4);
    tr3=round(3*ntr/4);
    
    subplot(6,2,8)
    plot(comp.time{1},trials_ica(tr1,:))         
    set(gca,'XLim',[t1 t2])
    title(['trial # ' num2str(tr1)],'FontSize',10)
    
    subplot(6,2,10)
    plot(comp.time{1},trials_ica(tr2,:))
    set(gca,'XLim',[t1 t2])
    title(['trial # ' num2str(tr2)],'FontSize',10)
 
    subplot(6,2,12)
    plot(comp.time{1},trials_ica(tr3,:))
    set(gca,'XLim',[t1 t2])
    title(['trial # ' num2str(tr3)],'FontSize',10)
    

    keydown = waitforbuttonpress;
    value = double(get(gcf,'CurrentCharacter'));
    if (keydown == 0)
        badicas(count)=ic;
        count=count+1;
    elseif value == 28
         disp(value);
         ic = ic-2;
    end
    ic = ic+1; 
end

save badicas badicas

close(clf)



