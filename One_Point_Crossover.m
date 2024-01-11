clear all; %Erase all variables
close all; %Close all windows
clc; %clean the command window

np= 8; %population number
nbits = 8; %Number of bits

%1st step we create initial population with random numbers between 0-255
parents = randi([1,255],np,1);

for n=1:100 %Iteration or generations 
    %2nd step we calculate the fitness function
    y = parents.^2; 
    
    avey(n) = mean(y); %Average of the fitness
    
    chromosome = sortrows([y parents],1,'descend');
    
    intparents = chromosome(1:np/2,2); %Selection
    
    %binparents = de2bi(intparents, nbits)
    %online
    
    %on computer 
    binparents = dec2bin(intparents, nbits);
    
    %% Crossover
    % one point crossover
    for k=1:np/4
        cp = randi([2, nbits-1]); %crossover point
        binson(2*k-1,:)= [binparents(2*k-1, 1:cp) binparents(2*k, cp+1:nbits)];
        binson(2*k,:)= [binparents(2*k, 1:cp) binparents(2*k-1, cp+1:nbits)];
       
    end
    

    %% Mutation
    r = rand();

    if r>=0.85 % 15% chance of mutate
        son = randi([1, np/2]); %Son at random
        bit = randi(nbits); % bit at random

        if binson(son, bit)=='1'
            binson(son, bit)='0';

        else
            binson(son, bit)='1';
        end
    end

    intsons = bin2dec(binson);
    
    %Next generation (substitution)
    parents = [intparents; intsons];
end

plot(avey)
max(y)

