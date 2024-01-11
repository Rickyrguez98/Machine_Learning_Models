clear all;
close all;
clc;

data=xlsread('AirQualityUCI.xlsx','AirQualityUCI','C2:O9357');

X=data(:,1:10); %Input variables
Y=data(:,11:13); %Input variables


%% Partition
ndat=round(0.8*size(X,1));

%Train
Xtrain=X(1:ndat,:);
Ytrain=Y(1:ndat,:);

%Test
Xtest=X(ndat+1:end,:);
Xtest=X(ndat+1:end,:);

% Model Definition

net=feedforwardnet([10 10 10]);

net.trainFcn='trainlm'; %Levenberg-Marquart

net=train(net,Xtrain',Ytrain');

%Simulation

Yc=net(X'); %Simulating all

%Obtaining the cost
J=perform(net,Y',Yc) %Overall cost

J1=perform(net,Y(:,1)',Yc(1,:))

%% Prediction
Xnew=[2.5 1324 125 8.7 600 112 1000 95 1750 900]
net(Xnew')