classdef Data < handle
    %Data Data saved for each simulation
    %   This class consists of simulation result data, that can be used:
    %   Summary of the functions:
    %   Data(Alpha,Llif,L11,L33,Smax,Din,Dout,Fin): initializes a new simulation of the class
    %   exist(a,Alpha,Llif,L11,L33): check whether a combination of geometry already exists
    %   check(a): check designs input by a on the Stress limit and deviation of the GA
    %   plot(obj): plots the displacement relation and force-displacement of the input object
    %   perfectplot(obj,s,s2): plot the perfect sinusoidal input-output displacement relation for scaling from GA=2: s and scaling from Din=1e-3: s2
    %   find(a,Alpha,Llif,L11,L33): find the index in a of the given geometry
    %   findcrit(a,label,value): find the index for a certain property and value
    %   size(a): evaluate size for all input objects
    %   linearity(a): evaluate linearity for all input objects
    %   sinusoidality(a,dom): evaluate sinusoidality for all input objects, for the given domain
    %   GeoAdv(a,dom): evaluate geometrical advantage for all input objects, for the given domain
    %   KAct(a): evaluate actuation stiffness of the all input objects
    %   couple(a,a2): couple the load capacity found in the loadmin analysis (class: a2) to the class (a).
    %   del(a): delete simulations that accidentily used the results of a previously run simulation
    %   bestga(a): return index of the design with smallest deviation in G.A. 
    %   bestlin(a): return two vectors, one sorted array with indexes of best-worst linearity designs, and one with the corresponding values
    %   bestsin(a): return two vectors, one sorted array with indexes of best-worst sinusoidality designs, and one with the corresponding values
    %   nondimcrits(a): evaluate some of the set nondimensional properties
    %   concat(obj,dom,n,color): theoretical concatenation of the object for the set domain (dom), n = number of concatenations, col= color in
    %   resulting plot
    
    
    properties
        Alpha %alpha value
        Llif %leaf flexure length 
        L11 %horizontal spacing butterfly flexures
        L33 %vertical spacing buttefly flexures
        Smax %maximum stress found during simulation
        Din %vector with input displacements
        Dout %vector with output displacements
        Fin %vector with input force 
        CheckDone % 0 or 1, whether check for GA and Stress is done 
        CheckRes % 0 or 1, outcome of previous test
        GA %geometrical advantage of the mechanism
        Lin %linearity of the mechanism
        Sin %sinusoidality of the mechanism
        FAct %maximum actuation force needed 
        FatDin %load capacity at input
        FatDout %load capacity at output
        LoadMin %minimum of previous two load capacities
        SizeX %horizontal size of mechanism
        SizeY %vertical size of mechanism
        SizeXY %diagonal size of mechanism
        L11_L33 %parameter L11/L33
        Llif_L33 %parameter Llif/L33
        Llif_L11 %parameter Llif/L11
        FinLL % attempt at non-dimensionalizing load capacity
        FoutLL % ^^
        LoadMinD% ^^
    end
    
    methods
        function obj = Data(Alpha,Llif,L11,L33,Smax,Din,Dout,Fin)
            %Data Construct an instance of this class
            %   Detailed explanation goes here
            obj.Alpha = Alpha;  
            obj.Llif = Llif;
            obj.L11 = L11;
            obj.L33 = L33;
            obj.Smax = Smax;
            obj.Din = Din;
            obj.Dout = Dout;
            obj.Fin = Fin;
            obj.CheckDone = false;
            obj.CheckRes = false;
            obj.GA = NaN;
            obj.Lin = NaN;
            obj.Sin = NaN;
            obj.FAct = NaN;
            obj.FatDin = NaN;
            obj.FatDout = NaN;
            obj.LoadMin = NaN;
            obj.SizeX = NaN;
            obj.SizeY = NaN;
            obj.SizeXY = NaN;
            obj.L11_L33 = NaN; 
            obj.Llif_L33 = NaN;
            obj.Llif_L11 = NaN; 
            obj.FinLL = NaN;
            obj.FoutLL = NaN;
            obj.LoadMinD = NaN;
        end
        
        function r = exist(a,Alpha,Llif,L11,L33)
            %Checking whether an object already exists
            %   Detailed explanation goes here
            for i=length(a):-1:1
                if (a(i).Alpha == Alpha) && (a(i).Llif == Llif) && (a(i).L11 == L11) && (a(i).L33 == L33)
                    r = true;
                    return
                end 
            end
            r = false;
        end
        function [r,num,ind] = check(a)
            %Checking if criteria are met
            %   r = output parameters for correct criteria
            %   num = number of solutions
            %   ind = index where to find solutions
            Dinput = 1e-3; %domain around which check is done 
            LB = 1.98*Dinput; %lower bound for GA
            UB = 2.02*Dinput;
