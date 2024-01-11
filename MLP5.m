clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window


%% Data laoding
%data = xlsread('Iris.xlsx','PartB','A1:E150');
data = xlsread('dna.xlsx','data','A2:H6701');

%X=data(:,1:4);
%Y=data(:,5);
X=data(:,2:end);
Y=data(:,1);


%% Partition
cv = cvpartition(Y,'holdout',0.15);
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv),:);

%Datos de prueba
Xtest = X(test(cv),:);
Ytest = Y(test(cv),:);



%% Model creation
net=feedforwardnet(5); %structure

net.trainFcn='trainrp'; %Training

net=train(net,X',Y'); % Transpose


%% Simulation
Yc=net(X');
Yc=round(Yc);
Yc= Yc'; % In a column orientation

a=confusionmat(Y,Yc);
confusionchart(a)






