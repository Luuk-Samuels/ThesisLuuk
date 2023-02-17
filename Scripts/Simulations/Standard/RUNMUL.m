clear;clc;clf;
close all force

% plot_on = 0; %0: no plot, 1: plot
% save_plot = 1;
%BY4kUk5fENcpL@T%
%Saving plots, but this did not work as you can not save images if not using the GUI
% fileID = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\imgsave.mac','w');
% if save_plot == 0
%     fprintf(fileID,"/INPUT,'EXPORT','mac','C:\\Users\\Luuk Samuels\\Documents\\TU Delft\\Master\\Thesis\\Ansys\\ConnectingMATLAB\\'");
% else
%     fprintf(fileID,"/COM,at least it reaches right \n/POST1 \n/view,1,1,1,1 \nPLDISP,1 \nAlphastr = chrval(Alpha/pi*180) \nLlifstr = chrval(Llif*1e3) \nL11str = chrval(L11*1e3) \nL33str = chrval(L33*1e3) \nstr = strcat('images\\',Alphastr) \nstr = strcat(str,'_') \nstr = strcat(str,Llifstr) \nstr = strcat(str,'_') \nstr = strcat(str,L11str) \nstr = strcat(str,'_') \nstr = strcat(str,L33str) \n/IMAGE,SAVE,str,'png' \nFINISH \n/INPUT,'EXPORT','mac','C:\\Users\\Luuk Samuels\\Documents\\TU Delft\\Master\\Thesis\\Ansys\\ConnectingMATLAB\\'");
% end
% fclose(fileID); 
%parameters (for now flexure dimensions are set)


%% Initial Investigation new disp 

Dinput = 1;
% 
% Alpha = 10:10:50; %angle
% Llif = 10:5:100; %length flexures
% L11 = 15:5:70; %width rigid part
% L33 = 20:5:70; %mm 8.6, height difference input/output
% % 

L = 20;
w = 30;

%% Full investigation Increasing resolution
% 

% Alpha = 12:2:38; %original 12:2:38
% Llif = 26:4:98;
% L11 = 32:3:71;
% 
% L33 = zeros(15,16); %15 L11, 16 L33
% 
% L33(1,1) = 20:2:20;
% L33(2,1:2) = 20:2:22;
% L33(3,1:4) = 20:2:26;
% L33(4,1:5) = 20:2:28;
% L33(5,1:6) = 20:2:30;
% L33(6,1:7) = 20:2:32;
% L33(7,1:8) = 20:2:34;
% L33(8,1:9) = 20:2:36;
% L33(9,1:10) = 20:2:38;
% L33(10,1:11) = 20:2:40;
% L33(11,1:13) = 20:2:44;
% L33(12,1:14) = 20:2:46;
% L33(13,1:15) = 20:2:48;
% L33(14,1:16) = 20:2:50;
% L33(15,1:16) = 20:2:50;

%% Iteration 1 Final

%Best load
% Alpha = 33:0.5:35;
% Llif = 36:1:40;
% L11 = 66.5:0.5:69.5;
% L33 = 45:0.5:47;
% 
% %Best Sin
% Alpha1 = 17:0.5:19;
% Llif1 = 24:1:28;
% L111 = 66.5:0.5:69.5;
% L331 = 25:0.5:27;
% 
% %Best Overall (leanign to sin)
% Alpha2 = 23:0.5:25;
% Llif2 = 32:1:36;
% L112 = 69.5:0.5:72.5;
% L332 = 33:0.5:35;
% 
% %Best overall (leaning to load)
% Alpha3 = 29:0.5:31;
% Llif3 = 36:1:40;
% L113 = 69.5:0.5:72.5;
% L333 = 41:0.5:43;

%% Iteration 2 Final

% %Best load
% Alpha = 32.6:0.2:33.4;
% Llif = 37.4:0.3:38.6;
% L11 = 69.1:0.2:69.9;
% L33 = 44.6:0.2:45.4;
% 
% %Best Sin
% Alpha1 = 15.6:0.2:16.4;
% Llif1 = 25.4:0.3:26.6;
% L111 = 67.6:0.2:68.4;
% L331 = 23.6:0.2:24.4;
% 
% %Best Overall (leanign to sin)
% Alpha2 = 22.6:0.2:23.4;
% Llif2 = 31.4:0.3:32.6;
% L112 = 71.6:0.2:72.4;
% L332 = 32.6:0.2:33.4;
% 
% %Best overall (leaning to load)
% Alpha3 = 29.1:0.2:29.9;
% Llif3 = 38.4:0.3:39.6;
% L113 = 71.6:0.2:72.4;
% L333 = 41.6:0.2:42.4;
% 
% %Best overall (in between)
% 
% Alpha4 = 24.6:0.2:25.4;
% Llif4 = 32.4:0.3:33.6;
% L114 = 70.6:0.2:71.4;
% L334 = 34.6:0.2:35.4;

