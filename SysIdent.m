clc;
clear all;
N = 100;
SNR = -10;
SigAmp = 10;
NoiseAmp = exp(SNR/20)*SigAmp;
x = zeros(1,N);
xn = zeros(1,N);
noise = zeros(1,N);
for i=1:N
    x(i) = SigAmp*(rand-0.5);
    noise(i) = NoiseAmp*(rand-0.5);
    xn(i) = x(i) + noise(i);
end

%w0 = [0.26,0.96,0.26,0.30, 0.66 ];
w0 = [0.3,0.26,0.93,0.26,0.3];
p = 5;
y0 = zeros(1,N);
y0n = zeros(1,N);


a=buffer(x,p,p-1);
for i=1:N
    y0(i) = a(:,i)'*w0';
    y0n(i) = a(:,i)'*w0'+noise(i);
end

w1 = zeros(1,p);
y1 = zeros(1,N);
mu = 0.005;
e = zeros(1,N);
a1=buffer(xn,p,p-1);
for i=1:N
    y1(i) = a(:,i)'*w1';
    e(i) = y0n(i)-y1(i);
    w1 = w1+2*mu*e(i)*a(:,i)';
end
yf = zeros(1,N);
for i=1:N
    yf(i) = a(:,i)'*w1';
end
   

figure;
subplot(1,1,1);
plot(e);title('Convergence Charactristics for NSR = -10');

% figure;
% subplot(2,1,1);
% stem(w0);title('original weights');
% subplot(2,1,2);
% stem(w1);title('predicted weights');
% 
% figure;
% stem(y0,'*r','MarkerSize',4);hold on;
% stem(y1,'b','MarkerSize',10);title('comparison of outputs');





