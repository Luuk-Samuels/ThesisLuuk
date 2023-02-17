%% initial 
clearvars -except af
close all force
if exist('af','var') == 0        %check whether a is already in workspace 
%     load('DataSetTPUp.mat','aTPUp');    %if not in workspace load aTPUp
    load('DataSetf.mat','af');
end

%% Running this file gives the results of the plots used for Fig. 4. in the paper
% and Fig. S16. in supplementary material. 

%Initializing array, to be filled with [Par1, Par2, Value]
z1 = [0 0 0];
z2 = [0 0 0];
z3 = [0 0 0];

z4 = [0 0 0];
z5 = [0 0 0];
z6 = [0 0 0];

z7 = [0 0 0];
z8 = [0 0 0];
z9 = [0 0 0];

z10 = [0 0 0];
z11 = [0 0 0];
z12 = [0 0 0];


%might have to select the best value here to plot
for i=1:12541   %Only on initial analysis range 1:12541
%     if aTPUp(i).GA  >= 1.8 && aTPUp(i).GA <= 2.2
        if ~ismember([af(i).L11, af(i).L33], z1(:,1:2),'rows')
            z1(end+1, :) = [af(i).L11, af(i).L33, af(i).Sin];
        else
            [indx, indy] = ismember([af(i).L11, af(i).L33], z1(:,1:2),'rows');
            if z1(indy,3) > af(i).Sin || isnan(z1(indy,3)) 
                z1(indy,3) = af(i).Sin;
            end
        end
        if ~ismember([af(i).L11, af(i).Alpha], z2(:,1:2),'rows')
            z2(end+1, :) = [af(i).L11, af(i).Alpha, af(i).Sin];
        else
            [indx, indy] = ismember([af(i).L11, af(i).Alpha], z2(:,1:2),'rows');
            if z2(indy,3) > af(i).Sin || isnan(z2(indy,3)) 
                z2(indy,3) = af(i).Sin;
            end
        end
        if ~ismember([af(i).L11, af(i).Llif], z3(:,1:2),'rows')
            z3(end+1, :) = [af(i).L11, af(i).Llif, af(i).Sin];
        else
            [indx, indy] = ismember([af(i).L11, af(i).Llif], z3(:,1:2),'rows');
            if z3(indy,3) > af(i).Sin || isnan(z3(indy,3)) 
                z3(indy,3) = af(i).Sin;
            end
        end
        
        if af(i).Llif >= 20      %to filter all the high load capacities due to small leaf flexures
            if ~ismember([af(i).L11, af(i).L33], z4(:,1:2),'rows')
                z4(end+1, :) = [af(i).L11, af(i).L33, af(i).LoadMin];
            else
                [indx, indy] = ismember([af(i).L11, af(i).L33], z4(:,1:2),'rows');
                if z4(indy,3) < af(i).LoadMin || isnan(z4(indy,3)) 
                    z4(indy,3) = af(i).LoadMin;
                end
            end
            if ~ismember([af(i).L11, af(i).Alpha], z5(:,1:2),'rows')
                z5(end+1, :) = [af(i).L11, af(i).Alpha, af(i).LoadMin];
            else
                [indx, indy] = ismember([af(i).L11, af(i).Alpha], z5(:,1:2),'rows');
                if z5(indy,3) < af(i).LoadMin || isnan(z5(indy,3)) 
                    z5(indy,3) = af(i).LoadMin;
                end
            end
            if ~ismember([af(i).L11, af(i).Llif], z6(:,1:2),'rows')
                z6(end+1, :) = [af(i).L11, af(i).Llif, af(i).LoadMin];
            else
                [indx, indy] = ismember([af(i).L11, af(i).Llif], z6(:,1:2),'rows');
                if z6(indy,3) < af(i).LoadMin || isnan(z6(indy,3)) 
                    z6(indy,3) = af(i).LoadMin;
                end
            end
        end
        
        if ~ismember([af(i).L11, af(i).L33], z7(:,1:2),'rows')
            z7(end+1, :) = [af(i).L11, af(i).L33, abs(af(i).GA-2)];
        else
            [indx, indy] = ismember([af(i).L11, af(i).L33], z7(:,1:2),'rows');
            if z7(indy,3) > abs(af(i).GA-2) || isnan(z7(indy,3)) 
                z7(indy,3) = abs(af(i).GA-2);
            end
        end
        if ~ismember([af(i).L11, af(i).Alpha], z8(:,1:2),'rows')
            z8(end+1, :) = [af(i).L11, af(i).Alpha, abs(af(i).GA-2)];
        else
            [indx, indy] = ismember([af(i).L11, af(i).Alpha], z8(:,1:2),'rows');
            if z8(indy,3) > abs(af(i).GA-2) || isnan(z8(indy,3)) 
                z8(indy,3) = abs(af(i).GA-2);
            end
        end
        if ~ismember([af(i).L11, af(i).Llif], z9(:,1:2),'rows')
            z9(end+1, :) = [af(i).L11, af(i).Llif, abs(af(i).GA-2)];
        else
            [indx, indy] = ismember([af(i).L11, af(i).Llif], z9(:,1:2),'rows');
            if z9(indy,3) > abs(af(i).GA-2) || isnan(z9(indy,3)) 
                z9(indy,3) = abs(af(i).GA-2);
            end
        end
        
        if af(i).Llif >= 5      %to filter all the high load capacities due to small leaf flexures
            if ~ismember([af(i).L11, af(i).L33], z10(:,1:2),'rows')
                z10(end+1, :) = [af(i).L11, af(i).L33, af(i).LoadMinD];
            else
                [indx, indy] = ismember([af(i).L11, af(i).L33], z10(:,1:2),'rows');
                if z10(indy,3) < af(i).LoadMinD || isnan(z10(indy,3)) 
                    z10(indy,3) = af(i).LoadMinD;
                end
            end
            if ~ismember([af(i).L11, af(i).Alpha], z11(:,1:2),'rows')
                z11(end+1, :) = [af(i).L11, af(i).Alpha, af(i).LoadMinD];
            else
                [indx, indy] = ismember([af(i).L11, af(i).Alpha], z11(:,1:2),'rows');
                if z11(indy,3) < af(i).LoadMinD || isnan(z11(indy,3)) 
                    z11(indy,3) = af(i).LoadMinD;
                end
            end
            if ~ismember([af(i).L11, af(i).Llif], z12(:,1:2),'rows')
                z12(end+1, :) = [af(i).L11, af(i).Llif, af(i).LoadMinD];
            else
                [indx, indy] = ismember([af(i).L11, af(i).Llif], z12(:,1:2),'rows');
                if z12(indy,3) < af(i).LoadMinD || isnan(z12(indy,3)) 
                    z12(indy,3) = af(i).LoadMinD;
                end
            end
        end