%% Iteration 3 Final

% %Best load
% Alpha = 33.3:0.1:33.5;
% Llif = 38.4:0.1:38.8;
% L11 = 69.6:0.1:69.8;
% L33 = 44.7:0.1:44.9;
% 
% %Best Sin
% Alpha1 = 15.9:0.1:16.1;
% Llif1 = 25.5:0.1:25.9;
% L111 = 68.1:0.1:68.3;
% L331 = 23.5:0.1:23.7;
% 
% %Best Overall (leanign to sin)
% Alpha2 = 22.5:0.1:22.7;
% Llif2 = 31.5:0.1:31.9;
% L112 = 72.1:0.1:72.3;
% L332 = 32.5:0.1:32.7;
% 
% %Best overall (leaning to load)
% Alpha3 = 29.4:0.1:29.6;
% Llif3 = 38.5:0.1:38.9;
% L113 = 72.3:0.1:72.5;
% L333 = 42.3:0.1:42.5;
% 
% %Best overall (in between)
% 
% Alpha4 = 24.7:0.1:24.9;
% Llif4 = 32.5:0.1:32.9;
% L114 = 71.1:0.1:71.3;
% L334 = 34.7:0.1:34.9;

%% Iteration 4 Final

%one but best load, but more promising area

Alpha = 29.7:0.1:30.3; 
Llif = 36.5:0.1:37.5;
L11 = 70.3:0.1:70.7;
L33 = 41.3:0.1:41.7;


%% 1
tic
stressprev = 0;
% aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
load('DataSetf.mat','af');
for i = 1:length(Alpha)
    for j = 1:length(Llif)
        for k = 1:length(L11)
            for l = 1:length(L33(1,:))
%                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
%                         disp('well this doesnt work');
                if exist(af,Alpha(i),Llif(j),L11(k),L33(1,l))
%                     disp('already exists');    
                elseif L33(1,l) ~= 0
                    tic
                    Dinputstr = [num2str(Dinput) 'e-3'];
                    Alphastr = [num2str(Alpha(i)) '*pi/180'];  
                    Llifstr = [num2str(Llif(j)) 'e-3'];
                    L11str = [num2str(L11(k)) 'e-3'];
                    L33str = [num2str(L33(1,l)) 'e-3'];

                    Lstr = [num2str(L) 'e-3'];
                    wstr = [num2str(w) 'e-3'];
                    
                    %write to file with input parameters
                    fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
                    fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);

                    dos('LAUNCH.BAT');
                    fclose(fileID1);

                    %open data file that contains maximum stresses
                    fileID2 = fopen('VMS.txt');
                    stress = fscanf(fileID2,'%f, %f');
                    maxstress = max(stress);
                    fclose(fileID2);
                    

                    %read input/output displacement/force results
                    M = readmatrix('Results.csv');
                    Din = M(:,2);
                    Dout = M(:,3);
                    Fin = M(:,4);
                    
                    Din(Din==0) = nan;
                    Dout(Dout==0) = nan;
                    Fin(Fin==0) = nan;
                    
%                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
%                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
                    
                    if maxstress == stressprev
                        disp("Something went wrong");
                        if ((atand(L33(1,l)/L11(k))-Alpha(i)) > -5) && ((atand(L33(1,l)/L11(k))-Alpha(i)) < 5)
                            disp("Probably too close to singularity");
                        else
                            disp("Probably too large displacement or not connected to VPN, u dummy");
                        end
                        af(end+1) = Data(Alpha(i),Llif(j),L11(k),L33(1,l),0,[],[],[]);
                    else
                        stressprev = maxstress;
                        af(end+1) =  Data(Alpha(i),Llif(j),L11(k),L33(1,l),maxstress,Din,Dout,Fin);
                    end
% %                     

