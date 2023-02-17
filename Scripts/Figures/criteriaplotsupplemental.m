clearvars -except af af2
close all force
if exist('af','var') == 0        %check whether a is already in workspace 
    load('DataSetf.mat','af');    %if not in workspace load a
end

%% This script is used to create Fig. S20.

%to run this script DataSetf.mat together with Data.m is needed.


%% to get correct legend
hold on
B = turbo(1000);

%% actual plotting 
x1 = zeros(length(af),7); %inside the GA domain set
x2 = zeros(length(af),7); %outside the GA domain set
x3 = zeros(length(af),7); %all data

for i = 1:length(af) %[1:54298 68734:70243] 
    if af(i).GA > 1.99 && af(i).GA < 2.01
        x1(i,1:7) = [abs(af(i).GA-2),af(i).Sin,af(i).LoadMin, af(i).Alpha,af(i).L11/af(i).L33,af(i).Llif, af(i).SizeXY];
    else
        x2(i,1:7) = [abs(af(i).GA-2),af(i).Sin,af(i).LoadMin, af(i).Alpha,af(i).L11/af(i).L33,af(i).Llif, af(i).SizeXY];
    end
    x3(i,1:7) = [abs(af(i).GA-2),af(i).Sin,af(i).LoadMin, af(i).Alpha,af(i).L11/af(i).L33,af(i).Llif, af(i).SizeXY];
end

%x3: (1): GA, (2): SIN, (3): Load, (4): Alpha, (5): L11/L33, (6): Llif/uin (7): Sizexy/uin,  
x1(x1==0) = nan;
x2(x2==0) = nan;
x3(x3==0) = nan;

[~,i1] = sort(x1(:,1),'descend');
[~,i2] = sort(x2(:,1),'descend');
[~,i3] = sort(x3(:,1),'descend');

x1 = x1(i1,:);
x2 = x2(i2,:);
x3 = x3(i3,:);

%% actual plotting

% s = scatter(x2(:,2),x2(:,3),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
% s2 = scatter(x1(:,2),x1(:,3),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
figure('Position', [0 0 1600 800])
t1 = tiledlayout(2,3,...
    'Padding','compact',...
    'tilespacing','compact');
nexttile(1)

hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);

s = scatter(x2(:,2),x2(:,5),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,2),x1(:,5),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);
set(gca,'xscale','log');

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('L1/L2 [-]')
xlabel('sinusoidality NSSE [-]')

l = legend('|G.A.-2| > 0.01', '|G.A.-2| <= 0.01');
l.Location = 'best';

nexttile(4)
hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);
s = scatter(x2(:,3),x2(:,5),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,3),x1(:,5),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('L1/L2 [-]')
xlabel('load capacity: min(Fi,Fo) [N]')

% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02');
% l.Location = 'best';

nexttile(2)

hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);

s = scatter(x2(:,2),x2(:,4),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,2),x1(:,4),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);
set(gca,'xscale','log');

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('\alpha [\circ]')
xlabel('sinusoidality NSSE [-]')

% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02');
% l.Location = 'best';

nexttile(5)
hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);
s = scatter(x2(:,3),x2(:,4),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,3),x1(:,4),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('\alpha [\circ]')
xlabel('load capacity: min(Fi,Fo) [N]')

% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02');
% l.Location = 'best';

nexttile(3)

hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);

s = scatter(x2(:,2),x2(:,7),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,2),x1(:,7),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);
set(gca,'xscale','log');

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('normalized size: S/u_{in}')
xlabel('sinusoidality NSSE [-]')

% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02');
% l.Location = 'best';

nexttile(6)
hold on
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);
s = scatter(x2(:,3),x2(:,7),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,3),x1(:,7),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);

s.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
c = colorbar;

c.Label.String = 'deviation of GA: |GA-2| [-]';
c.Label.FontSize = 14;
% caxis([0 0.01])

ylabel('normalized size: S/u_{in}')
xlabel('load capacity: min(Fi,Fo) [N]')

% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02');
% l.Location = 'best';
% export_fig('..\..\Writing\Images Paper\FinalCriteria','-pdf','-transparent')

function callback(sObj,event,a)
    x = sObj.XData;
    y = sObj.YData;
    
    pt = event.IntersectionPoint;
    coordinates = [x(:),y(:)];
    dist = pdist2(pt(1:2),coordinates);
    
    [~, i] = mink(dist,length(dist));            % index of minimum distance to points 
%     delete(p)
    
    lgd = legend('');
    lgd.Title.String = ['\alpha = ' num2str(a(i(1)).Alpha) newline ' Llif = ' num2str(a(i(1)).Llif) newline ' L11 = ' num2str(a(i(1)).L11) newline ' L33 = ' num2str(a(i(1)).L33) newline 'GA = ' num2str(a(i(1)).GA) newline 'Sin = ' num2str(a(i(1)).Sin) newline 'Load = ' num2str(a(i(1)).LoadMin) newline 'Ind = ' num2str(i(1))];
end