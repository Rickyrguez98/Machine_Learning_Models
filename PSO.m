clear all;
close all;
clc;

%% Erase section
x=-10:0.01:10;
y=10+x.^2-15*cos(3*x);

%% Parameters
% Population
pn=50; %Particle number
% Random swarm

x1p=rand(pn,1); %Initial positions

x1Lp=x1p; %Initial local positions
x1gp=0; %Initial global position

vx1=zeros(pn,1); %Initial velocity

fxgp=10000000; %Performance in the best global
fxLp=ones(pn,1)*fxgp; %Performance of the best locals

c1=1.2; % Convergence speed to the local
c2=1.2; % Convergence speed to the global

for k=1:100 %Iterations
    fx=10+x1p.^2-15*cos(3*x1p) %Fitness function

    [val,ind]=min(fx); %Minimum value of fx and its position
    % Update the global info
    if val<fxgp
        fxgp=val; %New best global performance
        x1gp=x1p(ind,1) %New global position
    end

    % Update the local info
    for i=1:pn
        if fx(i,1)<fxLp(i,1)
            fxLp(i,1)=fx(i,1); %Update local performances
            x1Lp(i,1)=x1p(i,1); %Update local positions
        end

    end

    %% ERASE this PLOT
    plot(x,y,'b-',x1p,fx,'rx',x1gp,fxgp,'go'); %swarm plot
    axis([-10 10 -20 120]);
    title(['x1gp=' num2str(x1gp)])
    pause(0.1); %Simulate the movement

    %% New position and speed
    vx1=vx1+c1*rand()*(x1Lp-x1p)+c2*rand()*(x1gp-x1p); %New velocity

    x1p=x1p+vx1; %New position

end