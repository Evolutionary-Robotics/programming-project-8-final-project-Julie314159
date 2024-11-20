%% Julie Hasler

nNeurons = 7;
biasrange=5;
weightrange=5;
stepsize = 0.1;
duration = 20;
initialforce = 0.01;

population=50;
irate = 0.5; %infection rate
mrate = 0.05; %mutation rate
numTourn = 5001;

[bestGenotype,best,average,worst] = MEA(nNeurons, biasrange, weightrange,stepsize,duration,initialforce,population,irate,mrate,numTourn);

%%

gensize = (numTourn-1)/population +1;
genotype = bestGenotype(1,:);
[calcfitnessfirst,cartpoledatafirst] = fitness(genotype.',biasrange,weightrange,nNeurons,stepsize,duration,initialforce);
genotype = bestGenotype(gensize,:);
[calcfitnesslast,cartpoledatalast] = fitness(genotype.',biasrange,weightrange,nNeurons,stepsize,duration,initialforce);

t=stepsize:stepsize:duration;
figure(1);
plot(t,cartpoledatalast(:,1),t,cartpoledatalast(:,3),t,cartpoledatalast(:,4),t,cartpoledatalast(:,5));
legend('X','Cos(\theta)','theta','Force','Location','southwest');
figure(2);
plot(t,cartpoledatafirst(:,1),t,cartpoledatafirst(:,3),t,cartpoledatalast(:,4),t,cartpoledatafirst(:,5));
legend('X','Cos(\theta)','theta','Force','Location','southwest');
%k=1:1:indexlast;
%plot(k,calcfitness)

figure(3);
gen=1:1:gensize;
plot(gen, best,gen,average,gen,worst);
legend('Best','Average','Worst','Location','southeast');
title("Fitness across generations");
xlabel("Generation");
ylabel("fitness");