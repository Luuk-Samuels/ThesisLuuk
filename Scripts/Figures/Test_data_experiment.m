close all;clc;
clearvars -except af
%% This script was used to make Fig. 7, Fig. S11 and Fig. S12

%Almost at the bottom the sections indicate what should be commented/uncommented to get the wanted figures

%To make this script work, 
% - put track_dot in the same folder, if you want to analyze the videos again, but the results are also given as text files
% - download the videos needed (Test12_1.mp4, Test12_2.mp4, Test12_3.mp4, Test12_4.mp4)
% - change the path of the videos given below
% - Can also download the resulting output displacement text files (Position_vs_time_Test12_1.txt ...) (for this still the videos are needed),
% - text files and videos can be found in RawDataTests on GITHUB
% - The text files containing input displacement and force (Test12_1.xlxs etc.) should be downloaded and the path updated below.

% - Download the dataset aexp, from the DataSets in GITHUB (DataSetexp.mat).
% - Also to run for Fig. S12 ResultsRigid.csv is needed. 

%% 0.Initialize
px2m = 30/228/934*1080; %Test21 1,2,3,4,5

%% 1.Get height and bending angle vs time for all videos

vids(1) = dir('../../Testing/TestResults/12/Test12_1.mp4'); %21 test1
vids(2) = dir('../../Testing/TestResults/12/Test12_2.mp4'); %21 test2
vids(3) = dir('../../Testing/TestResults/12/Test12_3.mp4'); %21 test3
vids(4) = dir('../../Testing/TestResults/12/Test12_4.mp4'); %21 test4
% vids = dir('../../Testing/TestResults/12/Test12_5.mp4'); %21 test5

% vids = dir('../../Testing/TestResults/22/Test22_1.mp4'); %22 test1


%% Uncomment this part to run track_dot, which extracts the displacement from the given vids and saves the results as text files


