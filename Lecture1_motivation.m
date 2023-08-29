%Political Economy
%Lecture 1
%Does Political Economy matter?
%Code by: Laura Karpuska

%Colors
color1=(1/255)*[65, 105, 225]; %Royal Blue:
color2=(1/255)*[34, 139, 34]; %Forest Green
color3=(1/255)*[255, 165, 0]; %Orange
color4=(1/255)*[220, 20, 60]; %Crimson
colorgray=[.7 .7 .7];

%Parameters
Y=1; %size of the pie
beta=1; %intertemporal discount factor
xbar=0.01; %exogenous minimum consumption

%Grids
np=100;
prob=linspace(0,1,np); %probability of staying in power

nw=100;
omega_grid=linspace(0,1,nw);%Pareto weight

%Utility function
u=@(x) log(x);

%Planner's problem first-best
for i_w=1:nw
    omega=omega_grid(i_w);
    cA_fb(i_w)=omega;
    cB_fb(i_w)=Y-omega;

    if omega==0
        cA_fb(i_w)=xbar;
        cB_fb(i_w)=1-xbar;
    end

    if omega==1
        cA_fb(i_w)=1-xbar;
        cB_fb(i_w)=xbar;
    end

    UA_fb(i_w)=(1+beta)*u(cA_fb(i_w));
    UB_fb(i_w)=(1+beta)*u(cB_fb(i_w));

end

%Power alternation
%Politicians choose allocations under no (political) constraints
cAA_pol=1-xbar; %consumption of A when A is in power
cAB_pol=xbar; %consumption of A when B is in power
cBB_pol=1-xbar; %consumption of B when B is in power
cBA_pol=xbar; %consumption of B when A is in power

%A starts and stays in power with probability p
for i_p=1:np
    p=prob(i_p);
    UA_pol(i_p)=u(cAA_pol)+beta*p*u(cAA_pol)+beta*(1-p)*u(cAB_pol);
    UB_pol(i_p)=u(cBA_pol)+beta*p*u(cBA_pol)+beta*(1-p)*u(cBB_pol);
end


%Support
%Create a 45 degree (equity line)
for i_w=1:nw
if UA_fb(i_w)<UB_fb(i_w)
    UA_ff(i_w)=UA_fb(i_w);
    UB_ff(i_w)=NaN;
else
UA_ff(i_w)=NaN;
UB_ff(i_w)=UB_fb(i_w);
end
end

figure(1)
plot(UB_fb,UA_fb,'k', 'LineWidth', 3)
hold on
plot(UB_pol,UA_pol,'-','Color', color1, 'LineWidth', 3);
plot(UA_ff,UA_ff,':','Color', colorgray, 'LineWidth', 2);
hold off
xlabel('U^B')
title('U^A')
ylim([min(UA_fb(:)),max(UA_fb(:))])
xlim([min(UB_fb(:)),max(UB_fb(:))])
legend('Pareto Frontier','Political alternation','Equity line')