%         if ~ismember([af(i).L11, af(i).L33], z4(:,1:2),'rows')
%             z4(end+1, :) = [aTPUp(i).L11, aTPUp(i).L33, aTPUp(i).LoadMin];
%         else
%             [indx, indy] = ismember([aTPUp(i).L11, aTPUp(i).L33], z4(:,1:2),'rows');
%             if z4(indy,3) < aTPUp(i).LoadMin || isnan(z4(indy,3)) 
%                 z4(indy,3) = aTPUp(i).LoadMin;
%             end
%         end
%         if ~ismember([aTPUp(i).Alpha, aTPUp(i).Llif], z3(:,1:2),'rows')
%             z3(end+1, :) = [aTPUp(i).Alpha, aTPUp(i).Llif, aTPUp(i).LoadMin];
%         else
%             [indx, indy] = ismember([aTPUp(i).Alpha, aTPUp(i).Llif], z3(:,1:2),'rows');
%             if z3(indy,3) < aTPUp(i).LoadMin || isnan(z3(indy,3)) 
%                 z3(indy,3) = aTPUp(i).LoadMin;
%             end
%         end
%         if ~ismember([aTPUp(i).L11, aTPUp(i).L33], z6(:,1:2),'rows')
%             z6(end+1, :) = [aTPUp(i).L11, aTPUp(i).L33, aTPUp(i).GA];
%         else
%             [indx, indy] = ismember([aTPUp(i).L11, aTPUp(i).L33], z6(:,1:2),'rows');
%             if abs(z6(indy,3)-2) > abs(aTPUp(i).GA-2) || isnan(z6(indy,3)) 
%                 z6(indy,3) = aTPUp(i).GA;
%             end
%         end
%         if ~ismember([aTPUp(i).Alpha, aTPUp(i).Llif], z5(:,1:2),'rows')
%             z5(end+1, :) = [aTPUp(i).Alpha, aTPUp(i).Llif, aTPUp(i).GA];
%         else
%             [indx, indy] = ismember([aTPUp(i).Alpha, aTPUp(i).Llif], z5(:,1:2),'rows');
%             if abs(z5(indy,3)-2) > abs(aTPUp(i).GA-2) || isnan(z5(indy,3)) 
%                 z5(indy,3) = aTPUp(i).GA;
%             end
%         end
%     end
end