% for i = 1:length(vids)
%     [t1,x,y] = track_dot([vids(i).folder '\' vids(i).name],px2m);
%     fid1 = fopen(['Position_vs_time_',vids(i).name(1:end-3),'txt'],'w');
%     for j = 1:length(t1)
%         fprintf(fid1,'%f,%f,%f\n',t1(j),x(j),y(j));
%     end
%     fclose(fid1);
% end
%%
% hold on
% plot(t1,x)
% plot(t1,y)
% plot(t1,sign(x).*sqrt(x.^2+y.^2))
% xlabel('time [s]')
% ylabel('Displacement [mm]')
% legend('x','y')

%%

% close all force
% if exist('aTPUp','var') == 0        %check whether a is already in workspace 
%     load('../../Ansys/ConnectingMatlab/DataSetTPUp.mat','aTPUp');    %if not in workspace load aTPUp
% end

for i = 1:length(vids)

    fid1 = fopen(['Position_vs_time_',vids(i).name(1:end-3),'txt'],'r');
    A = cell2mat(textscan(fid1,'%f,%f,%f'));

    t1(i,1:length(A(:,1))) = A(:,1);
    x(i,1:length(A(:,1))) = A(:,2);
    y(i,1:length(A(:,1))) = A(:,3);
end

load('Datasetexp.mat','aexp');

[~, ~, raw1] = xlsread('../../Testing/TestResults/12/Test12_1');
[~, ~, raw2] = xlsread('../../Testing/TestResults/12/Test12_2');
[~, ~, raw3] = xlsread('../../Testing/TestResults/12/Test12_3');
[~, ~, raw4] = xlsread('../../Testing/TestResults/12/Test12_4');
% [numbers, strings, raw] = xlsread('../../Testing/TestResults/12/Test12_5');

% [numbers, strings, raw] = xlsread('../../Testing/TestResults/22/Test1');

data1 = raw1(123:1471,:); %12_test1
data2 = raw2(422:1757,:); %12_test2
data3 = raw3(84:1388,:); %12_test3
data4 = raw4(67:1379,:); %12_test4

% data = raw(272:3555,:); %22_test1

for i = length(data1):-1:1
    if cellfun('isempty',data1(i,1)) || cellfun('isempty',data1(i,2))
        data1(i,:) = [];
    end
end
for i = length(data2):-1:1
    if cellfun('isempty',data2(i,1)) || cellfun('isempty',data2(i,2))
        data2(i,:) = [];
    end
end
for i = length(data3):-1:1
    if cellfun('isempty',data3(i,1)) || cellfun('isempty',data3(i,2))
        data3(i,:) = [];
    end
end
for i = length(data4):-1:1
    if cellfun('isempty',data4(i,1)) || cellfun('isempty',data4(i,2))
        data4(i,:) = [];
    end
end

% data1 = str2double(data);
data1 = cell2mat(data1);
data2 = cell2mat(data2);
data3 = cell2mat(data3); %this is diff
data4 = cell2mat(data4);

mag1 = sign(y(1,:)).*sqrt(x(1,:).^2+y(1,:).^2)*1e-3;
mag2 = sign(y(2,:)).*sqrt(x(2,:).^2+y(2,:).^2)*1e-3;
mag3 = sign(y(3,:)).*sqrt(x(3,:).^2+y(3,:).^2)*1e-3;
mag4 = sign(y(4,:)).*sqrt(x(4,:).^2+y(4,:).^2)*1e-3;

Dout1 = mag1;
Dout2 = mag2;
Dout3 = (mag3-min(mag3));
Dout4 = (mag4-min(mag4));

Din1 = (data1(:,1).*1e-3);
Din2 = (data2(:,1).*1e-3);
Din3 = (data3(:,1).*1e-3);
Din4 = (data4(:,1).*1e-3);

Fin1 = -data1(:,2);
Fin2 = -data2(:,2);
Fin3 = -data3(:,2);
Fin4 = -data4(:,2);
% Find the length of the longer array

maxLength1 = max(length(Dout1), length(Din1));
maxLength2 = max(length(Dout2), length(Din2));
maxLength3 = max(length(Dout3), length(Din3));
maxLength4 = max(length(Dout4), length(Din4));

% Resample the shorter array to match the length of the longer array
if length(Dout1) < length(Din1)
    Dout1 = interp1(1:length(Dout1), Dout1, linspace(1, length(Dout1), maxLength1));
else
    Din1 = interp1(1:length(Din1), Din1, linspace(1, length(Din1), maxLength1));
    Fin1 = interp1(1:length(Fin1), Fin1, linspace(1, length(Fin1), maxLength1));
end

if length(Dout2) < length(Din2)
    Dout2 = interp1(1:length(Dout2), Dout2, linspace(1, length(Dout2), maxLength2));
else
    Din2 = interp1(1:length(Din2), Din2, linspace(1, length(Din2), maxLength2));
    Fin2 = interp1(1:length(Fin2), Fin2, linspace(1, length(Fin2), maxLength2));
end

if length(Dout3) < length(Din3)
    Dout3 = interp1(1:length(Dout3), Dout3, linspace(1, length(Dout3), maxLength3));
else
    Din3 = interp1(1:length(Din3), Din3, linspace(1, length(Din3), maxLength3));
    Fin3 = interp1(1:length(Fin3), Fin3, linspace(1, length(Fin3), maxLength3));
end

if length(Dout4) < length(Din4)
    Dout4 = interp1(1:length(Dout4), Dout4, linspace(1, length(Dout4), maxLength4));
else
    Din4 = interp1(1:length(Din4), Din4, linspace(1, length(Din4), maxLength4));
    Fin4 = interp1(1:length(Fin4), Fin4, linspace(1, length(Fin4), maxLength4));
end


%% Here a new analysis is done to update the simulation result, however the result can also be found in DataSetexp.mat.
sim = 0;
if sim
    Alpha = 26.1; %angle
    Llif = 40.2; %length flexures
    L11 = 72.6; %width rigid part
    L33 = 37.7; %mm 8.6, height difference input/output

    Alphastr = [num2str(Alpha) '*pi/180'];  
    Llifstr = [num2str(Llif) 'e-3'];
    L11str = [num2str(L11) 'e-3'];
    L33str = [num2str(L33) 'e-3'];

    Lstr = '20e-3';
    wstr = '30e-3';
    Dinputstr = '3e-3';
    Flexure_t = '7.5e-4';
    Flexure_t_supp = '9e-4';
    Flexure_depth = '8e-3';
    Flexure_depth_supp = '12e-3';

    E = '1700e6';
    v = '0.4';

    fileID2 = fopen("C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\VideoAnalysis\RE_ Video displacement analysis\parameter.inp",'w');
    fprintf(fileID2,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s \nFlexure_t=%s \nFlexure_t_supp=%s \nFlexure_depth=%s \nFlexure_depth_supp%s \nE=%s \nv=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr,Flexure_t,Flexure_t_supp,Flexure_depth,Flexure_depth_supp,E,v);

    dos('LAUNCH.BAT');
    fclose(fileID2);

    %open data file that contains maximum stresses
    % fileID2 = fopen('VMS.txt');
    % stress = fscanf(fileID2,'%f, %f');
    % maxstress = max(stress);
    % fclose(fileID2);

    %read input/output displacement/force results
    M = readmatrix('Results.csv');
    Dins = M(:,2);
    Douts = M(:,3);
    Fins = M(:,4);

    Dins(Dins==0) = nan;
    Douts(Douts==0) = nan;
    Fins(Fins==0) = nan;

    aexp(2) =  Data(Alpha,Llif,L11,L33,0,Dins,Douts,Fins);
end

%% to calculate the average

Doutu(1,1:1926) = Dout1([floor(length(Dout1)*3/4):end 1:floor(length(Dout1)/4)]);
Doutu(2,1:1925) = fliplr(Dout1(floor(length(Dout1)/4):floor(length(Dout1)*3/4)));

Doutu(3,1:1925) = Dout2(floor(length(Dout2)/4):floor(length(Dout2)*3/4));
Doutu(4,1:1926) = fliplr(Dout2([floor(length(Dout2)*3/4):end 1:floor(length(Dout2)/4)]));

Doutu(5,1:1924) = fliplr(Dout3(1:floor(length(Dout3)/2)));
Doutu(6,1:1926) = Dout3(floor(length(Dout3)/2):end);

Doutu(7,1:1924) = Dout4(1:floor(length(Dout4)/2));
Doutu(8,1:1926) = fliplr(Dout4(floor(length(Dout4)/2):end));

Dinu(1,1:1926) = Din1([floor(length(Din1)*3/4):end 1:floor(length(Din1)/4)]);
Dinu(2,1:1925) = fliplr(Din1(floor(length(Din1)/4):floor(length(Din1)*3/4)));

Dinu(3,1:1925) = Din2(floor(length(Din2)/4):floor(length(Din2)*3/4));
Dinu(4,1:1926) = fliplr(Din2([floor(length(Din2)*3/4):end 1:floor(length(Din2)/4)]));

Dinu(5,1:1924) = fliplr(Din3(1:floor(length(Din3)/2)));
Dinu(6,1:1926) = Din3(floor(length(Din3)/2):end);

Dinu(7,1:1924) = Din4(1:floor(length(Din4)/2));
Dinu(8,1:1926) = fliplr(Din4(floor(length(Din4)/2):end));

Finu(1,1:1926) = Fin1([floor(length(Fin1)*3/4):end 1:floor(length(Fin1)/4)]);
Finu(2,1:1925) = fliplr(Fin1(floor(length(Fin1)/4):floor(length(Fin1)*3/4)));

Finu(3,1:1925) = Fin2(floor(length(Fin2)/4):floor(length(Fin2)*3/4));
Finu(4,1:1926) = fliplr(Fin2([floor(length(Fin2)*3/4):end 1:floor(length(Fin2)/4)]));

Finu(5,1:1924) = fliplr(Fin3(1:floor(length(Fin3)/2)));
Finu(6,1:1926) = Fin3(floor(length(Fin3)/2):end);

Finu(7,1:1924) = Fin4(1:floor(length(Fin4)/2));
Finu(8,1:1926) = fliplr(Fin4(floor(length(Fin4)/2):end));

xcommon = linspace(-3e-3,3e-3,2000);
ysum = zeros(1,2000);

for k = 1:length(Doutu(:,1))
    [x,ind] = unique(Dinu(k,:));
    ycommon = interp1(x,Doutu(k,ind),xcommon,'linear','extrap');
    ysum = ysum + ycommon;
end
ysum1 = zeros(1,2000);
for k = 1:4
    [x,ind] = unique(Dinu(k,:));
    ycommon = interp1(x,Doutu(k,ind),xcommon,'linear','extrap');
    ysum1 = ysum1 + ycommon;
end
ysumf = zeros(1,2000);
for k = 1:length(Finu(:,1))
    [x,ind] = unique(Dinu(k,:));
    ycommon = interp1(x,Finu(k,ind),xcommon,'linear','extrap');
    ysumf = ysumf + ycommon;
end


yavg = ysum./8;
yavg1 = ysum1./4;
yavgf = ysumf./8;

%% This part is used to create Fig. S11 from supplementary material

% [Dink1,ii1] = unique(aexp(2).Din);
% 
% Doutk1 = aexp(2).Dout(ii1); 
% 
% Fink1 = aexp(2).Fin(ii1);
% 
% [Dink2,ii2] = unique(aexp(1).Din);
% 
% Doutk2 = aexp(1).Dout(ii2); 
% 
% Fink2 = aexp(1).Fin(ii2);
% 
% figure('Position', [0 0 1200 500])
% t2 = tiledlayout(1,2,...
%     'Padding','tight',...
%     'tilespacing','tight');
% title(t2, 'experimental results','FontWeight','bold','Fontsize',14);
% 
% nexttile
% hold on
% box on
% title('displacement relation')
% % hold on
% plot(Dink2,Doutk2,'LineWidth',2)
% plot(Dink1,Doutk1,'LineWidth',2)
% 
% plot(Din1,Dout1,':','LineWidth',2)
% plot(Din2,Dout2,':','LineWidth',2)
% plot(Din3,Dout3,':','LineWidth',2)
% plot(Din4,Dout4,':','LineWidth',2)
% plot(xcommon,yavg,'--k','LineWidth', 2)
% % plot(xcommon,yavg1,'--r','LineWidth',2)
% 
% xlim([-3e-3 3e-3]);
% ylim([0 7e-3]);
% NumTicks = 7;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% 
% NumTicks = 8;
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))
% legend('')
% 
% xlabel('u_{in} [m]');
% ylabel('u_{out} [m]');
% set(gca,'Fontsize',14);
% lgd = legend('simulation','updated simulation', 'full positive cycle, start u_{in} = 0','full negative cycle, start u_{in} = 0', 'full cycle, start u_{in} = 3mm', 'full cycle, start u_{in} = -3mm','average of the experiments');
% lgd.Location = 'best';
% nexttile
% hold on
% box on
% title('force-displacement')
% plot(Dink2,Fink2,'LineWidth',2)
% plot(Dink1,Fink1,'LineWidth',2)
% plot(Din1,Fin1,':','LineWidth',2)
% plot(Din2,Fin2,':','LineWidth',2)
% plot(Din3,Fin3,':','LineWidth',2)
% plot(Din4,Fin4,':','LineWidth',2)
% plot(xcommon,yavgf,'--k','LineWidth', 2)
% xlim([-3e-3 3e-3]);
% NumTicks = 7;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))
% % 
% NumTicks = 5;
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))
% xlabel('u_{in} [m]');
% ylabel('F_{in} [N]');
% % lgd = legend('simulation','updated simulation', 'full positive cycle, start u_{in} = 0','full negative cycle, start u_{in} = 0', 'full cycle, start u_{in} = 3mm', 'full cycle, start u_{in} = -3mm');
% % lgd.Location = 'best';
% set(gca,'Fontsize',14);
%% This section is used to create Fig. 7 from the Thesis paper

