function [bestGenotype,best,average,worst] = MEA(nNeurons, biasrange, weightrange,stepsize,duration,initialforce,population,irate,mrate,numTourn)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here



genotypeLength = nNeurons*(nNeurons+1);
% population=50;
% irate = 0.5; %infection rate
% mrate = 0.05; %mutation rate
% numTourn = 3001; %number of tournaments


numGen = round(numTourn/population)+1;
fitnessall = zeros(numGen,population);
gen=1; %used for indexing
best = zeros(numGen,1); %will hold max fitness per generation
index = zeros(numGen,1); %will hold position of max fitness per generation
worst = zeros(numGen,1); %will hold max fitness per generation
indexworst = zeros(numGen,1); %will hold position of min fitness per generation
average = zeros(numGen,1);
variation = zeros(numGen,1);

bestGenotype = zeros(numGen,genotypeLength);

%creating initial array
genotypeArray = (rand(genotypeLength,population)-0.5)*2;
    %genotype will include continuous values between -1 and 1.  Scaling
    %will be done during the phenotype creation
% 
for event=1:numTourn
     a = randi([1 population]);
     b = randi([1 population]);
     genotypea = genotypeArray(:,a);
     genotypeb = genotypeArray(:,b);
    [fitnessa] = fitness(genotypea,biasrange,weightrange,nNeurons,stepsize,duration,initialforce);
    [fitnessb] = fitness(genotypeb,biasrange,weightrange,nNeurons,stepsize,duration,initialforce);

     if fitnessa>fitnessb
         winner = a;
         loser = b;
     else
         winner = b;
         loser = a;
     end

     for gene=1:genotypeLength
         if rand(1) < irate
             genotypeArray(gene,loser) = genotypeArray(gene,winner);
         end
         if rand(1) < mrate
             genotypeArray(gene,loser) = genotypeArray(gene,loser) + (rand(1)-0.5);
             if genotypeArray(gene,loser) > 1
                 genotypeArray(gene,loser)=1;
             elseif genotypeArray(gene,loser) < -1
                     genotypeArray(gene,loser)=-1;
             end
         end
     end
     if mod(event, population) ==1
         for p=1:population
             [fitnessall(gen,p)] = fitness(genotypeArray(:,p),biasrange,weightrange,nNeurons,stepsize,duration,initialforce);
         end
         [best(gen), index(gen)]= max(fitnessall(gen,:));
         [worst(gen), indexworst(gen)]= min(fitnessall(gen,:));
         bestGenotype(gen,:) = genotypeArray(:,index(gen));
         average(gen) = mean(fitnessall(gen,:));
         variation(gen) = var(sum(genotypeArray,1));
         gen = gen+1; %increment generation
     end
 end



end