close all;clc;
clearvars -except aTPUp

%% This file can be used to plot Fig. S13 from supplementary material,

% To do this Test22_1.mp4, Test22_1.xlxs and Position_vs_time_Test22_1.txt are needed
% these files can be foun in rawtestdata on github
% also update the paths in this document to fit the new paths of these files.
%% 0.Initialize

px2m = 30/244/1002*1080; %Test22 1
%640x352


%% 1.Get height and bending angle vs time for all videos

vids = dir('../../Testing/TestResults/22/Test22_1.mp4'); %22 test1


% for i = 1:length(vids)
%     [t1,x,y] = track_dot([vids(i).folder '\' vids(i).name],px2m);
%     fid1 = fopen(['Position_vs_time_',vids(i).name(1:end-3),'txt'],'w');
%     for j = 1:length(t1)
%         fprintf(fid1,'%f,%f,%f\n',t1(j),x(j),y(j));
%     end
%     fclose(fid1);
% end
for i = 1:length(vids)

    fid1 = fopen(['Position_vs_time_',vids(i).name(1:end-3),'txt'],'r');
    A = cell2mat(textscan(fid1,'%f,%f,%f'));

    t1(i,1:length(A(:,1))) = A(:,1);
    x(i,1:length(A(:,1))) = A(:,2);
    y(i,1:length(A(:,1))) = A(:,3);
end
%%
% hold on
plot(t1,x)
plot(t1,y)
plot(t1,sign(y).*sqrt(x.^2+y.^2))
% xlabel('time [s]')
% ylabel('Displacement [mm]')
% legend('x','y')


%%

% close all force
% if exist('aTPUp','var') == 0        %check whether a is already in workspace 
%     load('../../Ansys/ConnectingMatlab/DataSetTPUp.mat','aTPUp');    %if not in workspace load aTPUp
% end

fid1 = fopen(['Position_vs_time_',vids(1).name(1:end-3),'txt'],'r');
A = cell2mat(textscan(fid1,'%f,%f,%f'));

t1 = A(:,1);
x = A(:,2);
y = A(:,3);

load('Datasetexp.mat','aexp');

[numbers, strings, raw] = xlsread('../../Testing/TestResults/22/Test22_1');

data = raw(272:3606,:); %22_test1 %3255

for i = length(data):-1:1
    if cellfun('isempty',data(i,1)) || cellfun('isempty',data(i,2))
        data(i,:) = [];
    end
end

% data = strrep(data, ',', '.');
% data1 = str2double(data);
data1 = cell2mat(data);

mag = sign(y).*sqrt(x.^2+y.^2)*1e-3;
Dout = mag;
% Dout = (mag-min(mag)); %if started on maximum
% Dout = mag; %if started at D = 0;
Din = (data1(:,1).*1e-3)-0; %0.00018 to make it symmetrical, - because positive is flipped in test
Fin = data1(:,2);
% Find the length of the longer array

Doutt = diff(Dout);

maxLength = max(length(Dout), length(Din));

% Resample the shorter array to match the length of the longer array
if length(Dout) < length(Din)
    Dout = interp1(1:length(Dout), Dout, linspace(1, length(Dout), maxLength));
else
    Din = interp1(1:length(Din), Din, linspace(1, length(Din), maxLength),'nearest');
    Fin = interp1(1:length(Fin), Fin, linspace(1, length(Fin), maxLength),'nearest');
end

%% have some way to check params
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

[Dink1,ii1] = unique(aexp(2).Din);
Doutk1 = aexp(2).Dout(ii1); 
Fink1 = aexp(2).Fin(ii1);

[Dink2,ii2] = unique(aexp(1).Din);
Doutk2 = aexp(1).Dout(ii2); 
Fink2 = aexp(1).Fin(ii2);


figure(2);
hold on
box on
title('force-displacement relation')

plot(Din,-Fin,'--k','LineWidth', 2)
plot(Dink1,Fink1,'color',[0.8500 0.3250 0.0980],'LineWidth',2)
% plot(Dink2,Fink2,'color',[0.4660 0.6740 0.1880],'LineWidth',2)
xlim([-3e-3 3e-3]);
xlabel('u_{in} [m]');
ylabel('F_{in} [N]');
set(gca,'fontsize',14);

l = legend('experimental results', 'updated simulation');
l.Location = 'northwest';

% export_fig('..\..\Writing\Images Supplemental\stressrelax','-pdf','-transparent')