if exist('af','var') == 0        %check whether a is already in workspace 
    load('../../Ansys/ConnectingMATLAB/DataSetf.mat','af');    %if not in workspace load a
end

[Dink1,ii1] = unique(aexp(2).Din);
[Dink2,ii2] = unique(af(50838).Din); %best overall

Doutk1 = aexp(2).Dout(ii1); 
Doutk2 = af(50838).Dout(ii2);

Fink1 = aexp(2).Fin(ii1);
Fink2 = af(50838).Fin(ii2);

figure('Position', [0 0 1300 400])
t1 = tiledlayout(1,3,...
    'Padding','compact',...
    'tilespacing','compact');
title(t1, '','FontWeight','bold','fontsize',14);
nexttile
hold on
title('displacement relation')
plot(Dink1,Doutk1,'k','LineWidth',2);

% plot(Dink2,Doutk2,'Color',1/256*[0, 64, 255]);
% plot(Dink3,Doutk3,'Color',1/256*[255, 191, 0]);
plot(-xcommon,yavg,'k--','LineWidth',1);


plot(Dink2,Doutk2,'LineWidth',2,'color',[0.9290 0.6940 0.1250]);
f = @(x) 4e3*(cosh(x)-1);
fplot(f,[-1e-3,1e-3],'--','LineWidth',1,'color',[0.9290 0.6940 0.1250]);
% plot([nan,nan],[nan,nan],'LineWidth',2,'color',[0.9290 0.6940 0.1250]);
xlabel('u_{in} [m]');
ylabel('u_{out} [m]');

