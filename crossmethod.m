% y=crossmethod(binparents, pn, nbits, selector)
%binparents are the parents in binary
%pn is the population number
%nbits is the quantity of bits
%Selector is an integer number 1 One point crossover


function y=crossmethod(binparents, pn, nbits, selector)

switch selector
    case 1 %One point crossover
        for k=1:pn/4
            p=randi([2,nbits1-1]); %Crossover point
        
            binson(2*k-1,:)=[binparents(2*k-1,1:p) binparents(2*k,p+1:nbits)];
            binson(2*k,:)=[binparents(2*k,1:p) binparents(2*k-1,p+1:nbits)];
        end
        y=binson;

        case 2 %Two point crossover
        for k=1:pn/4
            p1=randi([2,nbits1-2]); %Crossover point
            p2=randi([p1,nbits1-1])
        
            binson(2*k-1,:)=[binparents(2*k-1,1:p1) binparents(2*k,p1+1:p2) binparents(2*k-1,p2+1:end)];
            binson(2*k,:)=[binparents(2*k,1:p1) binparents(2*k-1,p1+1:p2) binparents(2*k-1,p2+1:end)];
        end
        y=binson;

    case 3 %Uniform Method
        for k=1:pn/4
            for i=1:nbits
                c=rand();
                if c>=0.5
                    binson(2*k-1,:)= binparents(2*k-1,i);
                    binson(2*k,:)= binparents(2*k,i);
                else
                    binson(2*k-1,:)= binparents(2*k,i);
                    binson(2*k,:)= binparents(2*k-1,i);
                end
            end
        end
        y=binson;


    case 4 %Aditive Method
        decparents = bin2dec(binparents);
        for i=1:pn/2
            j = i+1;
            if j==pn/2+1
                j=1;
            end
            decson(i,1) = decparents(i)+decparents(j); %The sum
        end
        binson = dec2bin(decson,nbits+1);
        binson = binson(:,1:nbits);
        y=binson;

        
    
    otherwise
        disp('Select a diferent number')
    end
end