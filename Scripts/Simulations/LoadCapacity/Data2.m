classdef Data2 < handle
    %Data Data saved for each property per parameter
    %   Detailed explanation goes here
    
    properties
        Alpha
        Llif
        L11
        L33
        Din
        Dout
        Fin
        Fout
        Kin
        Kout
        FatDin
        FatDout
        CheckDone
    end
    
    methods
        function obj = Data2(Alpha,Llif,L11,L33,Din,Dout,Fin,Fout)
            %Data Construct an instance of this class
            %   Detailed explanation goes here
            obj.Alpha = Alpha;
            obj.Llif = Llif;
            obj.L11 = L11;
            obj.L33 = L33;
            obj.Din = Din;
            obj.Dout = Dout;
            obj.Fin = Fin;
            obj.Fout = Fout;
            obj.CheckDone = false;
            obj.Kin = [];
            obj.Kout = [];
            obj.FatDin = 0;
            obj.FatDout = 0;
        end
        
        function [p1,p2] = plot(obj)
            figure(1);
            p1 = plot(obj.Din((max(1,(find(obj.Din == 0,1)-1)/2)):max(1,(find(obj.Din == 0,1)-1))),obj.Fin((max(1,(find(obj.Fin == 0,1)-1)/2)):max(1,(find(obj.Fin == 0,1)-1))));%,'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]); %,'color',Colorset(ind,:));
            hold on; 
            figure(2);
            p2 = plot(obj.Dout(1:max(1,(find(obj.Dout == 0,1)-1))),obj.Fout(1:max(1,(find(obj.Dout == 0,1)-1))));%,'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]); %,'color',Colorset(ind,:));
            hold on; 
            
            figure(1);
        %     plot(Din(i,:),Dout(i,:));
            title('Input Force vs. Input Displacement');
            xlabel('Input Displacement (m)');
            ylabel('Input Force (N)');
%             lgd = legend;
%             lgd.Title.String = 'Alpha,Llif,L11,L33';
%             lgd.Location = 'north';

            %Force displacement
            figure(2);
        %     plot(Din(i,:),Fin(i,:));
            title('Output Force vs. Output Displacement');
            xlabel('Output Displacement (m)');
            ylabel('Output Force (N)');
%             lgd = legend;
%             lgd.Title.String = 'Alpha,Llif,L11,L33';
%             lgd.Location = 'northwest';
        end
        function r = exist(a,Alpha,Llif,L11,L33)
            %Checking whether an object already exists
            %   Detailed explanation goes here
            for i=1:length(a)
                if (a(i).Alpha == Alpha) && (a(i).Llif == Llif) && (a(i).L11 == L11) && (a(i).L33 == L33)
                    r = true;
                    return
                end 
            end
            r = false;
        end
        function r = find(a,Alpha,Llif,L11,L33)
            %Returns index of object
            for i=1:length(a)
                if a(i).Alpha == Alpha && a(i).Llif == Llif && a(i).L11 == L11 && a(i).L33 == L33
                    r = i;
                    return
                end
            end
        end
        
        function Kinout(a2)
            for i =1:length(a2)
                [Dink,ii] = unique(a2(i).Din); %use only unique values to make interp1 work
                [Doutk,oi] = unique(a2(i).Dout); 
                Fink = a2(i).Fin(ii);
                Foutk = a2(i).Fout(oi);
                if length(Dink) < 2 || length(Doutk) < 2
                    if length(Dink) > 2
                        disp('Kout failed')
                        a2(i).FatDin = interp1(Dink,Fink,1e-5);
                    elseif length(Doutk) > 2
                         a2(i).FatDout = abs(interp1(Doutk,Foutk,-1e-5));
                         disp('Kin failed')
                    else
                        disp('Both failed')
                    end

                else


                    a2(i).FatDin = interp1(Dink,Fink,1e-5); %interpolate to find Fin at Din=1e-5
                    a2(i).FatDout = abs(interp1(Doutk,Foutk,1e-5));

                end
                
            end
        end
    end
end