lgd = legend('simulation prototype', 'experiment prototype', 'simulation best design','ideal sinusoidal solution');
% lgd.Title.String = 'best force capacity';
lgd.Location = 'north';

xlim([-2e-3,2e-3]);
ylim([0 5e-3]);

% NumTicks = 5;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))

% NumTicks = 6;
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))

set(gca,'Fontsize',14);
box on
% figure(2);
nexttile
hold on
title('force-displacement')
plot(Dink1,Fink1,'k','LineWidth',2);
% plot(Dink2,Fink2,'Color',1/256*[0, 64, 255]);
% plot(Dink3,Fink3,'Color',1/256*[255, 191, 0]);
plot(xcommon,yavgf,'k--','LineWidth',1);
plot(Dink2,Fink2,'color',[0.9290 0.6940 0.1250],'linewidth',2);
xlabel('u_{in} [m]');
ylabel('F_{in} [N]');
% lgd = legend('simulation', 'experimental');
% lgd.Title.String = 'best force capacity';
% lgd.Location = 'northwest';

xlim([-2e-3,2e-3]);
% ylim([-1.5 1.5]);
            
% NumTicks = 5;
% L = get(gca,'XLim');
% set(gca,'XTick',linspace(L(1),L(2),NumTicks))

% NumTicks = 7;
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))
set(gca,'Fontsize',14);
box on
% figure(3);
nexttile