%remove all 0 values, by turning into NaN
z1(z1==0) = nan;
z2(z2==0) = nan;
z3(z3 ==0) = nan;

z4(z4 == 0) = nan;
z5(z5 == 0) = nan;
z6(z6 == 0) = nan;

z7(z7 == 0) = nan;
z8(z8 == 0) = nan;
z9(z9 == 0) = nan;

z10(z10 == 0) = nan;
z11(z11 == 0) = nan;
z12(z12 == 0) = nan;
%initial values
Alpha = 10:10:50; %angle
Llif = 10:5:100; %length flexures
L11 = 15:5:70; %width rigid part
L33 = 20:5:70; %mm 8.6, height difference input/output

%initializing arrays to be filled with data...
%Lengths are corresponding to number of points where the values for parameters are known
sq1 = zeros(length(L33),length(L11)); 
sq2 = zeros(length(Alpha),length(L11));
sq3 = zeros(length(Llif),length(L11));

sq4 = zeros(length(L33),length(L11)); 
sq5 = zeros(length(Alpha),length(L11));
sq6 = zeros(length(Llif),length(L11));

sq7 = zeros(length(L33),length(L11)); 
sq8 = zeros(length(Alpha),length(L11));
sq9 = zeros(length(Llif),length(L11));

sq10 = zeros(length(L33),length(L11)); 
sq11 = zeros(length(Alpha),length(L11));
sq12 = zeros(length(Llif),length(L11));
%loop over 
for i = 1:length(z1)    
    i1 = find(z1(i,1) == L11,1);
    i2 = find(z1(i,2) == L33,1);
    sq1(i2,i1) = z1(i,3);
end
for i = 1:length(z2)
    i1 = find(z2(i,1) == L11,1);
    i2 = find(z2(i,2) == Alpha,1);
    sq2(i2,i1) = z2(i,3);
end
for i = 1:length(z3)
    i1 = find(z3(i,1) == L11,1);
    i2 = find(z3(i,2) == Llif,1);
    sq3(i2,i1) = z3(i,3);
end

for i = 1:length(z4)    
    i1 = find(z4(i,1) == L11,1);
    i2 = find(z4(i,2) == L33,1);
    sq4(i2,i1) = z4(i,3);
end
for i = 1:length(z5)
    i1 = find(z5(i,1) == L11,1);
    i2 = find(z5(i,2) == Alpha,1);
    sq5(i2,i1) = z5(i,3);
end
for i = 1:length(z6)
    i1 = find(z6(i,1) == L11,1);
    i2 = find(z6(i,2) == Llif,1);
    sq6(i2,i1) = z6(i,3);
end

for i = 1:length(z7)    
    i1 = find(z7(i,1) == L11,1);
    i2 = find(z7(i,2) == L33,1);
    sq7(i2,i1) = z7(i,3);
