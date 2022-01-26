%% Prepare Data
close all
clear all

% Time series data 
load('W100D_ADws_observables.mat','t','N','E','E1','E2','E3'); 
tend = 666; % Plot to this index value

% Figure preparation
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');
fs = 9;
figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
tiledlayout(2,1, 'TileSpacing', 'none', 'Padding', 'none');
colmaps = {[64,42,180]/255,[39,151,235]/255,[114,205,100]/255,[240,186,54]/255}; 

%% Plot N vs t
nexttile 

hold on  
plot(t(1:tend),N(1:tend)*10^(-4),'Color',colmaps{4},'LineWidth',2)
plot(t(tend/2:tend),ones(1,tend/2+1)*mean(N(tend/2:tend))*10^(-4),'--','Color',[0,0,0],'LineWidth',1)
xticklabels({})
ylabel('\ Particle number $N$\ $\times10^4$','Interpreter','LaTex')  
axis([0 200 0 4]) 
box on
annotation('textbox',[0.13 0.905 0 0],'String','(a)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
set(gca,'FontSize',fs)

%% Plot E vs t
nexttile

hold on
plot(t(1:tend),E(1:tend)*10^(-5),'Color',colmaps{4},'LineWidth',2)
plot(t(1:tend),real(E1(1:tend))*10^(-5),'Color',colmaps{3},'LineWidth',2)
plot(t(1:tend),E3(1:tend)*10^(-5),'Color',colmaps{2},'LineWidth',2)
plot(t(1:tend),E2(1:tend)*10^(-5),'Color',colmaps{1},'LineWidth',2)
plot(t(tend/2:tend),ones(1,tend/2+1)*mean(E(tend/2:tend))*10^(-5),'--','Color',[0,0,0],'LineWidth',1)
xlabel('Time $t$ ($\omega_0^{-1}$)','Interpreter','LaTex') 
ylabel('\quad Energy ($\hbar\omega_0$)\quad$\times10^5$','Interpreter','LaTex')  
axis([0 200 0 6.5]) 
box on
annotation('textbox',[0.13 0.46 0 0],'String','(b)','Color',[0,0,0],'Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.98 0.39 0 0],'String','Total','Color',colmaps{4},'Interpreter','Latex','HorizontalAlignment','Right','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.98 0.26 0 0],'String','Potential','Color',colmaps{2},'Interpreter','Latex','HorizontalAlignment','Right','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.98 0.18 0 0],'String','Kinetic','Color',colmaps{3},'Interpreter','Latex','HorizontalAlignment','Right','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.98 0.10 0 0],'String','Interaction','Color',colmaps{1},'Interpreter','Latex','HorizontalAlignment','Right','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
set(gca,'FontSize',fs)

print(gcf,'NEvst.png','-dpng','-r600'); 