%                     stress(ind) = max(data);
%                     
%                     Time(ind,:) = M(:,1);
%                     Din(ind,:) = M(:,2);
%                     Dout(ind,:) = M(:,3);
%                     Fin(ind,:) = M(:,4);
                    toc
                else
%                     
                end
            end
        end
    end
end
toc
save('DataSetf.mat','af');
%% 2
% tic
% stressprev = 0;
% % aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetf.mat','af');
% for i = 1:length(Alpha1)
%     for j = 1:length(Llif1)
%         for k = 1:length(L111)
%             for l = 1:length(L331(1,:))
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%                 if exist(af,Alpha1(i),Llif1(j),L111(k),L331(1,l))
% %                     disp('already exists');    
%                 elseif L331(1,l) ~= 0
%                     tic
%                     Dinputstr = [num2str(Dinput) 'e-3'];
%                     Alphastr = [num2str(Alpha1(i)) '*pi/180'];  
%                     Llifstr = [num2str(Llif1(j)) 'e-3'];
%                     L11str = [num2str(L111(k)) 'e-3'];
%                     L33str = [num2str(L331(1,l)) 'e-3'];
% 
%                     Lstr = [num2str(L) 'e-3'];
%                     wstr = [num2str(w) 'e-3'];
%                     
%                     %write to file with input parameters
%                     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%                     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%                     dos('LAUNCH.BAT');
%                     fclose(fileID1);
% 
%                     %open data file that contains maximum stresses
%                     fileID2 = fopen('VMS.txt');
%                     stress = fscanf(fileID2,'%f, %f');
%                     maxstress = max(stress);
%                     fclose(fileID2);
%                     
% 
%                     %read input/output displacement/force results
%                     M = readmatrix('Results.csv');
%                     Din = M(:,2);
%                     Dout = M(:,3);
%                     Fin = M(:,4);
%                     
%                     Din(Din==0) = nan;
%                     Dout(Dout==0) = nan;
%                     Fin(Fin==0) = nan;
%                     
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
%                     
%                     if maxstress == stressprev
%                         disp("Something went wrong");
%                         if ((atand(L331(1,l)/L111(k))-Alpha1(i)) > -5) && ((atand(L331(1,l)/L111(k))-Alpha1(i)) < 5)
%                             disp("Probably too close to singularity");
%                         else
%                             disp("Probably too large displacement or not connected to VPN, u dummy");
%                         end
%                         af(end+1) = Data(Alpha1(i),Llif1(j),L111(k),L331(1,l),0,[],[],[]);
%                     else
%                         stressprev = maxstress;
%                         af(end+1) =  Data(Alpha1(i),Llif1(j),L111(k),L331(1,l),maxstress,Din,Dout,Fin);
%                     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%                     toc
%                 else
% %                     
%                 end
%             end
%         end
%     end
% end
% toc
% save('DataSetf.mat','af');
% % save('DataSet.mat','a');

