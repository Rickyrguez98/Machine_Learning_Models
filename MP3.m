clear all;
close all;
clc;

%% Data Loading
load datos4.mat;

data=IPCfinal(:,5);

ndelays=3; %Number of delays;
fdays=4; %How many days into the future

temp=[];

for k=0:ndelays+fdays-1
    temp(:,k+1)=data(ndelays+fdays-k:end-k);
    
end

Y=temp(:,1:fdays)'; %Output (Newest data)
X=temp(:,fdays+1:end)'; %Input 

% Partition
ndat=round(0.9*size(X,2));

Xtrain=X(:,1:ndat);
Ytrain=Y(:,1:ndat);

% Model creation
net=feedforwardnet(10);
net.trainFcn='trainlm';
net=train(net,Xtrain,Ytrain);

% Simulation
Yc=net(X); %Train and Test

for k=1:fdays
    subplot(fdays,1,k)    
    plot(1:size(Y,2),Y(k,:),'b-',1:size(Yc,2),Yc(k,:),'r-')
    grid;
    title(['IPC(t+' num2str(fdays-k+1) ' ) '])
    
end

37028
3.6991e+04

net([37027 36991 37028]')