end
for i = 1:length(z8)
    i1 = find(z8(i,1) == L11,1);
    i2 = find(z8(i,2) == Alpha,1);
    sq8(i2,i1) = z8(i,3);
end
for i = 1:length(z9)
    i1 = find(z9(i,1) == L11,1);
    i2 = find(z9(i,2) == Llif,1);
    sq9(i2,i1) = z9(i,3);
end

for i = 1:length(z10)    
    i1 = find(z10(i,1) == L11,1);
    i2 = find(z10(i,2) == L33,1);
    sq10(i2,i1) = z10(i,3);
end
for i = 1:length(z11)
    i1 = find(z11(i,1) == L11,1);
    i2 = find(z11(i,2) == Alpha,1);
    sq11(i2,i1) = z11(i,3);
end
for i = 1:length(z12)
    i1 = find(z12(i,1) == L11,1);
    i2 = find(z12(i,2) == Llif,1);
    sq12(i2,i1) = z12(i,3);
end
sq4(sq4==0) = nan;
sq5(sq5==0) = nan;
sq6(sq6==0) = nan;

sq10(sq10==0) = nan;
sq11(sq11==0) = nan;
sq12(sq12==0) = nan;
%% Sinusoidal error, L11-L33

figure('Position', [0 0 1300 400])
t1 = tiledlayout(1,3,...
    'Padding','compact',...
    'tilespacing','compact');
title(t1, 'sinusoidality error','FontWeight','bold','FontSize',14);

h1(1) = nexttile(t1);

clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[L33(1) L33(end)],sq1,'AlphaData',~isnan(sq1));
set(gca,'color',0.6*[1 1 1]); %Make white areas grey
set(gca,'YDir','normal');   %Make ydirection normal (down to up)
set(gca,'ColorScale','log')

set(gca,'fontsize',14);
colormap(turbo);

% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('sinusoidality error');
xlabel('l_1 [-]');
ylabel('l_2 [-]');

% c.Label.String = 'Sinusoidal SSE';
% c.Label.FontSize = 12;

%% Sinusoidal error, L11-Alpha
% figure(4);
h1(2) = nexttile(t1);

imagesc([L11(1) L11(end)],[Alpha(1) Alpha(end)],sq2,'AlphaData',~isnan(sq2));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
set(gca,'ColorScale','log')
% caxis([0 0.015])
% B = jet(10);
colormap(turbo);
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('sinusoidality error');
xlabel('l_1 [-]');
ylabel('\alpha [\circ]');

% c.Label.String = 'Sinusoidal SSE';
% c.Label.FontSize = 12;

%% Sinusoidal error, L11-Llif
% figure(5);

h1(3) = nexttile(t1);
clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[Llif(1) Llif(end)],sq3,'AlphaData',~isnan(sq3));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
set(gca,'ColorScale','log')
colormap(turbo);
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);


% title('sinusoidality error');
xlabel('l_1 [-]');
y = ylabel('l [-]');
y.Position(1) = y.Position(1)+abs(y.Position(1)*0.25);

% c.Label.String = 'Sinusoidal SSE';
% c.Label.FontSize = 12;

%% fix tiled layout 1

set(h1, 'Colormap', jet, 'CLim', [min(sq3,[],'all') max(sq3,[],'all')]);
cbh1 = colorbar(h1(end)); 

cbh1.Layout.Tile = 'east';
cbh1.Label.String = 'sinusoidality NSSE [-]';
cbh1.Label.FontSize = 14;
set(gca,'ColorScale','log')
brighten(0.2); %to make the plot less vibrant
set(gca,'fontsize',14);
set(gcf,'color','w');
drawnow;
pause(0.3)
% export_fig('..\..\Writing\Images Paper\sinusoidalityf','-pdf','-painters')

%% Load Capacity, L11-L33
figure('Position', [0 0 1300 400])
t2 = tiledlayout(1,3,...
    'Padding','compact',...
    'tilespacing','compact');
