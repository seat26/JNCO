clear all
load data/Simulated_data
% show the raw data and  recurrent CNV and indiviual CNV of ground truth
figure
subplot(311)
imagesc(D',[-1,1]);
title('Raw')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(312)
imagesc(G',[-1,1]);
title('Recurrent CNV of ground truth')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(313)
imagesc(S',[-1,1]);
title('Individual CNV of ground truth')
ylabel('Sample Index');
xlabel('Probe Index');
D(isnan(D)) = 0;

alpha1 = 0.01;
alpha2 = 0.01;
beta2=0.3;
beta1 = beta2*3;
tol = 1e-3;

[G1,S1] = JNCO(D,alpha1,alpha2,beta1,beta2,tol);

% show the raw data and recurrent CNV and indiviual CNV of recoverying by JNCO
figure
subplot(311)
imagesc(D',[-1,1]);
title('Raw')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(312)
imagesc(G1',[-1,1]);
title('Recurrent CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(313)
imagesc(S1',[-1,1]);
title('Individual CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');

figure
[x,y]= ROC(abs(G1(:)), abs(G(:)) );
plot(x,y,'k-o','LineWidth',1 );
labeltext ={'JNCO'};
set(gcf,'PaperpositionMode','Auto') 
legend(labeltext,'Location','SouthEast');
xlabel('Specificity');
ylabel('Sensitivity');
title('ROC of recurrent CNV')

figure
[x,y]= ROC(abs(S1(:)), abs(S(:)) );
plot(x,y,'k-o','LineWidth',1 );
labeltext ={'JNCO'};
set(gcf,'PaperpositionMode','Auto') 
legend(labeltext,'Location','SouthEast');
xlabel('Specificity');
ylabel('Sensitivity');
title('ROC of individual CNV')
