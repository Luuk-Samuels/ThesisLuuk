clearvars -except af 
close all force
if exist('af','var') == 0        %check whether a is already in workspace 
    load('DataSetf.mat','af');    %if not in workspace load a
end

%% to get correct legend
hold on
B = turbo(1000);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4);
scatter(nan,nan,20,nan,'filled','MarkerFaceColor','w','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1);
% scatter(nan,nan,20,nan,'filled','MarkerFaceAlpha',1.0,'MarkerFaceColor',B(995,:));
% scatter(nan,nan,20,nan,'filled','MarkerFaceAlpha',1.0,'MarkerFaceColor',B(5,:));

plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor',1/256*[0, 255, 64]);
plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor',1/256*[0, 64, 255]);
plot(nan,nan,"pentagram",'MarkerSize',12,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor',1/256*[255, 191, 0]); 


%% actual plotting 
x1 = zeros(length(af),3);
x2 = zeros(length(af),3);
for i = 1:length(af) %[1:54298 68734:70243] 
    if af(i).GA > 1.99 && af(i).GA < 2.01
        x1(i,1:3) = [abs(af(i).GA-2), af(i).Sin, af(i).LoadMin];
    else
        x2(i,1:3) = [abs(af(i).GA-2),af(i).Sin,af(i).LoadMin];
    end
end


x1(x1==0) = nan;
x2(x2==0) = nan;

s = scatter(x2(:,2),x2(:,3),20,x2(:,1),'filled','MarkerFaceAlpha',0.7,'MarkerEdgeColor',1/256*[120 120 120],'MarkerEdgeAlpha',0.4,'LineWidth',0.6);
s2 = scatter(x1(:,2),x1(:,3),40,x1(:,1),'filled','MarkerFaceAlpha',1,'MarkerEdgeColor',1/256*[0 0 0],'MarkerEdgeAlpha',1,'LineWidth',0.8);
set(gca,'xscale','log')


s2.ButtonDownFcn = {@callback,af};

% B = colormap([c1(1:19,:); 0 0 1; 0 0 1; c1(23:27,:)]);
% colormap([B; 0.6 0.6 0.6]);
colormap(B(80:1000,:));
% colormap(B);
c = colorbar;

c.Label.String = 'deviation of geometrical advantage |G.A.-2|';
c.Label.FontSize = 14;
% caxis([0 0.01])

xlabel('sinusoidality NSSE [-]')
ylabel('load capacity min(Fi,Fo) [N]')

ni1 = 50304;
ni2 = 49254;
ni3 = 50838;

plot(af(ni1).Sin,af(ni1).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(80,:),'MarkerEdgeColor',1/256*[0, 255, 64],'LineWidth',1.3);
plot(af(ni2).Sin,af(ni2).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(80,:),'MarkerEdgeColor',1/256*[0, 64, 255],'LineWidth',1.3);
plot(af(ni3).Sin,af(ni3).LoadMin,"pentagram",'MarkerSize',12,'MarkerFaceColor',B(80,:),'MarkerEdgeColor',1/256*[255, 191, 0],'LineWidth',1.3);

l = legend('|G.A.-2| > 0.01', '|G.A.-2| <= 0.01', 'best load capacity', 'best sinusoidality','best overall');
l.Location = 'northwest';

ax = gca;
ax.FontSize = 14;
l.FontSize = 11;

xlim([10^-8,1]);
% xTicks = logspace(0, log10(max(x2(:,2))), 4);
set(gca, 'XTick', [10^-8,10^-6,10^-4,10^-2,1]);

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