title(t2, 'load capacity','FontWeight','bold','FontSize',14);

% figure(6);
h2(1) = nexttile(t2);

pbaspect(h2(1),[4 3 3])
clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[L33(1) L33(end)],sq4,'AlphaData',~isnan(sq4));
set(gca,'color',0.6*[1 1 1]); %Make white areas grey
set(gca,'YDir','normal');   %Make ydirection normal (down to up)
set(gca,'fontsize',14);
colormap(flipud(turbo));

% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('load capacity');
xlabel('l_1 [-]');
ylabel('l_2 [-]');

% c.Label.String = 'Load Capacity';
% c.Label.FontSize = 12;

%% Load capacity, L11-Alpha
% figure(7);
h2(2) = nexttile(t2);
pbaspect(h2(2),[4 3 3])
imagesc([L11(1) L11(end)],[Alpha(1) Alpha(end)],sq5,'AlphaData',~isnan(sq5));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
% caxis([0 0.015])
% B = jet(10);
colormap(flipud(turbo));
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('load capacity');
xlabel('l_1 [-]');
ylabel('\alpha [\circ]');

% c.Label.String = 'Load Capacity';
% c.Label.FontSize = 12;

%% Load Capacity, L11-Llif
% figure(8);
h2(3) = nexttile(t2);
pbaspect(h2(3),[4 3 3])
clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[Llif(1) Llif(end)],sq6,'AlphaData',~isnan(sq6));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
colormap(flipud(turbo));
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);


% title('load capacity');
xlabel('l_1 [-]');
y = ylabel('l [-]');
y.Position(1) = y.Position(1)+abs(y.Position(1)*0.25);

% c.Label.String = 'Load Capacity';
% c.Label.FontSize = 12;

%% fix tiled layout 2

set(h2, 'Colormap', flipud(jet), 'CLim', [min(sq6,[],'all') max(sq6,[],'all')]);
cbh2 = colorbar(h2(end)); 

cbh2.Layout.Tile = 'east';
cbh2.Label.String = 'load capacity: min(Fi,Fo) [N]';
cbh2.Label.FontSize = 14;
brighten(0.2);
set(gca,'fontsize',14);
set(gcf,'color','w');
% export_fig('..\..\Writing\Images Paper\loadcapacityf','-pdf','-painters')
%% GA, L11-L33

figure('Position', [0 0 1300 400])
t3 = tiledlayout(1,3,...
    'Padding','compact',...
    'tilespacing','compact');
title(t3, 'geometrical advantage','FontWeight','bold','FontSize',14);
% figure(9);

h3(1) = nexttile(t3);

clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[L33(1) L33(end)],sq7,'AlphaData',~isnan(sq7));
set(gca,'color',0.6*[1 1 1]); %Make white areas grey
set(gca,'YDir','normal');   %Make ydirection normal (down to up)
set(gca,'fontsize',14);
colormap(turbo);

% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('geometrical advantage');
xlabel('l_1 [-]');
ylabel('l_2 [-]');

% c.Label.String = 'GA';
% c.Label.FontSize = 12;

%% GA, L11-Alpha
% figure(10);

h3(2) = nexttile(t3);
imagesc([L11(1) L11(end)],[Alpha(1) Alpha(end)],sq8,'AlphaData',~isnan(sq8));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
% caxis([0 0.015])
% B = jet(10);
colormap(turbo);
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('geometrical advantage');
xlabel('l_1 [-]');
ylabel('\alpha [\circ]');

% c.Label.String = 'GA';
% c.Label.FontSize = 12;

%% GA, L11-Llif
% figure(11);
h3(3) = nexttile(t3);
clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[Llif(1) Llif(end)],sq9,'AlphaData',~isnan(sq9));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
colormap(turbo);
set(gca,'fontsize',14);
% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);


% title('geometrical advantage');
xlabel('l_1 [-]');
y = ylabel('l [-]');
y.Position(1) = y.Position(1)+abs(y.Position(1)*0.25);

