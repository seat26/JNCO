
function [x,y] = ROC( predict, ground_truth)
pos_num = sum(ground_truth==1);
neg_num = sum(ground_truth==0);
m=size(ground_truth,1);
[pre,Index]=sort(predict);
tx=ground_truth(Index);
X=zeros(m+1,1);
Y=zeros(m+1,1);
X(1)=1;
Y(1)=1;
labels=pre;
labels=unique(pre);
ll=length(labels);
i=1;
for K=2:1:ll
    i=i+1;
    TP(i)=length(tx(tx(:)==1 & pre(:)>labels(K)));
    FP(i)=length(tx(tx(:)==0 & pre(:)>labels(K)));
    FN(i)=length(tx(tx(:)==1 & pre(:)<=labels(K)));
    TN(i)=length(tx(tx(:)==0 & pre(:)<=labels(K)));
    X(i)=FP(i)/neg_num;
    Y(i)=TP(i)/pos_num;
end;
x=zeros(size(X));
y=zeros(size(Y));
x(1)=X(1);
y(1)=Y(1);
a=x(1);
b=y(1);
t=2;
for i=1:size(X)
    if (X(i)-a)*(X(i)-a)+(Y(i)-b)*(Y(i)-b)>=0.006 
        a=X(i);
        b=Y(i);
        x(t)=a;
        y(t)=b;
        t=t+1;
    end
end
x(t)=X(size(X,1));
y(t)=Y(size(Y,1));

n=size(x)/30;
end