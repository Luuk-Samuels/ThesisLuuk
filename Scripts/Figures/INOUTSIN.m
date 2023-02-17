clear;
close all

%% This File can be used to plot Fig. S3, S4 and S5. 
% no other files are needed to run this

%% important parameters
niter = 6;
s1 = 0.9; %scaling from GA=2*s
s2 = 0.95;
s3 = 1.05;
s4 = 1.1;

%%

Dinsin = @(t) 1e-3*sin(2*pi*t);                 %Sinusoidal input signal [0-1]

sinp = @(t) 1e-3+1e-3*sin(4*pi*t+3/2*pi);       %ideal sin output

%% what is the ideal DD to get from sinusoidal-sinusoidal signal?
t = 0:0.00001:1;
Din = -0.001:0.00002:0.001;
DinIdeal = Dinsin(t);
DoutIdeal = sinp(t);

%% using the fitted curve as dd
%test linear stretching
idealsindd1GA1 = @(Din) s1*4e3*(cosh(Din)-1);
idealsindd1GA2 = @(Din) s2*4e3*(cosh(Din)-1);
idealsindd1GA3 = @(Din) s3*4e3*(cosh(Din)-1);
idealsindd1GA4 = @(Din) s4*4e3*(cosh(Din)-1);

% idealsindd2GA = @(Din) s*(opt2(1)+opt2(2)*sin(opt2(3)*pi*(Din-1e-3*(s-1))+opt2(4)));

idealsindd1 = @(Din) 4e3*(cosh(Din)-1);
idealsindd2 = @(Din) 4e3*(cosh(Din-1e-3)-1);



%% iteration of perfect sin
% niter = 6;
t = 0:0.00001:1;
Doutidealsin = zeros(niter,length(t));
DoutidealsinGA1 = zeros(niter,length(t));
DoutidealsinGA2 = zeros(niter,length(t));
DoutidealsinGA3 = zeros(niter,length(t));
DoutidealsinGA4 = zeros(niter,length(t));
for i = 1:niter
    if i == 1
        Doutidealsin(i,:) = iterations(Dinsin(t),(idealsindd1));
        DoutidealsinGA1(i,:) = iterations(Dinsin(t),(idealsindd1GA1));
        DoutidealsinGA2(i,:) = iterations(Dinsin(t),(idealsindd1GA2));
        DoutidealsinGA3(i,:) = iterations(Dinsin(t),(idealsindd1GA3));
        DoutidealsinGA4(i,:) = iterations(Dinsin(t),(idealsindd1GA4));
    else
        u1 = (max(DoutidealsinGA1(i-1,:))-0.002)/2;
        u2 = (max(DoutidealsinGA2(i-1,:))-0.002)/2;
        u3 = (max(DoutidealsinGA3(i-1,:))-0.002)/2;
        u4 = (max(DoutidealsinGA4(i-1,:))-0.002)/2;
        
        idealsindd2GA1 = @(Din) s1*4e3*(cosh(Din-1e-3-u1)-1); 
        idealsindd2GA2 = @(Din) s2*4e3*(cosh(Din-1e-3-u2)-1); 
        idealsindd2GA3 = @(Din) s3*4e3*(cosh(Din-1e-3-u3)-1); 
        idealsindd2GA4 = @(Din) s4*4e3*(cosh(Din-1e-3-u4)-1); 
        
        Doutidealsin(i,:) = iterations(Doutidealsin(i-1,:),(idealsindd2));
        DoutidealsinGA1(i,:) = iterations(DoutidealsinGA1(i-1,:),(idealsindd2GA1));
        DoutidealsinGA2(i,:) = iterations(DoutidealsinGA2(i-1,:),(idealsindd2GA2));
        DoutidealsinGA3(i,:) = iterations(DoutidealsinGA3(i-1,:),(idealsindd2GA3));
        DoutidealsinGA4(i,:) = iterations(DoutidealsinGA4(i-1,:),(idealsindd2GA4));
    end
end

%% To plot Fig. S3.
figure('Position', [0 0 1200 400])
t1 = tiledlayout(1,3,...
    'Padding','tight',...
    'tilespacing','tight');
title(t1, 'deviation of the geometrical advantage','FontWeight','bold','FontSize',14);
nexttile
hold on

