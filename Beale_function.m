clear all; %Clear all variables
close all; %Close all windows
clc; %clean the command window

%% Parameteres

xmin1 = -4.5; %lower bound of the interval
xmax1 = 4.5; %upper bound of the interval

xmin2 = -4.5; %lower bound of the interval
xmax2 = 4.5; %upper bound of the interval

h1 = 0.005; %step size
qnumbers1 = ceil((xmax1-xmin1)/h1)+1; %Quantity of numbers
nbits1 = ceil(log2(qnumbers1)); % number of bits

h2 = 0.005; %step size
qnumbers2 = ceil((xmax2-xmin2)/h2)+1; %Quantity of numbers
nbits2 = ceil(log2(qnumbers2)); % number of bits

pn = 160; %population number

x1int = randi([0,2^nbits1-1],pn,1); %Initial population
x2int = randi([0,2^nbits2-1],pn,1); %Initial population

x1real = (xmax1-xmin1)/(2^nbits1-1)*x1int+xmin1; %transform integers into real
x2real = (xmax2-xmin2)/(2^nbits2-1)*x2int+xmin2; %transform integers into real


for i=1:10000 % Generations
    %Fitness function
    y = -((1.5-x1real+x1real.*x2real).^2+(2.25-x1real+x1real.*(x2real).^2).^2+...
        (2.65-x1real+x1real.*(x2real).^3).^2); %Beale function

    averagey(i) = mean(y); %avergae fitness

    chromosome = sortrows([y x1int x1real x2int x2real], 1, 'descend');

    %Selection (Ranking, Tournametn, Roulette)
    intparents1=chromosome(1:pn/2,2); %Integer parents by ranking
    binparents1=dec2bin(intparents1,nbits1); %Transform integers to binary

    intparents2=chromosome(1:pn/2,2); %Integer parents by ranking
    binparents2=dec2bin(intparents2,nbits2); %Transform integers to binary

    %% Crossover
% One point

%CROSSOVER FOR VARIABLE #1
for k=1:pn/4
    p=randi([2,nbits1-1]); %Crossover point

    binson1(2*k-1,:)=[binparents1(2*k-1,1:p) binparents1(2*k,p+1:nbits1)];
    binson1(2*k,:)=[binparents1(2*k,1:p) binparents1(2*k-1,p+1:nbits1)];
end

%CROSSOVER FOR VARIABLE #2
for k=1:pn/4
    p1=randi([2,nbits2-2]); %Crossover point1
    p2=randi([p1,nbits2-1]); %Crossover point1

    binson2(2*k-1,:)=[binparents2(2*k-1,1:p1) binparents2(2*k,p1+1:p2) binparents2(2*k-1,p2+1:nbits2)];
    binson2(2*k,:)=[binparents2(2*k,1:p1) binparents2(2*k-1,p1+1:p2) binparents2(2*k,p2+1:nbits2)];
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

      m=rand();
    
      %% Mutation for variable #2
    if m>=0.9
        son=randi([1,pn/2]);
        bit=randi(nbits2);
    
        if binson2(son,bit)=='1'
            binson2(son,bit)='0';
        else
            binson2(son,bit)='1';
        end
    end
    
    
    %% Generational Replacement (substitution)
    intson1=bin2dec(binson1);
    
    realson1=(xmax1-xmin1)/(2^nbits1-1)*intson1+xmin1; %Transform into real

    intson2=bin2dec(binson2);
    
    realson2=(xmax2-xmin2)/(2^nbits2-1)*intson2+xmin2; %Transform into real
    %Update variables
    
    x1int=[intparents1; intson1];
    x1real=[chromosome(1:pn/2,3); realson1];

    x2int=[intparents2; intson2];
    x2real=[chromosome(1:pn/2,5); realson2];
    end
    
    y = -((1.5-x1real+x1real.*x2real).^2+(2.25-x1real+x1real.*(x2real).^2).^2+...
        (2.65-x1real+x1real.*(x2real).^3).^2); %Beale function

    chromosome=[y x1int x1real x2int x2real];
    
    plot(averagey);
    
    [val, ind]=max(y);

    disp([ 'Results: x1= ' num2str(chromosome(ind, 3)) ' x2= ' num2str(chromosome(ind, 5)) ' y= ' num2str(-val)])
    
 