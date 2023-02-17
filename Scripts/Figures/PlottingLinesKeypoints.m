
clc;clf;clear;
close all force

%% this file  was used to create Fig. S6
% it has no dependencies with other files.

%constants
Flexure_t = 4e-4;
Flexure_depth = 8e-3;

%important params
Alpha = 26.1*pi/180;  		
Llif = 40.2e-3;			
L11 = 72.6e-3;			
L33 = 37.7e-3;	

L = 20e-3;
w = 30e-3;

K = [0,0,0,-L11/2,-L11/2,L11/2,L11/2,-L11/2-Llif*cos(Alpha),-L11/2-Llif*cos(Alpha),L11/2+Llif*cos(Alpha),L11/2+Llif*cos(Alpha),0,-w,w,-w,w,0,-L,-L,L,L;
    0,L33/2,L33,0,L33,0,L33,-Llif*sin(Alpha),L33+Llif*sin(Alpha),-Llif*sin(Alpha),L33+Llif*sin(Alpha),L33/2,-L+L33/2,-L+L33/2,L+L33/2,L+L33/2,L33/2,L33/2+w,L33/2-w,L33/2+w,L33/2-w;
    0,0,0,0,0,0,0,0,0,0,0,12e-3,12e-3,12e-3,12e-3,12e-3,-12e-3,-12e-3,-12e-3,-12e-3,-12e-3];

% plot3([K1(1),K4(1)],[K1(2),K4(2)],[K1(3),K4(3)])
% text(K1(1),K1(2),K1(3),num2str(1))

figure(1);

hold on;

plot3([nan,nan],[nan,nan],[nan,nan],'color',[0 0 1],'linewidth',2);
plot3([nan,nan],[nan,nan],[nan,nan],'color',[0.4660 0.6740 0.1880],'linewidth',2);
plot3([nan,nan],[nan,nan],[nan,nan],'color',[0.4940 0.1840 0.5560],'linewidth',2);

plot3([nan,nan],[nan,nan],[nan,nan],'color',[0 1 1],'linewidth',2);
plot3([nan,nan],[nan,nan],[nan,nan],'color',[0 1 0],'linewidth',2);
plot3([nan,nan],[nan,nan],[nan,nan],'color',[1 0 1],'linewidth',2);

% Li(1,2,K);
Li(4,8,K, [0 1 0]); %flexible parts of the 8 bar
Li(6,10,K,[0 1 0]);
Li(5,9,K,[0 1 0]);
Li(7,11,K,[0 1 0]);

Li(13,15,K,[0 1 1]); %flexible part output/input
Li(14,16,K,[0 1 1]);

Li(18,20,K,[1 0 1]); %flexible part output/input
Li(19,21,K,[1 0 1]);

%rigidlines

Li(1,4,K,[0.4660 0.6740 0.1880]); %rigid part input/output
Li(1,6,K,[0.4660 0.6740 0.1880]);
Li(3,5,K,[0.4660 0.6740 0.1880]);
Li(3,7,K,[0.4660 0.6740 0.1880]);

Li(2,8,K,[0.4660 0.6740 0.1880]); %rigid part between flexible 8-bar
Li(2,9,K,[0.4660 0.6740 0.1880]);
Li(2,10,K,[0.4660 0.6740 0.1880]);
Li(2,11,K,[0.4660 0.6740 0.1880]);

Li(1,12,K,[0 0 1]); %rigid input/output shuttle
Li(12,15,K,[0 0 1]);
Li(12,16,K,[0 0 1]);
Li(15,16,K,[0 0 1]);

Li(3,17,K,[0.4940 0.1840 0.5560]); %rigid input/output shuttle
Li(17,20,K,[0.4940 0.1840 0.5560]);
Li(17,21,K,[0.4940 0.1840 0.5560]);
Li(20,21,K,[0.4940 0.1840 0.5560]);

for ii = 1:length(K)
    text(K(1,ii)-0.002,K(2,ii)-0.002,K(3,ii),num2str(ii),'Color','k','FontSize',12,'FontWeight','bold')
end

xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
axis equal;

lgd = legend('rigid input','rigid butterfly','rigid output','flexible input','flexible butterfly','flexible output','FontSize',14);

function [] = Li(x1,x2,K,color)
    
    plot3([K(1,x1),K(1,x2)],[K(2,x1),K(2,x2)],[K(3,x1),K(3,x2)],'Color',color,'LineWidth',2);
    hold on;
end
    

