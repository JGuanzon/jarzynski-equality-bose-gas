%% Prepare Data
close all
clear all

% load data
load('v1.mat')
load('v2.mat')
Tv = 400; 

% Figure settings
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
fs = 9;
colmaps = {[64,42,180]/255,[39,151,235]/255,[114,205,100]/255,[240,186,54]/255};


%% Standard Deviation vs Phi

if true
    % Figure preparation
    figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
    tiledlayout(1,1, 'TileSpacing', 'none', 'Padding', 'none');
    
    nexttile
    hold on
    
    % Linear regression fit
    stdWdTv=[v1stdWFt0,v1stdWFt100,v1stdWRt100,v1stdWRt0,v2stdWFt0,v2stdWFt100,v2stdWRt100,v2stdWRt0]/Tv;
    Pre=[abs(1-v1PFt0./v1dP),abs(1-v1PFt100./v1dP),abs(1-v1PRt100./v1dP),abs(1-v1PRt0./v1dP),abs(1-v2PFt0./v2dP),abs(1-v2PFt100./v2dP),abs(1-v2PRt100./v2dP),abs(1-v2PRt0./v2dP)];
    Pree=[v1PFt0e./v1dP,v1PFt100e./v1dP,v1PRt100e./v1dP,v1PRt0e./v1dP,v2PFt0e./v2dP,v2PFt100e./v2dP,v2PRt100e./v2dP,v2PRt0e./v2dP];
    wtPree = 1./(Pree.^2);
    [p,S] = polyfit(stdWdTv,Pre,1); 
    x = 0:0.1:13; 
    [y_fit,delta] = polyval(p,x,S);
    patch([x fliplr(x)],[y_fit+2*delta fliplr(y_fit-2*delta)],'black','EdgeColor','none','FaceAlpha',0.1)
    axis([0,12,0,0.101])
    annotation('textbox',[0.51 0.1 0.5 0],'String','Fit: $\delta=0.008\beta\sigma-0.013$','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
    set(gca,'FontSize',fs)
    plot(x,y_fit,'k','LineWidth',1)
    xlabel('Standard deviation of work histogram $\beta\sigma$') 
    ylabel('Relative error of free energy $\delta$')
    box on
    
    % Data plot
    errorbar(v1stdWFt0/Tv,abs(1-v1PFt0./v1dP),v1PFt0e./v1dP,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v1stdWFt100/Tv,abs(1-v1PFt100./v1dP),v1PFt100e./v1dP,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v1stdWRt100/Tv,abs(1-v1PRt100./v1dP),v1PRt100e./v1dP,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    errorbar(v1stdWRt0/Tv,abs(1-v1PRt0./v1dP),v1PRt0e./v1dP,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    errorbar(v2stdWFt0/Tv,abs(1-v2PFt0./v2dP),v2PFt0e./v2dP,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v2stdWFt100/Tv,abs(1-v2PFt100./v2dP),v2PFt100e./v2dP,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v2stdWRt100/Tv,abs(1-v2PRt100./v2dP),v2PRt100e./v2dP,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    errorbar(v2stdWRt0/Tv,abs(1-v2PRt0./v2dP),v2PRt0e./v2dP,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    
    print(gcf,'stdvsphi.png','-dpng','-r600'); 
    
    % LogX Plot
    %set(gca, 'XScale', 'log')
    %axis([8*10^(-1),12,0,0.101])
    %print(gcf,'stdvsphi_logx.png','-dpng','-r600'); 
    
    % Log-Log Plot
    %set(gca, 'YScale', 'log', 'XScale', 'log')
    %axis([8*10^(-1),12,10^(-4),10^(-1)])
    %print(gcf,'stdvsphi_logxy.png','-dpng','-r600');    
end

%% Phi and Standard Deviation vs Lam - V1 Harmonic Trap Phi

if false
    % Figure preparation
    figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
    tiledlayout(2,1, 'TileSpacing', 'none', 'Padding', 'none');
    v1sep = 0.011; % Amount of separation between data points
    v1seplam = v1lam(2)-v1lam(1); % Amount of seperation between lambda points
    
    % (a) Summary of Change in Grand Potential (with error)  
    nexttile 
    hold on
    for i = 2:2:4
        patch([v1lam(i)-v1seplam/2 v1lam(i)-v1seplam/2 v1lam(i)+v1seplam/2 v1lam(i)+v1seplam/2],[0.898 1.102 1.102 0.898],'black','EdgeColor','none','FaceAlpha',0.1)    
    end
    for i = 1:4
        patch([v1lam(i)-v1seplam/2 v1lam(i)-v1seplam/2 v1lam(i)+v1seplam/2 v1lam(i)+v1seplam/2],[v1dP(i)-v1dPe(i) v1dP(i)+v1dPe(i) v1dP(i)+v1dPe(i) v1dP(i)-v1dPe(i)]/v1dP(i),colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
    end
    plot([v1lam(1)-v1seplam/2 v1lam(4)+v1seplam/2],[1 1],'-','Color',colmaps{3},'LineWidth',1);
    %p3 = errorbar(v1lam,v1dP./v1dP,v1dPe./v1dP,'.','Color',colmaps{3},'LineWidth',1,'MarkerEdgeColor','none');
    p1 = errorbar(v1lam+v1sep*1.5,v1PFt0./v1dP,v1PFt0e./v1dP,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    p2 = errorbar(v1lam+v1sep*0.5,v1PFt100./v1dP,v1PFt100e./v1dP,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    p4 = errorbar(v1lam-v1sep*0.5,v1PRt100./v1dP,v1PRt100e./v1dP,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    p5 = errorbar(v1lam-v1sep*1.5,v1PRt0./v1dP,v1PRt0e./v1dP,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    ylabel('$\Delta\Phi_{F/R}/\Delta\Phi$')  
    axis([v1lam(1)-v1seplam/2,v1lam(4)+v1seplam/2,0.898,1.102])
    xticklabels({})
    xticks(v1lam-0.025)
    box on
    text(v1lam(1)+v1sep*1.5,1.02,'Fast','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)+v1sep*0.5,1.02,'Slow','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)-v1sep*0.5,1.02,'Slow','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)-v1sep*1.5,1.02,'Fast','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)+v1sep*1.5,0.915,'Forward','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)+v1sep*0.5,0.915,'Forward','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)-v1sep*0.5,0.917,'Reverse','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v1lam(1)-v1sep*1.5,0.917,'Reverse','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    annotation('textbox',[0.175 0.91 0 0],'String','(a)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
    set(gca,'FontSize',fs)
    
    % (b) Work Standard Deviation 
    nexttile 
    hold on 
    for i = 2:2:4
        patch([v1lam(i)-v1seplam/2 v1lam(i)-v1seplam/2 v1lam(i)+v1seplam/2 v1lam(i)+v1seplam/2],[0 15 15 0],'black','EdgeColor','none','FaceAlpha',0.1)
    end
    plot(v1lam+v1sep*1.5,v1stdWFt0/Tv,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    plot(v1lam+v1sep*0.5,v1stdWFt100/Tv,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    plot(v1lam-v1sep*0.5,v1stdWRt100/Tv,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    plot(v1lam-v1sep*1.5,v1stdWRt0/Tv,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    xlabel('Harmonic trap forcing strength $\lambda_f$');
    ylabel('Std. of work histogram $\beta\sigma$') 
    axis([v1lam(1)-v1seplam/2,v1lam(4)+v1seplam/2,0,13])
    xticklabels({'\hspace{6em}$0.05$','\hspace{6em}$0.10$','\hspace{6em}$0.15$','\hspace{6em}$0.20$'})
    xticks(v1lam-0.025)
    box on
    %text(v1lam(1)+v1sep*1.5,v1stdWFt0(1)/Tv+1,'Forward Fast','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    %text(v1lam(1)+v1sep*0.5,v1stdWFt100(1)/Tv+1,'Forward Slow','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    %text(v1lam(1)-v1sep*0.5,v1stdWRt100(1)/Tv+1,'Reverse Slow','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    %text(v1lam(1)-v1sep*1.5,v1stdWRt0(1)/Tv+1,'Reverse Fast','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    annotation('textbox',[0.175 0.465 0 0],'String','(b)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
    set(gca,'FontSize',fs)
    
    print(gcf,'lamvsphistdv1.png','-dpng','-r600');
end


%% Phi and Standard Deviation vs Lam - V2 Pseudo-box Trap Phi

if false
    % Figure preparation
    figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
    tiledlayout(2,1, 'TileSpacing', 'none', 'Padding', 'none');
    v2sep = 0.011*2; % Amount of separation between data points
    v2seplam = v2lam(2)-v2lam(1); % Amount of seperation between lambda points

    % (a) Summary of Change in Grand Potential (with error)  
    nexttile 
    hold on
    for i = 2:2:4
        patch([v2lam(i)-v2seplam/2 v2lam(i)-v2seplam/2 v2lam(i)+v2seplam/2 v2lam(i)+v2seplam/2],[0.898 1.102 1.102 0.898],'black','EdgeColor','none','FaceAlpha',0.1)    
    end
    for i = 1:4
        patch([v2lam(i)-v2seplam/2 v2lam(i)-v2seplam/2 v2lam(i)+v2seplam/2 v2lam(i)+v2seplam/2],[v2dP(i)-v2dPe(i) v2dP(i)+v2dPe(i) v2dP(i)+v2dPe(i) v2dP(i)-v2dPe(i)]/v2dP(i),colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
    end
    plot([v2lam(1)-v2seplam/2 v2lam(4)+v2seplam/2],[1 1],'-','Color',colmaps{3},'LineWidth',1);
    errorbar(v2lam+v2sep*1.5,v2PFt0./v2dP,v2PFt0e./v2dP,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v2lam+v2sep*0.5,v2PFt100./v2dP,v2PFt100e./v2dP,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    errorbar(v2lam-v2sep*0.5,v2PRt100./v2dP,v2PRt100e./v2dP,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    errorbar(v2lam-v2sep*1.5,v2PRt0./v2dP,v2PRt0e./v2dP,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    ylabel('$\Delta\Phi_{F/R}/\Delta\Phi$')  
    axis([v2lam(1)-v2seplam/2,v2lam(4)+v2seplam/2,0.898,1.102])
    xticklabels({})
    xticks(v2lam-v2seplam/2)
    box on
    text(v2lam(1)+v2sep*1.5,1.02,'Fast','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)+v2sep*0.5,1.02,'Slow','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)-v2sep*0.5,1.02,'Slow','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)-v2sep*1.5,1.02,'Fast','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)+v2sep*1.5,0.915,'Forward','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)+v2sep*0.5,0.915,'Forward','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)-v2sep*0.5,0.917,'Reverse','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    text(v2lam(1)-v2sep*1.5,0.917,'Reverse','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    annotation('textbox',[0.175 0.91 0 0],'String','(a)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
    set(gca,'FontSize',fs)
    
    % (b) Work Standard Deviation 
    nexttile 
    hold on 
    for i = 2:2:4
        patch([v2lam(i)-v2seplam/2 v2lam(i)-v2seplam/2 v2lam(i)+v2seplam/2 v2lam(i)+v2seplam/2],[0 15 15 0],'black','EdgeColor','none','FaceAlpha',0.1)
    end
    plot(v2lam+v2sep*1.5,v2stdWFt0/Tv,'o','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    plot(v2lam+v2sep*0.5,v2stdWFt100/Tv,'s','Color',colmaps{4},'LineWidth',1,'MarkerFaceColor',colmaps{4}); 
    plot(v2lam-v2sep*0.5,v2stdWRt100/Tv,'s','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    plot(v2lam-v2sep*1.5,v2stdWRt0/Tv,'o','Color',colmaps{2},'LineWidth',1,'MarkerFaceColor',colmaps{2}); 
    xlabel('Pseudo-box trap forcing strength $\lambda_f$');
    ylabel('Std. of work histogram $\beta\sigma$') 
    axis([v2lam(1)-v2seplam/2,v2lam(4)+v2seplam/2,0,13])
    xticklabels({'\hspace{6em}$0.10$','\hspace{6em}$0.20$','\hspace{6em}$0.30$','\hspace{6em}$0.40$'})
    xticks(v2lam-v2seplam/2)
    box on
    %text(v2lam(1)+v2sep*1.5,v2stdWFt0(1)/Tv+1,'Forward Fast','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    %text(v2lam(1)+v2sep*0.5,v2stdWFt100(1)/Tv+1,'Forward Slow','Rotation',90,'Color',colmaps{4},'Interpreter','Latex','Fontsize',fs);
    %text(v2lam(1)-v2sep*0.5,v2stdWRt100(1)/Tv+1,'Reverse Slow','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    %text(v2lam(1)-v2sep*1.5,v2stdWRt0(1)/Tv+1,'Reverse Fast','Rotation',90,'Color',colmaps{2},'Interpreter','Latex','Fontsize',fs);
    annotation('textbox',[0.175 0.465 0 0],'String','(b)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
    set(gca,'FontSize',fs)
    
    print(gcf,'lamvsphistdv2.png','-dpng','-r600');
end