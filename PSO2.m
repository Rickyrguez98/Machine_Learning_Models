clear all;
close all;
clc;

%% Parameters
% Population
pn=500; %Particle number
% Random swarm

x1p=rand(pn,1) + 7.4; %Initial positions
x2p=rand(pn,1) + 4.59; %Initial positions

x1Lp=x1p; %Initial local positions
x1gp=0; %Initial global position

x2Lp=x2p; %Initial local positions
x2gp=0; %Initial global position

vx1=zeros(pn,1); %Initial velocity
vx2=zeros(pn,1); %Initial velocity

fxgp=10000000; %Performance in the best global
fxLp=ones(pn,1)*fxgp; %Performance of the best locals

c1=0.5; % Convergence speed to the local
c2=0.5; % Convergence speed to the global

a = 100; %Penalty constant
for k=1:1000 %Iterations or generations
    fx= 0.4*x1p+0.5*x2p + a*max(0.3* x1p + 0.1* x2p - 2.7 , 0) + a*abs(0.5*x1p+0.5*x2p-6)+...
        a*max(6-0.6*x1p -0.4*x2p, 0) + a*max(-x1p, 0) + a*max(-x2p, 0); %Fitness function

    [val,ind]=min(fx); %Minimum value of fx and its position
    
    % Update the global info
    if val<fxgp
        fxgp=val; %New best global performance
        x1gp=x1p(ind,1); %New global position
        x2gp=x2p(ind,1); %New global position
    end

    % Update the local info
    for i=1:pn
        if fx(i,1)<fxLp(i,1)
            fxLp(i,1)=fx(i,1); %Update local performances
            x1Lp(i,1)=x1p(i,1); %Update local positions
            x2Lp(i,1)=x2p(i,1); %Update local positions
        end

    end

    %% ERASE this PLOT
    plot(x1p,x2p,'rx',x1gp,x2gp,'go',0,0,'b.'); %swarm plot
    axis([-5 10 -5 10]);
    title(['x1gp= ' num2str(x1gp) ' x2gp= ' num2str(x2gp)])
    pause(0.1); %Simulate the movement

    %% New position and speed
    vx1=vx1+c1*rand()*(x1Lp-x1p)+c2*rand()*(x1gp-x1p); %New velocity
    vx2=vx2+c1*rand()*(x2Lp-x2p)+c2*rand()*(x2gp-x2p); %New velocity

    x1p=x1p+vx1; %New position
    x2p=x2p+vx2; %New position

    fx= 0.4*x1p+0.5*x2p; %Fitness without restrictions

    [fxgp x1gp x2gp]

end