plot(Din,idealsindd1GA1(Din),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(Din,idealsindd1GA2(Din),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(Din,idealsindd1(Din),'k','LineWidth',1.5);

plot(Din,idealsindd1GA3(Din),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(Din,idealsindd1GA4(Din),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);

title('displacement relation')
xlabel('u_{in} [m]');
ylabel('u_{out} [m]');
ylim([0 2.2e-3])

lgd = legend(['GA = ' num2str(s1*2)],['GA = ' num2str(s2*2)],'GA = 2',['GA = ' num2str(s3*2)],['GA = ' num2str(s4*2)]);
lgd.Location = 'north';
set(gca,'fontsize',14);
nexttile 
hold on 
title('2 concatenations');


plot(t, DoutidealsinGA1(2,:),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(t, DoutidealsinGA2(2,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(t, Doutidealsin(2,:),'k','LineWidth',1.5);

plot(t, DoutidealsinGA3(2,:),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(t, DoutidealsinGA4(2,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);

ylabel('u_{out} [m]');
xlabel('normalized cycle')
% lgd = legend('ideal sinusoidal GA = 2',['ideal sinusoidal GA = ' num2str(s*2)]);
set(gca,'fontsize',14);
nexttile 
hold on 
title('4 concatenations');

plot(t, DoutidealsinGA1(4,:),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(t, DoutidealsinGA2(4,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(t, Doutidealsin(4,:),'k','LineWidth',1.5);

plot(t, DoutidealsinGA3(4,:),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(t, DoutidealsinGA4(4,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);

ax=gca; ax.YAxis.Exponent = -3;

ylabel('u_{out} [m]');
xlabel('normalized cycle')
set(gca,'fontsize',14);
% lgd = legend('ideal sinusoidal GA = 2',['ideal sinusoidal GA = ' num2str(s*2)]);

export_fig('..\Writing\Images Supplemental\GA','-pdf','-transparent')


%% trying to add imperfection/ nonlinearity

%Let's only look at GA == 2 in this case.
b1 = -0.6;
b2 = -0.3;
b3 = 0.3;
b4 = 0.6;

imp11 = @(Din) 1e3*b1*Din.*(Din<=0)+b1-1e3*b1*Din.*(Din>0)+1;
imp12 = @(Din) 1e3*b2*Din.*(Din<=0)+b2-1e3*b2*Din.*(Din>0)+1;
imp13 = @(Din) 1e3*b3*Din.*(Din<=0)+b3-1e3*b3*Din.*(Din>0)+1;
imp14 = @(Din) 1e3*b4*Din.*(Din<=0)+b4-1e3*b4*Din.*(Din>0)+1;

imp21 = @(Din) -1e3*b1*(Din-1e-3).*(Din-1e-3<=0)-b1+1e3*b1*(Din-1e-3).*(Din-1e-3>0)+1;
imp22 = @(Din) -1e3*b2*(Din-1e-3).*(Din-1e-3<=0)-b2+1e3*b2*(Din-1e-3).*(Din-1e-3>0)+1;
imp23 = @(Din) -1e3*b3*(Din-1e-3).*(Din-1e-3<=0)-b3+1e3*b3*(Din-1e-3).*(Din-1e-3>0)+1;
imp24 = @(Din) -1e3*b4*(Din-1e-3).*(Din-1e-3<=0)-b4+1e3*b4*(Din-1e-3).*(Din-1e-3>0)+1;

sindd1imp1 = @(Din) idealsindd1(Din).*imp11(Din);
sindd1imp2 = @(Din) idealsindd1(Din).*imp12(Din);
sindd1imp3 = @(Din) idealsindd1(Din).*imp13(Din);
sindd1imp4 = @(Din) idealsindd1(Din).*imp14(Din);
 
sindd2imp1 = @(Din) idealsindd2(Din).*imp21(Din);
sindd2imp2 = @(Din) idealsindd2(Din).*imp22(Din);
sindd2imp3 = @(Din) idealsindd2(Din).*imp23(Din);
sindd2imp4 = @(Din) idealsindd2(Din).*imp24(Din);
% idealsindd2 = @(Din) (opt2(1)+opt2(2)*sin(opt2(3)*pi*(Din)+opt2(4)));

Doutsinimp1 = zeros(niter,length(t));
Doutsinimp2 = zeros(niter,length(t));
Doutsinimp3 = zeros(niter,length(t));
Doutsinimp4 = zeros(niter,length(t));
for i = 1:niter
    if i == 1
        Doutsinimp1(i,:) = iterations(Dinsin(t),sindd1imp1);
        Doutsinimp2(i,:) = iterations(Dinsin(t),sindd1imp2);
        Doutsinimp3(i,:) = iterations(Dinsin(t),sindd1imp3);
        Doutsinimp4(i,:) = iterations(Dinsin(t),sindd1imp4);
    else
        Doutsinimp1(i,:) = iterations(Doutsinimp1(i-1,:),sindd2imp1);
        Doutsinimp2(i,:) = iterations(Doutsinimp2(i-1,:),sindd2imp2);
        Doutsinimp3(i,:) = iterations(Doutsinimp3(i-1,:),sindd2imp3);
        Doutsinimp4(i,:) = iterations(Doutsinimp4(i-1,:),sindd2imp4);
    end
end

%% To plot Fig. S4
figure('Position', [0 0 1200 400])
t2 = tiledlayout(1,3,...
    'Padding','tight',...
    'tilespacing','tight');
title(t2, 'deviation of sinusoidality','FontWeight','bold','fontsize',14);
nexttile
hold on


plot(Din,sindd1imp1(Din),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(Din,sindd1imp2(Din),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(Din,idealsindd1(Din),'k','LineWidth',1.5);

plot(Din,sindd1imp3(Din),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(Din,sindd1imp4(Din),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);

title('displacement relation')
xlabel('u_{in} [m]');
ylabel('u_{out} [m]');
ylim([0 2e-3])
lgd = legend(['b = ' num2str(b1)],['b = ' num2str(b2)],'b = 1 (ideal)',['b = ' num2str(b3)],['b = ' num2str(b4)]);
%  lgd = legend(['b = ' num2str(b1)],'b = 1 (ideal)',['b = ' num2str(b4)]);
lgd.Location = 'north';
% lgd.Title.Interpreter = 'latex';
% lgd.Title.String = ['for u_{in} \leq 0: (1000u_{in}+1)b+1' 10 '   u_{in} > 0: (-1000u_{in}+1)b+1)'];
set(gca,'fontsize',14);
nexttile 
hold on 
title('2 concatenations');


plot(t, Doutsinimp1(2,:),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(t, Doutsinimp2(2,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(t, Doutidealsin(2,:),'k','LineWidth',1.5);

plot(t, Doutsinimp3(2,:),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(t, Doutsinimp4(2,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
ylim([0 2e-3])
xlim([0 0.5]);
ylabel('u_{out} [m]');
xlabel('normalized cycle')
% lgd = legend('ideal sinusoidal GA = 2',['ideal sinusoidal GA = ' num2str(s*2)]);
set(gca,'fontsize',14);
nexttile 
hold on 
title('4 concatenations');

plot(t, Doutsinimp1(4,:),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(t, Doutsinimp2(4,:),'Color',[0.3010 0.7450 0.9330],'LineWidth',1.5);

plot(t, Doutidealsin(4,:),'k','LineWidth',1.5);

plot(t, Doutsinimp3(4,:),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
plot(t, Doutsinimp4(4,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
ylim([0 2e-3])
xlim([0 0.5]);
ylabel('u_{out} [m]');
xlabel('normalized cycle')
set(gca,'fontsize',14);
% lgd = legend('ideal sinusoidal GA = 2',['ideal sinusoidal GA = ' num2str(s*2)]);

% export_fig('..\Writing\Images Supplemental\imp','-pdf','-transparent')

%% figure with input vs output showing Parity, Fig. S5

figure('Position', [0 0 800 400])
t2 = tiledlayout(1,2,...
    'Padding','tight',...
    'tilespacing','tight');
title(t2, 'parity','FontWeight','bold','Fontsize',14);

nexttile
hold on

title('input and output')
plot(t, DinIdeal,'Color',[0 0.4470 0.7410],'LineWidth',1.5);
plot(t,DoutIdeal,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);

xlabel('normalized cycle');
ylabel('u [m]');
lgd = legend('input','output');
lgd.Location = 'north';
set(gca,'fontsize',14);
nexttile
hold on

title('displacement relation')
fplot(idealsindd1,[-1e-3,1e-3],'Color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
fplot(idealsindd2,[0, 2e-3],'Color',[0.9290 0.6940 0.1250],'LineWidth',1.5);

xlabel('u_{in} [m]');
ylabel('u_{out} [m]');
lgd = legend('n = 1','n > 1');
lgd.Title.String = 'concatenation #';
lgd.Location = 'northeast';

ylim([0 2e-3]);
set(gca,'fontsize',14);
% export_fig('..\Writing\Images Supplemental\parity','-pdf','-transparent')

%% functions
function Dout = iterations(Din,dd)
    Dout = dd(Din);
end

function sse = sseval(c, DinIdeal,DoutIdeal)
    funeval = c(1) + c(2)*sin(c(3)*pi*DinIdeal+c(4));
    sse = sum((DoutIdeal-funeval).^2);
end