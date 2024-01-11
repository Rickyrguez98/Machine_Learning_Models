clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

load data1.txt;

data=data1;

X=data(:,1:2);
Y=data(:,3);

net=feedforwardnet(5);
net.trainFcn='trainrp';
net=train(net,X',Y');

Yc=net(X');
Yc=round(Yc);

G0=data(data(:,3)==0,1:2);
G1=data(data(:,3)==1,1:2);

G0s=data(Yc<=0.5,1:2);
G1s=data(Yc>=0.5,1:2);

plot(G0(:,1),G0(:,2),'bo',G1(:,1),G1(:,2),'rx')
hold on
plot(G0s(:,1),G0s(:,2),'go',G1s(:,1),G1s(:,2),'kx')
hold off