clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

%% Parameters

xmin1=-40; %lower bound of the interval
xmax1=40; %upper bound of the interval

h1=0.05; %step size
qnumbers1=ceil((xmax1-xmin1)/h1)+1; %Quantity of numbers
nbits1=ceil(log2(qnumbers1)); %Number of bits

pn=16; %Population number

x1int=randi([0,2^nbits1-1],pn,1); %Initial population

x1real=(xmax1-xmin1)/(2^nbits1-1)*x1int+xmin1; %Transforming integers into real


for i=1:100 %Generations
%Fitness function
y=-(x1real+27.65).^2+40;
averagey(i)=mean(y); %Average fitness

cromosome=sortrows([y x1int x1real],1,'descend'); 

%Selection (Ranking, Tournament, Roulette)

intparents1=cromosome(1:pn/2,2); %Integer parents by ranking
binparents1=dec2bin(intparents1,nbits1); %Transform integers to binary
%% Crossover
% One point

for k=1:pn/4
p=randi([2,nbits1-1]); %Crossover point

binson1(2*k-1,:)=[binparents1(2*k-1,1:p) binparents1(2*k,p+1:nbits1)];
binson1(2*k,:)=[binparents1(2*k,1:p) binparents1(2*k-1,p+1:nbits1)];
end

%% Mutation

m=rand();

if m>=0.9
son=randi([1,pn/2]);
bit=randi(nbits1);

if binson1(son,bit)=='1'
binson1(son,bit)='0';
else
binson1(son,bit)='1';
end
end

%% Generational Replacement (substitution)
intson1=bin2dec(binson1);

realson1=(xmax1-xmin1)/(2^nbits1-1)*intson1+xmin1; %Transform into real
%Update variables

x1int=[intparents1; intson1];
x1real=[cromosome(1:pn/2,3); realson1];
end

y=-(x1real+27.65).^2+40;
cromosome=[y x1int x1real];

plot(averagey);

[val, ind]=max(y);

disp( ['Results: x1= ' num2str(cromosome(ind,3)) ' y=' num2str(val)])