%             LB2 = 0.476e-3;
%             UB2 = 0.524e-3;
%             LB3 = 0.96e-3;
%             UB3 = 1.04e-3;
            Yield = 32e6; %constraint on yield strength (48e6*SF) with SF = 1.5
            
            numb = 0;
            in = [];
            cor = [];
            for i=1:length(a)
                
                if a(i).CheckDone %check if check for this object is already done
                    disp("already done");
                    if a(i).CheckRes
                        numb = numb+1;
                        cor(numb,:) = [a(i).Alpha, a(i).Llif, a(i).L11, a(i).L33];
                        in(end+1) =i;
                    end
                else
                    [Dink,ii] = unique(a(i).Din); %use only unique values to make interp1 work
                    Dink = rmmissing(Dink);   
                    Doutk = a(i).Dout(ii);
%                     P1 =  find(0.24e-3 <= a(i).Din & a(i).Din <= 0.26e-3);
%                     P2 = find(-0.24e-3 >= a(i).Din & a(i).Din >= -0.26e-3);
                    
%                     P3 = find(0.49e-3 <= a(i).Din & a(i).Din <= 0.51e-3);
%                     P4 = find(-0.49e-3 >= a(i).Din & a(i).Din >= -0.51e-3);
                    if length(Dink) ~= length(Doutk)
                        Doutk = Doutk(1:length(Dink));
                    end
                    if isempty(a(i).Dout) || isempty(max(1,find(isnan(a(i).Din),1)-1))
                        a(i).CheckDone = true;
                        disp("does not work");
                    else
%                         if a(i).Smax < Yield   %check how many were bad due to Smax
%                             disp("too high stress");
%                         end
                        GA1 = interp1(Dink,Doutk,Dinput);
                        GA2 = interp1(Dink,Doutk,-Dinput);
                        if a(i).Smax < Yield && GA1 > LB &&  GA2 > LB && GA1 < UB && GA2 < UB && abs(GA1-GA2) <= 0.4e-3 %last criterion is just to check whether the GA's are around the same value
                            disp("Nice");
                            a(i).CheckRes = true;
                            a(i).CheckDone = true;
                            numb = numb +1;
                            cor(numb,:) = [a(i).Alpha, a(i).Llif, a(i).L11, a(i).L33];
                            in(end+1) = i; 
                        else
                            a(i).CheckDone = true;
                            disp("not so Nice");
                        end
                    end
                end
            end
            if nargout > 2 %here the number of outputs is modified depending on what the user gives as output variables
                r = cor; 
                num = numb;
                ind = in;
            end
            if nargout == 2
                r = cor;
                num = numb;
            end
            if nargout == 1
                r = cor;
            end
        end
        
        function plot(obj)
            
            dom = 1e-3;
            
%             newcolors = distinguishable_colors(50); %this is done to get distinguishable colors but can also be commented
            [Dink,ii] = unique(obj.Din); 
%             Dink = rmmissing(Dink); % to remove NaN's here not necessary
            Doutk = obj.Dout(ii);
            Fink = obj.Fin(ii);
            figure(1);