%% 3 
% tic
% stressprev = 0;
% % aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetf.mat','af');
% for i = 1:length(Alpha2)
%     for j = 1:length(Llif2)
%         for k = 1:length(L112)
%             for l = 1:length(L332(1,:))
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%                 if exist(af,Alpha2(i),Llif2(j),L112(k),L332(1,l))
% %                     disp('already exists');    
%                 elseif L332(1,l) ~= 0
%                     tic
%                     Dinputstr = [num2str(Dinput) 'e-3'];
%                     Alphastr = [num2str(Alpha2(i)) '*pi/180'];  
%                     Llifstr = [num2str(Llif2(j)) 'e-3'];
%                     L11str = [num2str(L112(k)) 'e-3'];
%                     L33str = [num2str(L332(1,l)) 'e-3'];
% 
%                     Lstr = [num2str(L) 'e-3'];
%                     wstr = [num2str(w) 'e-3'];
%                     
%                     %write to file with input parameters
%                     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%                     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%                     dos('LAUNCH.BAT');
%                     fclose(fileID1);
% 
%                     %open data file that contains maximum stresses
%                     fileID2 = fopen('VMS.txt');
%                     stress = fscanf(fileID2,'%f, %f');
%                     maxstress = max(stress);
%                     fclose(fileID2);
%                     
% 
%                     %read input/output displacement/force results
%                     M = readmatrix('Results.csv');
%                     Din = M(:,2);
%                     Dout = M(:,3);
%                     Fin = M(:,4);
%                     
%                     Din(Din==0) = nan;
%                     Dout(Dout==0) = nan;
%                     Fin(Fin==0) = nan;
%                     
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
%                     
%                     if maxstress == stressprev
%                         disp("Something went wrong");
%                         if ((atand(L332(1,l)/L112(k))-Alpha2(i)) > -5) && ((atand(L332(1,l)/L112(k))-Alpha2(i)) < 5)
%                             disp("Probably too close to singularity");
%                         else
%                             disp("Probably too large displacement or not connected to VPN, u dummy");
%                         end
%                         af(end+1) = Data(Alpha2(i),Llif2(j),L112(k),L332(1,l),0,[],[],[]);
%                     else
%                         stressprev = maxstress;
%                         af(end+1) =  Data(Alpha2(i),Llif2(j),L112(k),L332(1,l),maxstress,Din,Dout,Fin);
%                     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%                     toc
%                 else
% %                     
%                 end
%             end
%         end
%     end
% end
% toc
% save('DataSetf.mat','af');
% % save('DataSet.mat','a');
% 
% %% 4
% tic
% stressprev = 0;
% % aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetf.mat','af');
% for i = 1:length(Alpha3)
%     for j = 1:length(Llif3)
%         for k = 1:length(L113)
%             for l = 1:length(L333(1,:))
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%                 if exist(af,Alpha3(i),Llif3(j),L113(k),L333(1,l))
% %                     disp('already exists');    
%                 elseif L333(1,l) ~= 0
%                     tic
%                     Dinputstr = [num2str(Dinput) 'e-3'];
%                     Alphastr = [num2str(Alpha3(i)) '*pi/180'];  
%                     Llifstr = [num2str(Llif3(j)) 'e-3'];
%                     L11str = [num2str(L113(k)) 'e-3'];
%                     L33str = [num2str(L333(1,l)) 'e-3'];
% 
%                     Lstr = [num2str(L) 'e-3'];
%                     wstr = [num2str(w) 'e-3'];
%                     
%                     %write to file with input parameters
%                     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%                     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%                     dos('LAUNCH.BAT');
%                     fclose(fileID1);
% 
%                     %open data file that contains maximum stresses
%                     fileID2 = fopen('VMS.txt');
%                     stress = fscanf(fileID2,'%f, %f');
%                     maxstress = max(stress);
%                     fclose(fileID2);
%                     
% 
%                     %read input/output displacement/force results
%                     M = readmatrix('Results.csv');
%                     Din = M(:,2);
%                     Dout = M(:,3);
%                     Fin = M(:,4);
%                     
%                     Din(Din==0) = nan;
%                     Dout(Dout==0) = nan;
%                     Fin(Fin==0) = nan;
%                     
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
%                     
%                     if maxstress == stressprev
%                         disp("Something went wrong");
%                         if ((atand(L333(1,l)/L113(k))-Alpha3(i)) > -5) && ((atand(L333(1,l)/L113(k))-Alpha3(i)) < 5)
%                             disp("Probably too close to singularity");
%                         else
%                             disp("Probably too large displacement or not connected to VPN, u dummy");
%                         end
%                         af(end+1) = Data(Alpha3(i),Llif3(j),L113(k),L333(1,l),0,[],[],[]);
%                     else
%                         stressprev = maxstress;
%                         af(end+1) =  Data(Alpha3(i),Llif3(j),L113(k),L333(1,l),maxstress,Din,Dout,Fin);
%                     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%                     toc
%                 else
% %                     
%                 end
%             end
%         end
%     end
% end
% toc
% save('DataSetf.mat','af');
% 
% %% 5
% tic
% stressprev = 0;
% % aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetf.mat','af');
% for i = 1:length(Alpha4)
%     for j = 1:length(Llif4)
%         for k = 1:length(L114)
%             for l = 1:length(L334(1,:))
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%                 if exist(af,Alpha4(i),Llif4(j),L114(k),L334(1,l))
% %                     disp('already exists');    
%                 elseif L334(1,l) ~= 0
%                     tic
%                     Dinputstr = [num2str(Dinput) 'e-3'];
%                     Alphastr = [num2str(Alpha4(i)) '*pi/180'];  
%                     Llifstr = [num2str(Llif4(j)) 'e-3'];
%                     L11str = [num2str(L114(k)) 'e-3'];
%                     L33str = [num2str(L334(1,l)) 'e-3'];
% 
%                     Lstr = [num2str(L) 'e-3'];
%                     wstr = [num2str(w) 'e-3'];
%                     
%                     %write to file with input parameters
%                     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%                     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%                     dos('LAUNCH.BAT');
%                     fclose(fileID1);
% 
%                     %open data file that contains maximum stresses
%                     fileID2 = fopen('VMS.txt');
%                     stress = fscanf(fileID2,'%f, %f');
%                     maxstress = max(stress);
%                     fclose(fileID2);
%                     
% 
%                     %read input/output displacement/force results
%                     M = readmatrix('Results.csv');
%                     Din = M(:,2);
%                     Dout = M(:,3);
%                     Fin = M(:,4);
%                     
%                     Din(Din==0) = nan;
%                     Dout(Dout==0) = nan;
%                     Fin(Fin==0) = nan;
%                     
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
%                     
%                     if maxstress == stressprev
%                         disp("Something went wrong");
%                         if ((atand(L334(1,l)/L114(k))-Alpha4(i)) > -5) && ((atand(L334(1,l)/L114(k))-Alpha4(i)) < 5)
%                             disp("Probably too close to singularity");
%                         else
%                             disp("Probably too large displacement or not connected to VPN, u dummy");
%                         end
%                         af(end+1) = Data(Alpha4(i),Llif4(j),L114(k),L334(1,l),0,[],[],[]);
%                     else
%                         stressprev = maxstress;
%                         af(end+1) =  Data(Alpha4(i),Llif4(j),L114(k),L334(1,l),maxstress,Din,Dout,Fin);
%                     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%                     toc
%                 else
% %                     
%                 end
%             end
%         end
%     end
% end
% toc
% save('DataSetf.mat','af');
% save('DataSet.mat','a');

