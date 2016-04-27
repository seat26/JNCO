clear all
load data/aCGH_Pollack_chr17.mat

D(isnan(D)) = 0;
[m,n] = size(D);

alpha1 = 4;
alpha2 = alpha1;
beta2=0.2;
beta1 = beta2*3.3;
tol = 1e-3;

[G,S] = JNCO(D,alpha1,alpha2,beta1,beta2,tol);

Th=0.15;  
figure
subplot(411)
imagesc(G',[-1,1]);
title('Recurrent CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(413)
imagesc(S',[-1,1]);
title('Individual CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');
gain = sum(G>Th,2);
loss = sum(G<-Th,2);
subplot(412)
axis([1,382,-44,44]);
hold on
box on
bar(gain,1,'r','EdgeColor','none'); 
bar(-loss,1,'b','EdgeColor','none');
title('Recurrent frequency of JNCO')
ylabel('Frequency');
xlabel('Probe Index');
hold off
subplot(414)
gain = sum(S>Th,2);
loss = sum(S<-Th,2);
axis([1,382,-10,10]);
hold on
box on
bar(gain,1,'r','EdgeColor','none'); 
bar(-loss,1,'b','EdgeColor','none');
title('Individual frequency of JNCO')
ylabel('Frequency');
xlabel('Probe Index');
hold off