hold on;
aexp(3) = Data(1,1,1,1,0,-xcommon,yavg,yavgf);
% concat(aexp(2),1e-3,2);
% concat(aexp(3),1e-3,2);
concat(af(50838),1e-3,2);
hline = findobj(gcf, 'type', 'line');
set(hline(1),'Linewidth',2,'color',[0.9290 0.6940 0.1250]);
% set(hline(2),'LineStyle','--','color','k','Linewidth',1);
% set(hline(3),'color','k');
% set(gca,'LineWidth',2);
fplot(@(t) 1e-3+1e-3*cos(4*t*2*pi),[0 1],'--','LineWidth',1,'color',[0.9290 0.6940 0.1250])
% lgd.Title.String = 'best force capacity';
set(gca,'Fontsize',14);
title('2 concatenations');
box on

% export_fig('..\..\Writing\Images Paper\validation','-pdf','-transparent')

%% This part is used to create Fig S12. from supplementary

% M = readmatrix('ResultsRigid.csv');
% Dinr = M(:,2);
% Finr = M(:,3);
% Doutr = M(:,4);
% 
% aexp(3) =  Data(Alpha,Llif,L11,L33,0,Dinr,Doutr,Finr);
% 
% [Dink1,ii1] = unique(aexp(2).Din);
% Doutk1 = aexp(2).Dout(ii1); 
% Fink1 = aexp(2).Fin(ii1);
% 
% [Dink2,ii2] = unique(aexp(3).Din);
% Doutk2 = aexp(3).Dout(ii2); 
% Fink2 = aexp(3).Fin(ii2);
% 
% 
% 
% figure('Position', [0 0 1200 500])
% t2 = tiledlayout(1,2,...
%     'Padding','tight',...
%     'tilespacing','tight');
% title(t2, 'rigidity analysis','FontWeight','bold','Fontsize',18);
% 
% nexttile
% hold on
% box on
% title('displacement relation')
% 
% plot(xcommon,yavg,'--k','LineWidth', 2)
% plot(Dink1,Doutk1,'color',[0.8500 0.3250 0.0980],'LineWidth',2)
% plot(Dink2,Doutk2,'color',[0.4660 0.6740 0.1880],'LineWidth',2)
% xlim([-3e-3 3e-3]);
% ylim([0 7e-3]);
% xlabel('u_{in} [m]');
% ylabel('u_{out} [m]');
% l = legend('experimental result','updated simulation','non-rigid simulation');
% set(gca,'fontsize',14);
% 
% 
% nexttile
% hold on
% box on
% title('force-displacement relation')
% 
% plot(xcommon,yavgf,'--k','LineWidth', 2)
% plot(Dink1,Fink1,'color',[0.8500 0.3250 0.0980],'LineWidth',2)
% plot(Dink2,Fink2,'color',[0.4660 0.6740 0.1880],'LineWidth',2)
% xlim([-3e-3 3e-3]);
% xlabel('u_{in} [m]');
% ylabel('F_{in} [N]');
% set(gca,'fontsize',14);

% export_fig('..\..\Writing\Images Supplemental\rigidity','-pdf','-transparent')