%% Just for more substeps around -1e-3 - 1e-3, for earlier values
% tic
% % Time =
% % zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Din = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Dout = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Fin = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % 
% % stress = zeros(length(Alpha)*length(Llif)*length(L11)*length(L33),1);
% stressprev = 0;
% % aTPUp(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetTPUp.mat','aTPUp');
% for i = 1:length(plots)
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%     Alpha = aTPUp(plots(i)).Alpha;
%     Llif = aTPUp(plots(i)).Llif;
%     L11 = aTPUp(plots(i)).L11;
%     L33 = aTPUp(plots(i)).L33;
%     
% %     if exist(aTPUp,Alpha(i),Llif(j),L11(k),L33(1,l))
% %                     disp('already exists');    
% %     elseif L33(1,l) ~= 0
%     tic
%     Dinputstr = [num2str(Dinput) 'e-3'];
%     Alphastr = [num2str(Alpha) '*pi/180'];  
%     Llifstr = [num2str(Llif) 'e-3'];
%     L11str = [num2str(L11) 'e-3'];
%     L33str = [num2str(L33) 'e-3'];
% 
%     Lstr = [num2str(L) 'e-3'];
%     wstr = [num2str(w) 'e-3'];
% 
%     %write to file with input parameters
%     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%     dos('LAUNCH.BAT');
%     fclose(fileID1);
% 
%     %open data file that contains maximum stresses
%     fileID2 = fopen('VMS.txt');
%     stress = fscanf(fileID2,'%f, %f');
%     maxstress = max(stress);
%     fclose(fileID2);
% 
% 
%     %read input/output displacement/force results
%     M = readmatrix('Results.csv');
%     Din = M(:,2);
%     Dout = M(:,3);
%     Fin = M(:,4);
% 
%     Din(Din==0) = nan;
%     Dout(Dout==0) = nan;
%     Fin(Fin==0) = nan;
% 
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
% 
%     if maxstress == stressprev
%         disp("Something went wrong");
%         if ((atand(L33(1,l)/L11(k))-Alpha(i)) > -5) && ((atand(L33(1,l)/L11(k))-Alpha(i)) < 5)
%             disp("Probably too close to singularity");
%         else
%             disp("Probably too large displacement or not connected to VPN, u dummy");
%         end
% %         aTPUp(plots(i)) = Data(Alpha(i),Llif(j),L11(k),L33(1,l),0,[],[],[]);
%     else
%         stressprev = maxstress;
%         aTPUp(plots(i)) =  Data(Alpha,Llif,L11,L33,maxstress,Din,Dout,Fin);
%     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%         toc
% %     else
% %                     
% %     end
% end
% toc
% save('DataSetTPUp.mat','aTPUp');

%% For the second load step where L33 is dependent on L11
% tic
% % Time =
% % zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Din = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Dout = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % Fin = zeros((1*length(Alpha)*length(Llif)*length(L11)*length(L33)),250);
% % 
% % stress = zeros(length(Alpha)*length(Llif)*length(L11)*length(L33),1);
% stressprev = 0;
% % af(1) = Data(0,0,0,0,0,[],[],[]);
% load('DataSetf.mat','af');
% for i = 1:length(Alpha)
%     for j = 1:length(Llif)
%         for k = 1:length(L11)
%             for l = 1:length(L33(k,:))
% %                     if ((atand(L33(l)/L11(k))-Alpha(i)) > -1.27) && ((atand(L33(l)/L11(k))-Alpha(i)) < 3.2)
% %                         disp('well this doesnt work');
%                 if exist(af,Alpha(i),Llif(j),L11(k),L33(k,l))
% %                     disp('already exists');    
%                 elseif L33(k,l) ~= 0
%                     tic
%                     Dinputstr = [num2str(Dinput) 'e-3'];
%                     Alphastr = [num2str(Alpha(i)) '*pi/180'];  
%                     Llifstr = [num2str(Llif(j)) 'e-3'];
%                     L11str = [num2str(L11(k)) 'e-3'];
%                     L33str = [num2str(L33(k,l)) 'e-3'];
% 
%                     Lstr = [num2str(L) 'e-3'];
%                     wstr = [num2str(w) 'e-3'];
%                     
%                     %write to file with input parameters
%                     fileID1 = fopen('C:\Users\Luuk Samuels\Documents\TU Delft\Master\Thesis\Ansys\ConnectingMATLAB\parameter.inp','w');
%                     fprintf(fileID1,'Alpha=%s \nLlif=%s \nL11=%s \nL33=%s \nL=%s \nw=%s \nDinput=%s',Alphastr,Llifstr,L11str,L33str,Lstr,wstr,Dinputstr);
% 
%                     dos('LAUNCH.BAT');
%                     fclose(fileID1);
% 
%                     %open data file that contains maximum stresses
%                     fileID2 = fopen('VMS.txt');
%                     stress = fscanf(fileID2,'%f, %f');
%                     maxstress = max(stress);
%                     fclose(fileID2);
%                     
% 
%                     %read input/output displacement/force results
%                     M = readmatrix('Results.csv');
%                     Din = M(:,2);
%                     Dout = M(:,3);
%                     Fin = M(:,4);
%                     
%                     Din(Din==0) = nan;
%                     Dout(Dout==0) = nan;
%                     Fin(Fin==0) = nan;
%                     
% %                     ind = (i-1)*length(L11)*length(Llif)*length(L33)+(j-1)*length(L11)*length(L33) + (k-1)*length(L33)+l;
% %                     a(1) = Data(Alpha(1),Llif(1),L11(1),L33(1),stress(1),Din(1,:),Dout(1,:),Fin(1,:));
%                     
%                     if maxstress == stressprev
%                         disp("Something went wrong");
%                         if ((atand(L33(1,l)/L11(k))-Alpha(i)) > -5) && ((atand(L33(1,l)/L11(k))-Alpha(i)) < 5)
%                             disp("Probably too close to singularity");
%                         else
%                             disp("Probably too large displacement or not connected to VPN, u dummy");
%                         end
%                         af(end+1) = Data(Alpha(i),Llif(j),L11(k),L33(k,l),0,[],[],[]);
%                     else
%                         stressprev = maxstress;
%                         af(end+1) =  Data(Alpha(i),Llif(j),L11(k),L33(k,l),maxstress,Din,Dout,Fin);
%                     end
% % %                     
% 
% %                     stress(ind) = max(data);
% %                     
% %                     Time(ind,:) = M(:,1);
% %                     Din(ind,:) = M(:,2);
% %                     Dout(ind,:) = M(:,3);
% %                     Fin(ind,:) = M(:,4);
%                     toc
%                 else
% %                     
%                 end
%             end
%         end
%     end
% end
% toc
% save('DataSetf.mat','af');
