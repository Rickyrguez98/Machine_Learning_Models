clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

%% Data loading
load datos2.mat

data=datos2;

%% Model creation
nn=6; %Number of neurons

net = competlayer(nn); %Create the net
net.trainParam.epochs=100; %Model setup
net = train(net,data); %model training

Wf= net.IW{1,1}'; %final weights

%plot(data(1,:),data(2,:),'b.',Wf(1,:),Wf(2,:),'rp') %plot2d
plot3(data(1,:),data(2,:),data(3,:),'b.',Wf(1,:),Wf(2,:),Wf(3,:),'rp')

%% Model Simulation
Yc= net(data);
Yc= vec2ind(Yc);
groups= unique(Yc)

for k=1:size(groups,2)
    temp = data(:,Yc==groups(1,k));
    eval(sprintf('group%d=temp;',groups(1,k)));
end

