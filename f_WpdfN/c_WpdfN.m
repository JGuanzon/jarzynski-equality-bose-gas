%% Prepare Data for fast and large work process using V2
clear all
close all

% Calculate free energy
Tv = 400; 
W2O = @(W,T) -T*log(nanmean(exp(-W/T)));
dP = 4.55*10^4; % Phi free energy
dPe = 0.05*10^4; % Phi error
Nr = 2.32; % N restriction 
Nre = 0.05; % N restriction range [Nr-Nre,Nr+Nre]

% (a) & (b) ordinary work processes 
load('WF56t0.mat'); %Forward
WF56t0 = Winsv; 
NF56t0 = Nv*10^(-4); 
O56t0F = W2O(WF56t0,Tv);
load('WR56t0.mat'); %Reverse
WR56t0 = Winsv; 
NR56t0 = Nv*10^(-4);
O56t0R = -W2O(WR56t0,Tv);

% (c) N restrictioned work proccess
load('WF56t0N.mat'); %Forward
WF56t0N = Winsv; 
NF56t0N = Nv*10^(-4); 
O56t0FN = W2O(WF56t0N,Tv);
load('WR56t0N.mat'); %Reverse
WR56t0N = Winsv; 
NR56t0N = Nv*10^(-4);
O56t0RN = -W2O(WR56t0N,Tv);

% Figure setting
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');  
fs = 9;
figure('DefaultAxesFontSize', fs, 'Units', 'Centimeters', 'Position', [0, 0, 8.5, 8.5], 'PaperUnits', 'Centimeters', 'PaperPosition', [0, 0, 8.5, 8.5])
colmaps = {[64,42,180]/255,[39,151,235]/255,[114,205,100]/255,[240,186,54]/255};


%% (a) Plot PDF(w,N)

% Plot grid parameters
edges = 0.8-1/30:1/30:1.3+1/30;
Nedges = 1.643:0.15:3.143;

% Blue color map
bcol = colmaps{2}; 
bmap = []; 
for i = 40:-1:0
    bmap = [bmap; ones(1,3).*(bcol-(bcol-ones(1,3))*i/50)]; 
end
% Reverse Blue 2D Histogram
ax1 = axes;
hold on
histogram2(-WR56t0/dP,NR56t0,'FaceColor','flat','EdgeColor','none','FaceAlpha',0.9,'XBinEdges',edges,'YBinEdges',Nedges);  
ylabel('\ Particle number $N$\ $\times10^4$', 'Interpreter', 'LaTex') 
axis([min(edges),max(edges),min(Nedges),max(Nedges)])
xticklabels({})
colormap(ax1,bmap)
caxis([0,70])
box on

% Yellow color map
ycol = colmaps{4}; 
ymap = []; 
for i = 40:-1:0
    ymap = [ymap; ones(1,3).*(ycol-(ycol-ones(1,3))*i/50)]; 
end
% Forward Yellow 2D Histogram
ax2 = axes;
hold on
histogram2(WF56t0/dP,NF56t0,'FaceColor','flat','EdgeColor','none','FaceAlpha',0.9,'XBinEdges',edges,'YBinEdges',Nedges); 
axis([min(edges),max(edges),min(Nedges),max(Nedges)])
colormap(ax2,ymap) 
caxis([0,70])
box on