% c.Label.String = 'GA';
% c.Label.FontSize = 12;

%% fix tiled layout 3

set(h3, 'Colormap', jet, 'CLim', [min(sq9,[],'all') max(sq9,[],'all')]);
cbh3 = colorbar(h3(end)); 

cbh3.Layout.Tile = 'east';
cbh3.Label.String = 'deviation of GA: |GA-2| [-]';
cbh3.Label.FontSize = 14;
set(gca,'fontsize',14);
brighten(0.2);

set(gcf,'color','w');
% export_fig('..\..\Writing\Images Paper\geometricaladvantagef','-pdf','-painters')
%% Load Capacity, L11-L33
figure('Position', [0 0 1300 400])
t4 = tiledlayout(1,3,...
    'Padding','compact',...
    'tilespacing','compact');
title(t4, 'load capacity','FontWeight','bold');

% figure(6);
h4(1) = nexttile(t4);

pbaspect(h4(1),[4 3 3])
clims = [0 100]; % could add this to last input imagesc

imagesc([L11(1) L11(end)],[L33(1) L33(end)],sq10,'AlphaData',~isnan(sq10));
set(gca,'color',0.6*[1 1 1]); %Make white areas grey
set(gca,'YDir','normal');   %Make ydirection normal (down to up)

colormap(flipud(turbo));

% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('load capacity');
xlabel('l_1 [-]');
ylabel('l_2 [-]');

% c.Label.String = 'Load Capacity';
% c.Label.FontSize = 12;

%% Load capacity, L11-Alpha
% figure(7);
h4(2) = nexttile(t4);
pbaspect(h4(2),[4 3 3])
imagesc([L11(1) L11(end)],[Alpha(1) Alpha(end)],sq11,'AlphaData',~isnan(sq11));

set(gca,'color',0.6*[1 1 1]);
set(gca,'YDir','normal')
% caxis([0 0.015])
% B = jet(10);
colormap(flipud(turbo));

% c = colorbar;
% c = colorbar('Ticks',linspace(0,0.015,11),...
%     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);

% title('load capacity');
xlabel('l_1 [-]');
ylabel('\alpha [\circ]');

% c.Label.String = 'Load Capacity';
% c.Label.FontSize = 12;

%% Load Capacity, L11-Llif
% figure(8);
% h4(3) = nexttile(t4);
% pbaspect(h4(3),[4 3 3])
% clims = [0 100]; % could add this to last input imagesc
% 
% imagesc([L11(1) L11(end)],[Llif(1) Llif(end)],sq12,'AlphaData',~isnan(sq12));
% 
% set(gca,'color',0.6*[1 1 1]);
% set(gca,'YDir','normal')
% colormap(flipud(turbo));
% 
% % c = colorbar;
% % c = colorbar('Ticks',linspace(0,0.015,11),...
% %     'TickLabels',["" "0.0015" "0.003" "0.0045" "0.006" "0.0075" "0.009" "0.0105" "0.0120" "0.0135" "0.015"]);
% 
% 
% % title('load capacity');
% xlabel('l_1 [-]');
% y = ylabel('l [-]');
% y.Position(1) = y.Position(1)+abs(y.Position(1)*0.25);
% 
% % c.Label.String = 'Load Capacity';
% % c.Label.FontSize = 12;
% 
% %% fix tiled layout 4
% 
% set(h4, 'Colormap', flipud(jet), 'CLim', [min(sq12,[],'all') max(sq12,[],'all')]);
% cbh2 = colorbar(h4(end)); 
% 
% cbh2.Layout.Tile = 'east';
% cbh2.Label.String = 'load capacity: min(Fi,Fo)/(E*L_c^2) [-]';
% cbh2.Label.FontSize = 12;
% brighten(0.2);
% 
% set(gcf,'color','w');
% export_fig('..\..\Writing\Images Paper\loadcapacitynondim','-pdf','-painters')



