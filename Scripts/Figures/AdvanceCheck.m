clearvars -except af afINIT
close all force 
if exist('af','var') == 0        %check whether a is already in workspace 
    load('DataSetf.mat','af');    %if not in workspace load a
end
if exist('afINIT','var') == 0 
    load('..\InnyOutyStiffy\DataSetafINIT.mat','afINIT');
end

% Kinout(afINIT);
% couple(af,afINIT(12541:end));
% sinusoidality(af,1e-3);
% GeoAdv(af,1e-3);
% nondimcrits(af);
% size(af);

% for i = 1:length(af)
%     af(i).CheckDone = 0;
%     af(i).CheckRes = 0;
% end
% [r,num,ind] = check(af(51970:end));

%% to make Fig. 3 plot in paper
%To get the same colors as in the paper, the distinguishable_colors package should be used.
%If added to path the line with this should be uncommented in Data.m


plots = [5843, 4171, 8915, 3379, 3559, 9634];

for i = 1:length(plots)
    af(plots(i)).plot
end

%% To make the iteration plots Fig S8
%To get exactly the same graphs do the following:
% - Change the domain constraint of the GA (dom).
% - Change the domain of the dataset (af) with the domains of the dataset (af) given below
% - iterations of af =  (1:12541:44679:48175:51295:51970:53894), in order 1:12541 = preliminary, full, 1st iteration, 2nd iteration, 3rd iteration, 4th
% iteration
% EXAMPLE: for iteration 2, af(1:51295) and dom = 0.06;

%Also the indexes of the best values has to be altered by changing i1,i2,i3,i4 and ni1,ni2,ni3,ni4


%Also notice that in these grahs if clicked on a certain point, the data of that point will be displayed in the legend 
hold on
B = turbo(1000);

scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);
% scatter(nan,nan,20,nan,'filled','MarkerFaceAlpha',1.0,'MarkerFaceColor',B(995,:));
% scatter(nan,nan,20,nan,'filled','MarkerFaceAlpha',1.0,'MarkerFaceColor',B(5,:));

plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFacecolor',[1 1 1],'MarkerEdgeColor',1/256*[0, 255, 64]);
plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFacecolor',[1 1 1],'MarkerEdgeColor',1/256*[0, 64, 255]);
plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFacecolor',[1 1 1],'MarkerEdgeColor',[0.4940 0.1840 0.5560]); 
plot(nan,nan,"+",'MarkerSize',12,'MarkerFacecolor',[1 1 1],'MarkerEdgecolor', [0 0 0],'LineWidth',2);


%% actual plotting 
x1 = zeros(length(af),7); %inside the GA domain set
x2 = zeros(length(af),7); %outside the GA domain set
x3 = zeros(length(af),7); %all data

dom = 0.01;
for i = 1:length(af) 
    if af(i).GA > (2-dom) && af(i).GA < (2+dom)
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

%% actual plotting

% s = scatter(x2(:,2),x2(:,3),20,x2(:,1),'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
% s2 = scatter(x1(:,2),x1(:,3),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
figure(1);
hold on
s = scatter(x2(:,2),x2(:,3),20,'filled','MarkerFaceAlpha',0.4,'MarkerFaceColor',1/256*[180 180 180],'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
s2 = scatter(x1(:,2),x1(:,3),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
set(gca,'fontsize',14);
set(gca,'xscale','log')
s2.ButtonDownFcn = {@callback,af};

colormap(B(80:1000,:));
% colormap(B);
c = colorbar;

c.Label.String = 'deviation of geometrical advantage |G.A.-2|';
c.Label.FontSize = 14;
% caxis([0 0.01])

xlabel('sinusoidality NSSE [-]')
ylabel('load capacity min(Fi,Fo) [N]')



i1 = 47698; 
i2 = 51500;
i3 = 51255;


ni2 = 49254;
ni1 = 50304;
ni3 = 50838;
% ni4 = 
% ni5 = 


p1 = plot(af(i1).Sin,af(i1).LoadMin,"+",'MarkerSize',12,'MarkerFaceColor',B(min(1000,floor(abs(2-af(i1).GA)/dom*920)),:),'MarkerEdgeColor',1/256*[0, 255, 64],'LineWidth',3);
p2 = plot(af(i2).Sin,af(i2).LoadMin,"+",'MarkerSize',12,'MarkerFaceColor',B(min(1000,floor(abs(2-af(i2).GA)/dom*920)),:),'MarkerEdgeColor',1/256*[0, 64, 255],'LineWidth',3);
p3 = plot(af(i3).Sin,af(i3).LoadMin,"+",'MarkerSize',12,'MarkerFaceColor',B(min(1000,floor(abs(2-af(i3).GA)/dom*920)),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',3);
% p4 = plot(af(i4).Sin,af(i4).LoadMin,"+",'MarkerSize',12,'MarkerFaceColor',B(min(1000,floor(abs(2-af(i4).GA)/dom*920)),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',3);
% p5 = plot(af(i5).Sin,af(i5).LoadMin,"+",'MarkerSize',12,'MarkerFaceColor',B(min(1000,floor(abs(2-af(i5).GA)/dom*920)),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',3);

n1 = plot(af(ni1).Sin,af(ni1).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(floor(abs(2-af(ni1).GA)/dom*920),:),'MarkerEdgeColor',1/256*[0, 255, 64],'LineWidth',1.3);
n2 = plot(af(ni2).Sin,af(ni2).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(floor(abs(2-af(ni2).GA)/dom*920),:),'MarkerEdgeColor',1/256*[0, 64, 255],'LineWidth',1.3);
n3 = plot(af(ni3).Sin,af(ni3).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(floor(abs(2-af(ni3).GA)/dom*920),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',1.3);
% n4 = plot(af(ni4).Sin,af(ni5).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(floor(abs(2-af(ni4).GA)/dom*920),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',1.3);
% n5 = plot(af(ni5).Sin,af(ni5).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(floor(abs(2-af(ni5).GA)/dom*920),:),'MarkerEdgeColor',[0.4940 0.1840 0.5560],'LineWidth',1.3);

l = legend('|G.A.-2| > 0.01', '|G.A.-2| <= 0.01', 'best load capacity', 'best sinusoidality','best overall','iteration before');
% l = legend('|G.A.-2| > 0.02', '|G.A.-2| <= 0.02', 'best load capacity','iteration before');
l.Location = 'best';

% figure(2);
% hold on 

% s = scatter(x2(:,2),x2(:,3),20,'filled','MarkerFaceAlpha',0.4,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',1.1);
% s2 = scatter(x1(:,2),x1(:,3),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',1.3);
% 
% set(gca,'xscale','log')
% export_fig('..\..\Writing\Images Supplemental\Iterations\full','-pdf','-transparent')

function callback(sObj,event,a)
    x = sObj.XData;
    y = sObj.YData;
    
    pt = event.IntersectionPoint;
    coordinates = [x(:),y(:)];
    dist = pdist2(pt(1:2),coordinates);
    
    [~, i] = mink(dist,length(dist));            % index of minimum distance to points 
%     delete(p)
    
    lgd = legend('');
    lgd.Title.String = ['A = ' num2str(a(i(1)).Alpha) newline ' Llif = ' num2str(a(i(1)).Llif) newline ' L11 = ' num2str(a(i(1)).L11) newline ' L33 = ' num2str(a(i(1)).L33) newline 'GA = ' num2str(a(i(1)).GA) newline 'Sin = ' num2str(a(i(1)).Sin) newline 'Load = ' num2str(a(i(1)).LoadMin) newline 'Ind = ' num2str(i(1))];
end