% Other lines/regions
axb = axes; 
hold on
plot([dP dP]/dP,[min(Nedges) max(Nedges)],'-','Color',colmaps{3},'LineWidth',1)
patch([dP-dPe dP+dPe dP+dPe dP-dPe]/dP,[min(Nedges) min(Nedges) max(Nedges) max(Nedges)],colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
patch([min(edges) max(edges) max(edges) min(edges)],[Nr-Nre Nr-Nre Nr+Nre Nr+Nre],colmaps{1},'EdgeColor','none','FaceAlpha',0.2)
plot([O56t0R O56t0R]/dP,[min(Nedges) max(Nedges)],'--','Color',colmaps{2},'LineWidth',1)
plot([O56t0F O56t0F]/dP,[min(Nedges) max(Nedges)],'--','Color',colmaps{4},'LineWidth',1)
text(1.32,Nr-3*Nre,'$N_s$','Rotation',0,'Color',colmaps{1},'Interpreter','Latex','HorizontalAlignment','Right','Fontsize',fs);
axis([min(edges),max(edges),min(Nedges),max(Nedges)])
box on

% Stitch together axes
linkaxes([ax1,ax2,axb])

axb.Visible = 'off';
axb.XTick = [];
axb.YTick = [];
axb.Position = ax1.Position; 
axb.XLim = ax1.XLim; 
axb.YLim = ax1.YLim; 
axb.XAxis.Visible = 'off';

ax2.Visible = 'off';
ax2.XTick = [];
ax2.YTick = [];
ax2.ZTick = [];
ax2.Position = ax1.Position; 
ax2.XLim = ax1.XLim; 
ax2.YLim = ax1.YLim; 
ax2.XAxis.Visible = 'off'; 

set([ax1,ax2,axb],'Position',[.13 .54 .75 .447],'Fontsize',fs);
cb1 = colorbar(ax1,'Position',[.895 .54 .025 .447], 'TickLabels', []);
cb2 = colorbar(ax2,'Position',[.92 .54 .025 .447], 'TickLabelInterpreter', 'LaTex');


%% (b) Ordinary Work 1D Histogram

ax3 = axes;
hold on
ymax = 225;
histogram(-WR56t0/dP,'Normalization','count','FaceColor',colmaps{2},'BinEdges',edges)
histogram(WF56t0/dP,'Normalization','count','FaceColor',colmaps{4},'BinEdges',edges)
plot([dP dP]/dP,[0 ymax],'-','Color',colmaps{3},'LineWidth',1)
patch([dP-dPe dP+dPe dP+dPe dP-dPe]/dP,[0 0 ymax ymax],colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
plot([O56t0R O56t0R]/dP,[0 ymax],'--','Color',colmaps{2},'LineWidth',1)
plot([O56t0F O56t0F]/dP,[0 ymax],'--','Color',colmaps{4},'LineWidth',1)
axis([min(edges),max(edges),0,ymax])
xticklabels({})
text(1.32,180,'Unstratified','Rotation',0,'Color','k','Interpreter','Latex','HorizontalAlignment','Right','Fontsize',fs);
ylabel('Count', 'Interpreter', 'LaTex') 
set(ax3,'Position',[.13 .325 .75 .20],'Fontsize',fs);
box on


%% (c) N Constrained Work 1D Histogram

ax4 = axes;
hold on
histogram(-WR56t0N/dP,'Normalization','count','FaceColor',colmaps{2},'BinEdges',edges)
histogram(WF56t0N/dP,'Normalization','count','FaceColor',colmaps{4},'BinEdges',edges)
plot([dP dP]/dP,[0 ymax],'-','Color',colmaps{3},'LineWidth',1)
patch([dP-dPe dP+dPe dP+dPe dP-dPe]/dP,[0 0 ymax ymax],colmaps{3},'EdgeColor','none','FaceAlpha',0.2)
plot([O56t0RN O56t0RN]/dP,[0 ymax],'--','Color',colmaps{2},'LineWidth',1)
plot([O56t0FN O56t0FN]/dP,[0 ymax],'--','Color',colmaps{4},'LineWidth',1)
axis([min(edges),max(edges),0,ymax])
text(1.32,180,'$N_s$ stratified','Rotation',0,'Color',colmaps{1},'Interpreter','Latex','HorizontalAlignment','Right','Fontsize',fs);
xlabel('Normalised work $w/\Delta\Phi$ histograms', 'Interpreter', 'LaTex') 
ylabel('Count', 'Interpreter', 'LaTex') 
set(ax4,'Position',[.13 .11 .75 .20],'Fontsize',fs);
box on 


%% Finalise figure annotation and save
annotation('textbox',[0.943 0.465 0 0],'String','Count','Color','k','Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.17 0.908 0 0],'String','(a)','Color','k','Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.17 0.445 0 0],'String','(b)','Color','k','Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
annotation('textbox',[0.17 0.23 0 0],'String','(c)','Color','k','Interpreter','Latex','HorizontalAlignment','Center','VerticalAlignment','Bottom','Edgecolor','none','Fontsize',fs);
   
print(gcf,'WpdfN.png','-dpng','-r600');   
