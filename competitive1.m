clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

%% Data loading
load datos1.mat

data=datos1;

plot(data(1,:),data(2,:),'.');


nn=4; % Number of neurons

prom = mean(data,2); %mean of rows

W=prom*ones(1,nn); % initial weights

W0=W; %Initial weights
eta=0.01; %speed
for nepochs=1:35
    for k=1:size(data,2)
        for j=1:nn
            dist(1,j)=sum(data(:,k)-W(:,j)).^2; % Distance squared
        end
        [val,ind]=min(dist); %Minimum distance
        
        %Update the weights
        W(:,ind)=W(:,ind)+eta*(data(:,k)-W(:,ind));
    end
end
Wf=W; %final Weights

plot(data(1,:),data(2,:),'b.',W0(1,:),W0(2,:),'r.',Wf(1,:),Wf(2,:),'rp')