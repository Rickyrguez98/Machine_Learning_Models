clear all;
close all;
clc;

%% ERASE THIS SECTION

X=rand(100,1);
Y=-4+2*X-3*X.^2+X.^4; % Polynomial of grade 4

%% Minimum squares
n=size(X,1); %Amount of data

%Xa=[ones(n,1) X]; %Y=B+WX The form or shape of your model 
%Xa=[ones(n,1) X X.^2]; %Y=W0+W1X+W2X.^2
%Xa[sin(X) exp(-X) ones(n,1)]; %Y=W1*Sin(X)+W2*exp(-X)+W0

Xa=[ones(n,1)];
grade=4;

for k=1:grade
    Xa=[Xa X.^k];
    Wms=inv(Xa'*Xa)*Xa'*Y; %Weights by minimum squares
    Yc=Xa*Wms;  %Estimated Y
    E=Y-Yc; %Error
    J(k,1)=(E'*E)/(2*n); %Cost function
end

figure(1)
plot(J,'b')
figure(2)
plot(X,Y,'b.',X,Yc,'r.')


%% Second Method Downward gradient

n=size(X,1); %Amount of data
Xa=ones(n,1);
for k=1:grade
    Xa=[Xa X.^k];
end
Wdg=rand(size(Xa,2),1);

eta=1.2; % speed of convergence
for i=1:100000
    Yc_dg=Xa*Wdg; %Estimated Y
    E=Y-Yc_dg; %Error
    J(i,1)=(E'*E)/(2*n); %Cost function
    dJdW=-E'*Xa/n; %Gradient
    Wgd=Wdg-eta*dJdW';   
end

subplot(1,2,1)
plot(X,Y,'b.',X,Yc,'r.',X,Yc_dg,'g.')
subplot(1,2,2)
plot(J,'b.')

[Wms Wdg]