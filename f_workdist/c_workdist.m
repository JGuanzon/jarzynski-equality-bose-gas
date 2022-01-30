%% Prepare Data
clear all
close all

% Thermodynamic Integration Values 
% dP = [2.34, 4.57, 6.70, 8.75]*10^4; % dPhi: 1 => {1.05,1.10,1.15,1.20}
% dPe = [0.04, 0.06, 0.08, 0.12]*10^4; % dPhi error  
dP = 2.34*10^4;
dPe = 0.04*10^4;

% Calculation from work distribution to phi (free energy) 
W2P = @(W,T) -T*log(mean(exp(-W/T))); %Work to Phi
Tv = 400; 

load(['WF1050t100.mat']); %Forward
WF = Wv; 
PF = W2P(WF,Tv);

load(['WR1050t100.mat']); %Reverse
WR = Wv; 
PR = -W2P(WR,Tv);

% Figure preparation
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
fs = 9;
figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
tiledlayout(2,1, 'TileSpacing', 'none', 'Padding', 'none');
colmaps = {[64,42,180]/255,[39,151,235]/255,[114,205,100]/255,[240,186,54]/255}; 

%% (a) Work Distribution 
nexttile 
hold on
edges = 0.8:0.02:1.2;
ymax = 150;
histogram(-WR/dP,'Normalization','count','FaceColor',colmaps{2},'BinEdges',edges);
histogram(WF/dP,'Normalization','count','FaceColor',colmaps{4},'BinEdges',edges);
plot([PR PR]/dP,[0 ymax],'--','Color',colmaps{2},'LineWidth',1);
plot([PF PF]/dP,[0 ymax],'--','Color',colmaps{4},'LineWidth',1);
plot([dP dP]/dP,[0 ymax],'-','Color',colmaps{3},'LineWidth',1);
patch([dP-dPe dP+dPe dP+dPe dP-dPe]/dP,[0 0 ymax ymax],colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
axis([min(edges),max(edges),0,ymax])
xlabel('Normalised work $w/\Delta\Phi$ histograms', 'Interpreter', 'LaTex') 
ylabel('Count', 'Interpreter', 'LaTex') 
box on
annotation('textbox',[0.165 0.91 0 0],'String','(a)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.46 0.89 0 0],'String','$\Delta\Phi_R/\Delta\Phi$','Color',colmaps{2},'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.65 0.89 0 0],'String','$\Delta\Phi_F/\Delta\Phi$','Color',colmaps{4},'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.28 0.74 0 0],'String','Reverse distribution $\rho_R(-w)$','Color',colmaps{2},'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.84 0.74 0 0],'String','Forward distribution $\rho_F(w)$','Color',colmaps{4},'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
set(gca,'FontSize',fs)

%% (b) Exponential Work Distribution 
nexttile 
hold on

edges = (0.0:0.1:2)*10^(-25);
ymax = 400;
histogram(exp(-WF/Tv),'Normalization','count','FaceColor',colmaps{4},'BinEdges',edges)
f=exp(-dP/Tv);
df=1/Tv*exp(-dP/Tv)*dPe;
plot([f f],[0 190],'-','Color',colmaps{3},'LineWidth',1)
pltx = plot([f f],[190 310],'-','Color',colmaps{3},'LineWidth',1);
pltx.Color = [pltx.Color 0.2];
plot([f f],[310 ymax],'-','Color',colmaps{3},'LineWidth',1)
patch([f-df f+df f+df f-df],[0 0 ymax ymax],colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
plot(exp(-[PF PF]/Tv),[0 ymax],'--','Color',colmaps{4},'LineWidth',1)
axis([min(edges),max(edges),0,ymax])
xlabel('Exponential work $e^{-\beta w}$ histogram', 'Interpreter', 'LaTex') 
ylabel('Count', 'Interpreter', 'LaTex') 
box on
annotation('textbox',[0.165 0.405 0 0],'String','(b)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.25 0.19 0.4 0.3],'String','Mean value $\langle e^{-\beta w} \rangle = e^{-\beta \Delta \Phi_F}$','Color',colmaps{4},'Interpreter','Latex','HorizontalAlignment','Left','VerticalAlignment','Middle','Edgecolor','none','Fontsize',fs,'FitBoxToText','off');
set(gca,'FontSize',fs)

print(gcf,'workdist.png','-dpng','-r600'); 