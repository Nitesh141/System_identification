clc;

%                                              %
%                SIGNALS FOR TRAINING          %
%                                              %
N = 250;
A1 = 5;
A2 = 2;
A3 = 2;
f1 = 1/10;
f2 = 2/10;
f3 = 3/10;
n=1:N;

x = A1*sin(2*pi*f1*n) + A2*sin(2*pi*f2*n) + A3*sin(2*pi*f3*n);
d = 5*sin(2*pi*f1*n) ;

noise = zeros(1,N);
x1 = zeros(1,N);
for i=1:N
    noise(i) = (rand - 0.5);
    x1(i) = noise(i) + x(i);
end

figure;
subplot(4,1,1);
plot(x);title('Input signal');
subplot(4,1,2);
plot(noise);title('Noise Signal');                                            
subplot(4,1,3);
plot(x1);title('Noise+Input Signal');
subplot(4,1,4);
plot(d);title('Desired Signal');
%                                              %
%                 TRAINING                     %
%                                              %
mu = 0.0008;
h = zeros(10,1);
y = zeros(1,N);
e = zeros(1,N);
a=buffer(x1,10,9);
for i=1:N
    y(i) = a(:,i)'*h;
    e(i) = d(i)-y(i);
    h = h+2*mu*e(i)*a(:,i);
   
end
       
figure;
subplot(4,1,1);
plot(h);title('Weight vector');
subplot(4,1,2);
plot(e);title('Error Signal');                                            
subplot(4,1,3);
plot(y);title('Output Signal');
subplot(4,1,4);
plot(d);title('Desired Signal');
%                                              %
%                 TESTING                      %
%                                              %
T = 5*sin(2*pi*f1*n) + 6*sin(2*pi*2*f2*n) + 4*sin(2*pi*3*f3*n);
a1=buffer(x1,10,9);
y1 = zeros(1,N);
for i=1:N
    y1(i) = a(:,i)'*h;
end
figure;
subplot(2,1,1);
plot(T);title('Test signal');
subplot(2,1,2);
plot(y1);title('Output Signal');                                            

