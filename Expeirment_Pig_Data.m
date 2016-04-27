clear all
load data/Wang
D=data;
[m,n] = size(D);

alpha1 = 0.2;
alpha2 = alpha1;
beta2=0.3;
beta1 = beta2*2;
tol = 1e-3;

[G,S] = JNCO(D,alpha1,alpha2,beta1,beta2,tol);

Th = 0.15
figure(1)
subplot(411)
imagesc(G',[-1,1]);
title('Recurrent CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');
;

subplot(412)
hold on;
box on;
axis([1,3766,-12,12])
gain = sum(G>Th,2);
loss = sum(G<-Th,2);
bar(gain,1,'r','EdgeColor','none'); 
bar(-loss,1,'b','EdgeColor','none');
title('Recurrent frequency of JNCO')
ylabel('Frequency');
xlabel('Probe Index');
hold off;

subplot(413)
imagesc(S',[-1,1]);
title('Individual CNV of JNCO')
ylabel('Sample Index');
xlabel('Probe Index');
subplot(414)
axis([1,3766,-12,12])
gain = sum(S>Th,2);
loss = sum(S<-Th,2);
hold on;
box on;
bar(gain,1,'r','EdgeColor','none'); 
bar(-loss,1,'b','EdgeColor','none');
title('Individual frequency of JNCO')
ylabel('Frequency');
xlabel('Probe Index');
hold off;