function [G,S] = JNCO(Y,alpha1,alpha2,beta1,beta2,tol)
% min_B 0.5||Y-G-S||^2 + alpha_1 ||G||TV + alpha_2 ||S||_TV + beta1||G||_21 + beta2 ||S||_1 

G=zeros(size(Y));
S=zeros(size(Y));
Z=zeros(size(Y));
X=zeros(size(Y));
R1=zeros(size(Y));
R2=zeros(size(Y));
T=zeros(size(Y));

G1=zeros(size(Y,1)-1,size(Y,2));
G2=zeros(size(Y,1)-1,size(Y,2));
rho1=norm(Y(:))/10;
rho2=norm(Y(:))/10;
[d,n]=size(Y);
maxIter=2000;
th=0;

disp('start running!.....')


a=alpha1;
b=alpha2;

for iter=1:maxIter
    yy=iter;
% 1 update G
    G=R1/rho1;
    G=Z-G;
    G=rho1*G;
    G=Y+G;
    G=G-S;
    T=G/(1+rho1);
    r=beta1/(1+rho1);
    for i=1:d
        t=sqrt(T(i,:)*T(i,:)');
        G(i,:)=(-r/(t+eps)+1)*T(i,:);
    end
    
   
  %  disp('runing 1 ');
% 3 update Z
    Zold=Z;
 
    for j=1:size(Z,2)
        v=G(:,j)+R1(:,j)/(rho1+eps);
        g=G1(:,j);
        gradient_v = drond1(g) ;
        par1=1.0/(1+a*norm(gradient_v));
        
     %   par1 =  1./(1+alpha1*abs(gradient_v));
        [Z(:,j),G1(:,j)]=flsa(v,g,0,par1/(rho1+eps),length(v),100,1e-10,1,6);
    end
   % disp('runing 2');
% 4 update X
    Xold=X;
    for j=1:size(X,2)
        v=S(:,j)+R2(:,j)/(rho2+eps);
        g=G2(:,j);
        gradient_v = drond1(g);
       par1=1.0/(1+b*norm(gradient_v));
        % par1 =  1./(1+alpha2*abs(gradient_v)); 
        
        [X(:,j),G2(:,j)]=flsa(v,g,0,par1/(rho2+eps),length(v),100,1e-10,1,6);
    end
   % disp('runing 3 ');
% 2 update S
    S=((Y-G+rho2*(X-R2/rho2))/(1+rho2));
    S=sign(S).*max(abs(S)-beta2/(1+rho2),0);
   % disp('runing 4');
% 5 update R1
    R1old=R1;
    R1=R1+rho1*(G-Z);
    
% 6 update R2
    R2old=R2;
    R2=R2+rho2*(S-X);
   % disp('runing 5 ');
% 7 check
    PR1=norm(G(:)-Z(:));
    PR2=norm(S(:)-X(:));
    DR1=rho1*norm(Z(:)-Zold(:));
    DR2=rho2*norm(X(:)-Xold(:));
    fprintf('iter %d PR1=%f PR2=%f DR1=%f  DR2=%f rho1=%f rho2=%f  \n',iter ,PR1,PR2,DR1,DR2,rho1,rho2);
    th=norm(Y(:))*tol;
     if PR1 <th && PR2 <th && DR1<th && DR2<th &&norm(R1(:)-R1old(:))<th &&norm(R2(:)-R2old(:))<th
         break;
     end
     
% 8 update rho1
    if PR1>20*DR1
        rho1=2*rho1;
    elseif DR1>20*PR1
        rho1=rho1/2;
    else
    end
    
% 9 update rho2
    if PR2>20*DR2
        rho2=2*rho2;
    elseif DR2>20*PR2
        rho2=rho2/2;
    else
    end
    
end
disp('end.....');
end

function d=drond1(im)
d=zeros(size(im));
d(1:end-1)=im(2:end)-im(1:end-1);
d(end)=im(1)-im(end);
end