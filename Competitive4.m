clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

load datos4.mat;

for k=1:35
    eval(sprintf('data(:,k)=BMV_%dfinal(:,5);',k));
end

%% Data scaling
media=mean(data);
desviacion = std(data);

temp=bsxfun(@minus,data,media);
data=bsxfun(@rdivide,temp,desviacion);

%% Model creation

nn=6; %Number of neurons

net=competlayer(nn); %Define the kind of net
net.trainParam.epochs=100; %Setup the net( Number of epochs)
net=train(net,data); %Training

Yc=net(data);
Yc=vec2ind(Yc);
groups=unique(Yc);

% Group creation
for k=1:size(groups,2)
    temp=data(:,Yc==groups(1,k));
    eval(sprintf('group%d=temp;',groups(1,k)));
    figure(k)
    eval(sprintf('plot(group%d);',groups(1,k)));
end

