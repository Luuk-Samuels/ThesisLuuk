clearvars -except af
close all force
if exist('af','var') == 0        %check whether a is already in workspace 
    load('DataSetf.mat','af');    %if not in workspace load a
end


%% This file was used to plot Fig. S19

%In order to run this file the dataset af, is needed (DataSetf.mat) together with Data.m

%% 
% for i=1:length(a)
%     P = find(a(i).Din == 1e-3);
%     if isempty(P)
%         a(i).GA = NaN;
%     else
%         a(i).GA = a(i).Dout(P(1))/a(i).Din(P(1));
% %     a(i).CheckRes = 0;
%     end
% end

% Alpha = [20,22.5,25,27.5,30];
% Llif = [40:5:110];
% L11 = [5,10,15,20,22.5,25,27.5,30,32.5,35,37.5,40,42.5,45,47.5,50,52.5,55,57.5,60,62.5,65,67.5,70];
% L33 = [5,10,15,17.5,20,22.5,25,27.5,30,32.5,35,37.5,40,42.5,45,50];

% Alpha = [10:10:60];
% Llif = [10,15,20,25,30,35,40,45,50,55,60,65,70,80,90,100];
% L11 = [5:5:70];
% L33 = [5:5:50];

Alpha = 10:10:50; %angle
Llif = 10:5:100; %length flexures
L11 = 15:5:70; %width rigid part
L33 = 20:5:70; %mm 8.6, height difference input/output

z = zeros(length(Alpha),length(Llif),2000,3);
for i = 2:12541 %length(a)
    if ~ismember(af(i).L33,L33) || ~ismember(af(i).L11,L11) || ~ismember(af(i).Alpha,Alpha) || ~ismember(af(i).Llif,Llif)
    else
        i1 = find(af(i).Alpha == Alpha,1);
        i2 = find(af(i).Llif == Llif,1);
        i3 = find(z(i1,i2,:,1)==0,1);
        z(i1,i2,i3,:) = [af(i).L11,af(i).L33,af(i).LoadMin];
    end
end
z(z==0) = nan;
%% plotting


figure('Position', [0 0 320 1100]);
t = tiledlayout(length(Llif),length(Alpha),...
    'Padding','loose','tilespacing','none');
title(t, 'load capacity','fontsize',10);
L1 = length(Alpha);
L2 = length(Llif);
for i=1:(length(Alpha)*length(Llif))
%     nr = (find(a(i).Llif == Llif,1)-1)*6+find(a(i).Alpha == Alpha,1);
    if mod(i,L1)==0
        i1 = idivide(int8(i),L1);
    else
        i1 = idivide(int8(i),L1)+1;
    end
    b = length(Llif):-1:1;
    if mod(i,L1)==0
        i2 = L1;
    else
        i2 = mod(i,L1);
    end

%     sph{i} = subplot(length(Llif),length(Alpha),i,'Parent',fig);
    nexttile
%     imagesc([L11(1) L11(end)],[Llif(1) Llif(end)],sq3,'AlphaData',~isnan(sq3));
    
    sq = zeros(length(L33),length(L11));
    for j = 1:length(z(i2,b(i1),:,1))    
        i3 = find(z(i2,b(i1),j,1) == L11,1);
        i4 = find(z(i2,b(i1),j,2) == L33,1);
        sq(i4,i3) = z(i2,b(i1),j,3);
    end
    
    imagesc([L11(1) L11(end)],[L33(1) L33(end)],flipud(sq));
%     scatter(reshape(z(i2,b(i1),:,1),[],1),reshape(z(i2,b(i1),:,2),[],1),2,reshape(z(i2,b(i1),:,3),[],1),'filled')
    hold on
%     plot([20 70],[15,50],'b');
%     plot([20 70],[15 15],'b');
    xlim([12.5 72.5]);
    ylim([17.5 72.5]);
    caxis([min(reshape(z(:,:,:,3),[],1),[],'all'), max(reshape(z(:,:,:,3),[],1),[],'all')]);
    if i < L1+1
        title(['\fontsize{8}\alpha = ' num2str(Alpha(i2)) '\circ'])
    end
    if i > (L1*L2)-L1
        set(gca,'Xtick',[10 20 30 40 50 60 70])
        set(gca,'XTicklabels',["10" "20" "30" "40" "50" "60" "70"])
        ax = gca;
        ax.FontSize = 5;
        xlabel('\fontsize{7}l_1 [-]');
    else
        set(gca,'Xtick',[])
    end
%     if Alpha(i2) == 20
%         fplot(@(x) x*tand(20));
%     end
    if i2 ~= 1
        set(gca,'YTick',[]);
    else
        set(gca,'Ytick',[20 30 40 50 60 70])
        set(gca,'Yticklabels',["70" "60" "50" "40" "30" "20"])
        ax = gca;
        ax.FontSize = 5;
%         set(gca,'FontWeight','bold')
        ylabel({['\fontsize{7}\bf l =' num2str(Llif(b(i1))) ' [-]'], '\rm l_2 [-]'});
    end
    hold on

end

c1 = flipud(turbo);
% h = axes(fig,'visible','off');
% colorbar(h, 'Position',[0.93 0.168 0.022 0.7]);
% h = axes(gcf,'visible','off');
B = colormap(c1);
% c = colorbar(h(end)); 
% c = colorbar(h,'Position',[0.85 0.12 0.03 0.8]);

