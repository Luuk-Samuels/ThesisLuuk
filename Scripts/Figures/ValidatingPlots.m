clearvars -except af af2
close all force
if exist('af','var') == 0        %check whether a is already in workspace 
    load('DataSetf.mat','af');    %if not in workspace load a
end

%% This plot is used to create Fig. S21.

% To run it, DataSetf.mat and Data.m are needed .

%figure 1: DD, figure 2:FD, figure 3: concatenation

[Dink1,ii1] = unique(af(50304).Din);
[Dink2,ii2] = unique(af(49254).Din);
[Dink3,ii3] = unique(af(50838).Din);

Doutk1 = af(50304).Dout(ii1);
Doutk2 = af(49254).Dout(ii2);
Doutk3 = af(50838).Dout(ii3);

Fink1 = af(50304).Fin(ii1);
Fink2 = af(49254).Fin(ii2);
Fink3 = af(50838).Fin(ii3);

% figure(1);
figure('Position', [0 0 1300 800])
t1 = tiledlayout(2,3,...
    'Padding','compact',...
    'tilespacing','compact');
nexttile
hold on
title('displacement relation')
plot(Dink1,Doutk1,'Color',1/256*[0, 255, 64]);
plot(Dink2,Doutk2,'Color',1/256*[0, 64, 255]);
plot(Dink3,Doutk3,'Color',1/256*[255, 191, 0]);
fplot(@(t) 4e3*(cosh(t)-1),[-1e-3, 1e-3],'color','k','linestyle','--')

xlabel('u_{in} [m]');
ylabel('u_{out} [m]');

lgd = legend('best load capacity','best sinusoidal','best overall','ideal sinusoidal');
% lgd.Title.String = 'best force capacity';
lgd.Location = 'north';

xlim([-1e-3,1e-3]);
set(gca,'fontsize',14);

% NumTicks = 5;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% 
% NumTicks = 6;
% %             L = get(gca,'YLim');
% set(gca,'YTick',linspace(0, 2.5e-3,NumTicks))

% figure(2);
nexttile
hold on
title('force-displacement')

plot(Dink1,Fink1,'Color',1/256*[0, 255, 64]);
plot(Dink2,Fink2,'Color',1/256*[0, 64, 255]);
plot(Dink3,Fink3,'Color',1/256*[255, 191, 0]);

xlabel('u_{in} [m]');
ylabel('F_{in} [N]');
% lgd = legend('simulation', 'experimental TBD');
% lgd.Title.String = 'best force capacity';
% lgd.Location = 'northwest';

set(gca,'fontsize',14);
xlim([-1e-3,1e-3]);
% ylim([-1.5 1.5]);
            
% NumTicks = 5;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% 
% NumTicks = 7;
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))
set(gca,'fontsize',14);
% figure(3);
nexttile
hold on;

concat(af(50304),1e-3,2,1/256*[0, 255, 64]);
concat(af(49254),1e-3,2,1/256*[0, 64, 255]);
concat(af(50838),1e-3,2,1/256*[255, 191, 0]);
hline = findobj(gcf, 'type', 'line');
% set(hline(end-2),'color',1/256*[0, 64, 255],'Linewidth',1);
% set(hline(end-1),'color',1/256*[0, 255, 64],'Linewidth',1);
% set(hline(end),'color',1/256*[255, 191, 0],'Linewidth',1);

fplot(@(t) 1e-3+1e-3*cos(4*t*2*pi),[0 1],'color','k','linestyle','--')
title('2 concatenations');

% export_fig('..\..\Writing\Images Paper\validation','-pdf','-transparent')
set(gca,'fontsize',14);



nexttile
hold on;

concat(af(50304),1e-3,3,1/256*[0, 255, 64]);
concat(af(49254),1e-3,3,1/256*[0, 64, 255]);
concat(af(50838),1e-3,3,1/256*[255, 191, 0]);
hline = findobj(gcf, 'type', 'line');
% set(hline(end-2),'color',1/256*[0, 64, 255],'Linewidth',1);
% set(hline(end-1),'color',1/256*[0, 255, 64],'Linewidth',1);
% set(hline(end),'color',1/256*[255, 191, 0],'Linewidth',1);

fplot(@(t) 1e-3+1e-3*cos(8*t*2*pi),[0 1],'color','k','linestyle','--')
title('3 concatenations');
set(gca,'fontsize',14);
xlim([0 0.5])


nexttile
hold on;

concat(af(50304),1e-3,4,1/256*[0, 255, 64]);
concat(af(49254),1e-3,4,1/256*[0, 64, 255]);
concat(af(50838),1e-3,4,1/256*[255, 191, 0]);
hline = findobj(gcf, 'type', 'line');
% set(hline(end-2),'color',1/256*[0, 64, 255],'Linewidth',1);
% set(hline(end-1),'color',1/256*[0, 255, 64],'Linewidth',1);
% set(hline(end),'color',1/256*[255, 191, 0],'Linewidth',1);

fplot(@(t) 1e-3+1e-3*cos(16*t*2*pi),[0 1],'color','k','linestyle','--')
title('4 concatenations')
set(gca,'fontsize',14);
xlim([0 0.25])



nexttile
hold on;

concat(af(50304),1e-3,5,1/256*[0, 255, 64]);
concat(af(49254),1e-3,5,1/256*[0, 64, 255]);
concat(af(50838),1e-3,5,1/256*[255, 191, 0]);
hline = findobj(gcf, 'type', 'line');
% set(hline(end-2),'color',1/256*[0, 64, 255],'Linewidth',1);
% set(hline(end-1),'color',1/256*[0, 255, 64],'Linewidth',1);
% set(hline(end),'color',1/256*[255, 191, 0],'Linewidth',1);
title('5 concatenations')
set(gca,'fontsize',14);
fplot(@(t) 1e-3+1e-3*cos(32*t*2*pi),[0 1],'color','k','linestyle','--')
xlim([0 0.125])

%export_fig('..\..\Writing\Images Supplemental\concatenations','-pdf','-transparent')