%             colororder(newcolors); 
            plot(Dink,Doutk,'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]);
            hold on;
        %     plot(Din(i,:),Dout(i,:));
            title('input-output displacement relation');
            xlabel('u_{in} [m]','FontSize',14);
            ylabel('u_{out} [m]','FontSize',14);
            lgd = legend;
            lgd.FontSize = 12;
%             lgd.Interpreter = 'latex'; 
%             lgd.Title.String = '\alpha [ $ ' char(176) '$ ],\bar{L} [-],L1/Din [-],L2/Din [-] $ ';
            lgd.Title.String = '\alpha [\circ], l  [-], l_1 [-], l_2 [-]';
            lgd.Location = 'north';
            lgd.Title.FontSize = 14;

            xlim([-dom,dom]);

            
            NumTicks = 5;
            L = get(gca,'XLim');
            set(gca,'XTick',linspace(L(1),L(2),NumTicks))

%             set(gca,'XTickLabel',get(gca,'XTick'),'fontsize',12);
            
            NumTicks = 6;
%             L = get(gca,'YLim');
            set(gca,'YTick',linspace(0, 2.5e-3,NumTicks))
%             set(gca,'YTickLabel',get(gca,'YTick'),'fontsize',12);
            
            ax = gca;
            ax.FontSize = 14;
            
            
            figure(2);
%             colororder(newcolors);
            plot(Dink,Fink,'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]); 
            hold on;
        %     plot(Din(i,:),Fin(i,:));
            title('force-displacement relation');
            xlabel('u_{in} [m]','FontSize',14);
            ylabel('F_{in} [N]','FontSize',14);
            lgd = legend;
            lgd.FontSize = 12;
            lgd.Title.String = '\alpha [\circ], l  [-], l_1 [-], l_2 [-]';
            lgd.Location = 'northwest';
            xlim([-dom,dom]);
            lgd.Title.FontSize = 14;
            
            ax=gca; 
            ax.XAxis.Exponent = -3;
            
            NumTicks = 5;
            L = get(gca,'XLim');
            set(gca,'XTick',linspace(L(1),L(2),NumTicks))
%             set(gca,'XTickLabel',get(gca,'XTick'),'fontsize',12);
            
            L = get(gca,'YLim');
            set(gca,'YTick',linspace(L(1),L(2),NumTicks))
%             set(gca,'YTickLabel',get(gca,'YTick'),'fontsize',12);

            ax = gca;
            ax.FontSize = 14;
            
             
            
%             plot(obj.Din((max(1,(find(isnan(obj.Din),1)-1)/2)):end),obj.Dout((max(1,(find(isnan(obj.Din),1)-1)/2)):end),'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]); %,'color',Colorset(ind,:));
%             hold on; 
%             figure(2);
%             colororder(newcolors);
%             plot(obj.Din((max(1,(find(isnan(obj.Din),1)-1)/2)):end),obj.Fin((max(1,(find(isnan(obj.Din),1)-1)/2)):end),'Displayname',[num2str(obj.Alpha) ',' num2str(obj.Llif) ',' num2str(obj.L11) ',' num2str(obj.L33)]); %,'color',Colorset(ind,:));
%             hold on;
            
        end
        
        function perfectplot(obj,s,s2)
            %s = scaling from GA=2, so GA=2.2 --> s = 1.1
            %s2 = scaling from Din = 1e-3, Din = 2e-3 --> s2 = 0.5;
            opt1 = [6.965110,6.965110,7.628278,-pi/2];
            f = @(x) (s/s2)*(opt1(1)+opt1(2)*sin(opt1(3)*pi*x*s2+opt1(4)));
            figure(1);
            fplot(f,[-1e-3 1e-3],'Displayname','Perfect Sinusoidal');
        end
        
        function r = find(a,Alpha,Llif,L11,L33)
            %Returns index of object
            i = 1;
            while i < length(a)+1
                if a(i).Alpha == Alpha && a(i).Llif == Llif && a(i).L11 == L11 && a(i).L33 == L33
                    r = i;
                    return
                else
                    i = i+1;
                end
            end
            r = 5;
        end
        
        function r = findcrit(a,label,value)
            i = 1;
            while i < length(a)+1
                if a(i).(label) == value
                    r = i;
                    return
                else
                    i = i+1;
                end
            end
            r = 'not found';
        end
        
        %all functions to calculate properties per simulation (FAct, Linearity, GA, size (FatDin and FatDout are determined in Data2))
        function size(a)
            for i = 1:length(a)
                a(i).SizeX = a(i).L11+2*a(i).Llif*cosd(a(i).Alpha);
                a(i).SizeY = a(i).L33+2*a(i).Llif*sind(a(i).Alpha);
                a(i).SizeXY = sqrt(a(i).SizeX^2+a(i).SizeY^2);
            end
        end
        
        function linearity(a)
            for i=1:length(a)
                sum = 0;
                [Dink,ii] = unique(a(i).Din); %use only unique values to make interp1 work
                Dink = rmmissing(Dink);
                Doutk = rmmissing(a(i).Dout(ii));%rmmissing to remove nans
                %SSE
                c = abs(max(Doutk)/max(Dink));
                if c < 0.2
                    a(i).Lin = NaN;
                else
                    f1 = @(x) c*x;
                    f2 = @(x) -c*x;
                    for j=1:length(Dink)
                        if Dink(j) > 0
                            sum = sum + (Doutk(j)-f1(Dink(j)))^2/max(Doutk)^2;
                        else 
                            sum = sum + (Doutk(j)-f2(Dink(j)))^2/max(Doutk)^2;
                        end
                    end
                    if sum == 0
                        a(i).Lin = NaN;
                    else
                        a(i).Lin = sum;
                    end
                end

            end
        end
        
        function sinusoidality(a,dom)
            for i=1:length(a)
                sum = 0;
                Dink = rmmissing(a(i).Din); %removing NaN values
                Doutk = rmmissing(a(i).Dout);
                
                [Dink,ii] = unique(Dink); %use only unique values to make interp1 work
                ii2 = Dink>=-dom & Dink<=dom; %create a mask inside domain
                Dink = Dink(ii2);
                Doutk = Doutk(ii);%rmmissing to remove nans
                Doutk = Doutk(ii2);
                %SSE
                c = max(Doutk)/max(abs(Dink));
                s = c/2;
                s2 = 1e-3/max(Dink); %1e-3, cause that's where the perfect sin is fitted
                if c > 0.2
%                     opt1 = [6.965110,6.965110,7.628278,-pi/2]; %fitted parameters for GA=2
                    f = @(x) (s/s2)*4e3*(cosh(x*s2)-1);
%                     f = @(x) (s/s2)*(opt1(1)+opt1(2)*sin(opt1(3)*pi*x*s2+opt1(4)));   
                    for j=1:length(Dink)               
                        sum = sum + (Doutk(j)-f(Dink(j)))^2/max(Doutk)^2; %divide by max^2 such that the error is not dependent on GA.
                    end
                end
                if sum == 0
                    a(i).Sin = NaN;
                else
                    a(i).Sin = sum/length(Dink); %divide by length(Dink) to get average error per measurement
                end
            end
        end
        
        function GeoAdv(a,dom)
            for i=1:length(a)
                if isempty(a(i).Dout) || isempty(max(1,find(isnan(a(i).Din),1)-1))
                        disp("No Data");
                else
                    Dink = rmmissing(a(i).Din); %removing NaN values
                    Doutk = rmmissing(a(i).Dout);
                    [Dink,ii] = unique(Dink);
                    Doutk = Doutk(ii);
                    GA1 = interp1(Dink,Doutk,dom);
                    GA2 = interp1(Dink,Doutk,-dom);
                    if isempty(GA1) || isempty(GA2)
                        a(i).GA = NaN;
                    else
                        dif = [abs(GA1-dom*2),abs(GA2-dom*2)];
                        [~,in] = max(dif);
                        if in == 1 
                            a(i).GA = GA1/dom;  %take the worst GA to represent
                        else
                            a(i).GA = GA2/dom;
                        end
                %     a(i).CheckRes = 0;
                    end
                end
            end
        end
        
        function KAct(a)
            for i=1:length(a)
                [~,ii] = unique(a(i).Din); %use only unique values to make interp1 work
                Fink = a(i).Fin(ii);

                if isempty(Fink)
                    a(i).FAct = NaN;
                else
                    a(i).FAct = max(Fink);
                end
            end
        end
        
        function couple(a,a2)
            for i = 1:length(a2)
                i
                ind = find(a,a2(i).Alpha,a2(i).Llif,a2(i).L11,a2(i).L33);
                a(ind).FatDout = a2(i).FatDout; 
                a(ind).FatDin = a2(i).FatDin;
            end
        end
        
        function del(a)
            for i = length(a):-1:3
                if a(i).GA == a(i-2).GA
                    a(i) = Data(a(i).Alpha,a(i).Llif,a(i).L11,a(i).L33,NaN,[],[],[]); 
                    a(i).FatDin = NaN;
                    a(i).FatDout = NaN; 
                    a(i).Smax = NaN; 
                end
            end
        end
        
        function r = bestga(a)
            %r: index of best solution
            best = Inf;
            for i = 1:length(a)
                if abs(a(i).GA-2) < abs(best-2)
                    r = i;
                    best = a(i).GA;
                elseif abs(a(i).GA-2) == abs(best-2)
                    r(end+1) = i;
                else
                end
            end
        end
        function [r,i] = bestlin(a,num)
            %r: index of best solution
            all = zeros(length(a),1);
            for i = 1:length(a)
                all(i) = a(i).Lin;
            end
            [r,i] = mink(all,num);
        end
        function [r,i] = bestsin(a,num)
            all = zeros(length(a),1);
            for i = 1:length(a)
                all(i) = a(i).Sin;
            end
            [r,i] = mink(all,num);
        end
        function nondimcrits(a)
            E = 95e6;
            b = 8e-3;
            d = 0.9e-3;
%             Din = 1e-3;
            for i = 1:length(a)
                a(i).L11_L33 = a(i).L11/a(i).L33;
                a(i).Llif_L33 = a(i).Llif/a(i).L33;
                a(i).Llif_L11 = a(i).Llif/a(i).L11;
                a(i).FinLL = a(i).FatDin/E/a(i).SizeXY^2; % eta = F*s^2/Ebd
                a(i).FoutLL = a(i).FatDout/E/a(i).SizeXY^2;
                a(i).LoadMinD = min(a(i).FinLL,a(i).FoutLL); 
                a(i).LoadMin =  min(a(i).FatDout,a(i).FatDin); %not a nondim
            end
        end
        
        function concat(obj,dom,n,color)
            [Doutk,tf] = rmmissing(obj.Dout); %removing NaN values
            Dink = obj.Din(~tf);
                            
            [Dink,ii] = unique(Dink); %use only unique values to make interp1 work
            Doutk = Doutk(ii);

            %n = 1, should just use the current DD relation
            %n > 1, should displace DD to get odd,even. 

            Dinsin = @(t) dom*sin(2*pi*t);
            t = 0:0.001:1;

            num = 1; 

            D = zeros(n,length(t));
            for i = 1:n
                D(isnan(D)) = 2e-3;
                if num == 1
                    for j = 1:length(t)
                        inp = Dinsin(t(j));
                        D(i,j) = interp1(Dink,Doutk,inp,'linear','extrap'); 
                    end
                    num = num +1;
                else
                    for j = 1:length(t)
                        inp = D(i-1,j)-dom; %-dom to make input correspond to odd funct
                        D(i,j) = interp1(Dink,Doutk,inp,'linear','extrap');
                    end
                    num = num +1;
                end
            end
            D(isnan(D)) = 2e-3;
            title(['Output after n = ' num2str(n) ' iterations']);
            plot(t,D(n,:),'color',color,'LineWidth',1);

            xlabel('normalized cycle')
            ylabel('u_{out} [m]')
        end

    end
end