% c = colorbar(h,'Position',[0.93 0.168 0.022 0.7],'Ticks',linspace(0,3.1,32),...
%     'TickLabels',["0" "0.1" "0.2" "0.3" "0.4" "0.5" "0.6" "0.7" "0.8" "0.9" "1.0" "1.1" "1.2" "1.3" "1.4" "1.5" "1.6" "1.7" "1.8" "1.9" "2.0" "2.1" "2.2" "2.3" "2.4" "2.5" "2.6" "2.7" "2.8" "2.9" "> 3" ""]);
% caxis([0 3.1]);
caxis([min(reshape(z(:,:,:,3),[],1),[],'all'), max(reshape(z(:,:,:,3),[],1),[],'all')]);
% c.Label.Interpreter = 'latex';
% c.Label.String = '$Load Capacity$';
% c.Label.FontSize = 40;
% set(gca,'FontSize',25);

% set(gcf,'visible','off')
% set(gcf, 'PaperPositionMode', 'auto')
% set(gcf,'Units','points')
% set(gcf,'PaperUnits','points') 
% scale = 8;
% t.OuterPosition = [0 0 0.9 1];
% set(gcf, 'PaperPosition', [0 0 L1*scale L2*scale])



% size = get(gcf,'Position');
% size = size(3:4);
% set(gcf,'PaperSize',size)

% set(gcf,'PaperPosition',[0,0,size(1),size(2)])

% exportgraphics(gcf,'../Results/Final/TilePlotTestForceSquareExp.png','Resolution',300)

% print(gcf, '../Results/Final/TilePlotTestForceSquare', '-dpng', '-r300');

% export_fig('..\..\Writing\Images Supplemental\TilePlotLoadf','-pdf','-painters')

% saveas(fig,'../Results/ViablePlots/TilePlots/GA','png')



%% OLD %%


% Alpha = [10,20,30,40,50,60];
% Llif = [10,15,20,25,30,35,40,45,50,55,60,65,70,80,90,100];
% L11 = [5,10,15,20,25,30,35,40,45,50,55,60,65,70];
% L33 = [5,10,15,20,25,30,35,40,45,50];
% 
% z = zeros(length(Alpha),length(Llif),300,3);
% for i = 5:18818
%     if a(i).L33 == 6 || a(i).L33 == 7 || a(i).L33 == 8 || a(i).L33 == 9
%     else
%         i1 = find(a(i).Alpha == Alpha,1);
%         i2 = find(a(i).Llif == Llif,1);
%         i3 = find(z(i1,i2,:,1)==0,1);
%         z(i1,i2,i3,:) = [a(i).L11,a(i).L33,a(i).GA];
%     end
% end
% z(z==0) = nan;
% %% plotting
% fig = figure(1);
% hold on
% 
% t = tiledlayout(length(Llif),length(Alpha),...
%     ...'Padding','none',
%     'tilespacing','tight');
% title(t, 'GA for each design at the end of the input','fontsize',10);
% 
% for i=1:(length(Alpha)*length(Llif))
% %     nr = (find(a(i).Llif == Llif,1)-1)*6+find(a(i).Alpha == Alpha,1);
%     if mod(i,6)==0
%         i1 = idivide(int8(i),6);
%     else
%         i1 = idivide(int8(i),6)+1;
%     end
%     b = [16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1];
%     if mod(i,6)==0
%         i2 = 6;
%     else
%         i2 = mod(i,6);
%     end
% 
% %     sph{i} = subplot(length(Llif),length(Alpha),i,'Parent',fig);
%     nexttile
%     scatter(reshape(z(i2,b(i1),:,1),[],1),reshape(z(i2,b(i1),:,2),[],1),5,reshape(z(i2,b(i1),:,3),[],1),'filled')
%     xlim([0 70]);
%     ylim([0 50]);
%     if i < 7
%         title(['\fontsize{6}Alpha = ' num2str(Alpha(i2)) '\circ'])
%     end
%     if i > 90
%         set(gca,'Xtick',[10 20 30 40 50 60 70])
%         set(gca,'XTicklabels',["10" "20" "30" "40" "50" "60" "70"])
%         xlabel('\fontsize{6}L11 (mm)');
%     else
%         set(gca,'Xtick',[])
%     end
%     if i2 ~= 1
%         set(gca,'YTick',[]);
%     else
%         set(gca,'Ytick',[10 20 30 40 50])
%         set(gca,'Yticklabels',["10" "20" "30" "40" "50"])
% %         set(gca,'FontWeight','bold')
%         ylabel({['\fontsize{6}\bf Llif = ' num2str(Llif(b(i1))) ' (mm)'], '\rm L33 (mm)'});
%     end
%     hold on
%     caxis([0,3.1]);
%     
% end
% 
% 
% c1 = hsv(60);
% % h = axes(fig,'visible','off');
% % colorbar(h, 'Position',[0.93 0.168 0.022 0.7]);
% h = axes(fig,'visible','off');
% B = colormap([c1(1:19,:); 0 0 1; 0 0 1; c1(24:33,:)]);
% c = colorbar(h,'Position',[0.93 0.168 0.022 0.7],'Ticks',linspace(0,3.1,32),...
%     'TickLabels',["0" "0.1" "0.2" "0.3" "0.4" "0.5" "0.6" "0.7" "0.8" "0.9" "1.0" "1.1" "1.2" "1.3" "1.4" "1.5" "1.6" "1.7" "1.8" "1.9" "2.0" "2.1" "2.2" "2.3" "2.4" "2.5" "2.6" "2.7" "2.8" "2.9" "> 3" ""]);
% caxis([0 3.1]);
% c.Label.Interpreter = 'latex';
% c.Label.String = '$GA$';
% c.Label.FontSize = 12;
% 
% 
% set(gcf,'visible','off')
% scale = 2.2661;
% set(gcf, 'PaperPosition', [0 0 6*scale 16*scale])
% print(gcf, '../Results/ViablePlots/TilePlots/GA.png', '-dpng', '-r300' );
% 
% % saveas(fig,'../Results/ViablePlots/TilePlots/GA','png')


