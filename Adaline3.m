clear all;
close all;
clc;

%% Data loading
data=downloadValues('CMG','03/10/2015','03/10/2016','d','history') % La 'd' es para daily

prices=data.AdjClose;

X=[];
delays=1;

for k=0:delays
    X=[X,prices(delays+1-k:end-k)];
end

% Define X* and Y
Y=X(:,1); %The output
Xa=[ones(size(X,1),1) X(:,2:end)]; % The form

%% Partition of the dataset
ntrain=round(0.6*size(Xa,1)); %Number of elements for training

Xatrain=Xa(1:ntrain,:);
Ytrain=Y(1:ntrain,:);

Xatest=Xa(ntrain+1:end,:);
Ytest=Y(ntrain+1:end,:);


% Trading the model
Wms=inv(Xatrain'*Xatrain)*Xatrain'*Ytrain; %Minimum squares

Yc=Xa*Wms

Yc_rec=Xatrain*Wms; %Simulation of the data known 

Xtemp=Xatrain(end,:);

for k=ntrain+1:size(Xa,1)
    Xtemp=[1 Yc_rec(k-1,1) Xtemp(:,2:end-1)];
    Yc_rec(k,1)=Xtemp*Wms; %Prediction
end 

plot([1:size(Y,1)]',Y,'b-',...
    [1:size(Yc,1)]',Yc,'r-',...
    [1:size(Yc_rec,1)]',Yc_rec,'g-')