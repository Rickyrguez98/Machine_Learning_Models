clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

%% Data loading
load datos4.mat;

temp = BMV_24final(:,5);

window = 10;

for k=1:size(temp,1)-window
    data(:,k) = temp(k:k+window-1,1);
end

%% Data scaling
media=mean(data);
desviacion = std(data);

temp=bsxfun(@minus,data,media);
data=bsxfun(@rdivide,temp,desviacion);

%% Model creation
nn=10; %Number of neurons

net=competlayer(nn); %Define the kind of net
net.trainParam.epochs=100; %Setup the net( Number of epochs)
net=train(net,data); %Training

Wf= net.IW{1,1}';

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


figure(k+1);
subplot(2,1,1);
plot(BMV_24final(:,5));
subplot(2,1,2);
bar(Yc)