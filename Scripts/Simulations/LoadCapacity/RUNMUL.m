% clear;clc;clf;
% close all force

plot_on = 0; %0: no plot, 1: plot

%parameters (for now flexure dimensions are set)

Dinput = 0.1;

% load('rTPU1.mat','r'); %1.9 < GA < 2.1
% load('rTPUp1_5.mat','r'); %1.9 < GA < 2.1
% load('rTPUp2.mat','r');%1.97 < GA < 2.03
% load('rTPUp3.mat','r'); %1.99 < GA < 2.01
% load('rTPUp4.mat','r'); %1.99 < GA < 2.01

%% ones used for af
% load('rTPUpINIT.mat','r'); %full load investigation of init (preliminary)
% load('rf_full.mat','r'); %load investigation of 1.8 < GA < 2.2, for full
% load('rf_It1.mat','r'); %load investigation of 1.9 < GA < 2.2, for 1st iteration
% load('rf_It2.mat','r'); %load investigation of 1.96 < GA < 2.04, for 2nd iteration
% load('rf_It3.mat','r'); %load investigation of 1.98 < GA < 2.02, for 3rd iteration
load('rf_It4.mat','r'); %load investigation of 1.98 < GA < 2.02, for 3rd iteration

% load('rTPUp1extra.mat','r'); %extra Alpha, 1.9 < GA < 2.1
L = 20; %mm 20, length of linear guiding flexures is 2L
w = 30; %mm 20, width between linear guiding flexures is 2w

%% iterate every solution

% Time =
% zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% Din = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% Dout = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% Fin = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% 
% stress = zeros(length(Alpha)*length(Llif)*length(L11)*length(L33),1);
% aTPUpINIT(1) = Data2(0,0,0,0,[],[],[],[]);
% load('DataSet2.mat','a2');
% load('DataSetTPUp2.mat','aTPUp2');
load('DataSetafINIT.mat','afINIT');
% load('DataSetTPUpINIT.mat','aTPUpINIT');

for i = 1:length(r(:,1))
    tic
    if exist(afINIT,r(i,1),r(i,2),r(i,3),r(i,4))
        disp('already exists');
    else
        Dinputstr = [num2str(Dinput) 'e-3'];
        Alphastr = [num2str(r(i,1)) '*pi/180'];
        Llifstr = [num2str(r(i,2)) 'e-3'];
        L11str = [num2str(r(i,3)) 'e-3'];
        L33str = [num2str(r(i,4)) 'e-3'];

        Lstr = [num2str(L) 'e-3'];
        wstr = [num2str(w) 'e-3'];

        fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\InnyOutyStiffy\parameter.inp','w');
        fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
        fclose(fileID1);

        dos('LAUNCHIN.BAT');
        M = readmatrix('Results.csv');
        Din = M(:,2);
        Fin = M(:,4);
        
%         fileID2 = fopen('VMS.txt');
%         Sin = fscanf(fileID2,'%f');
%         fclose(fileID2);

        dos('LAUNCHOUT.BAT');
        M = readmatrix('Results.csv');
        Dout = M(:,3);
        Fout = M(:,5);
        
%         fileID2 = fopen('VMS.txt');
%         Sout = fscanf(fileID2,'%f');
%         fclose(fileID2);
        
        afINIT(end+1) = Data2(r(i,1),r(i,2),r(i,3),r(i,4),Din,Dout,Fin,Fout);
%         q = find(a2,r(i,1),r(i,2),r(i,3),r(i,4));
%         a2(q).Dout = Dout;
%         a2(q).Fout = Fout;
    end
    toc
end
 
% save('DataSetTPUp2.mat','aTPUp2');
% save('DataSetTPUpINIT.mat','aTPUpINIT');
save('DataSetafINIT.mat','afINIT');

%% Quick Plots

% for i=1:length(a2)
%     a22(i).plot
% end



