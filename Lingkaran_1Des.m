% --------------------------
% Penentuan Hiposenter dan episenter
% Metode 3 Lingkaran
% --------------------------
clear all
clc

%% INPUT
% Data Stasiun
x = [792.501 735.155 773.949]; % Data Stasiun posisi x
y = [9174.521 9191.425 9215.570]; % Data Stasiun posisi y
z = [0.615 0.589 0.1090]; % Data Stasiun posisi z
r = [33.02 39.53 26.51];
Color='k';
N = 256; % Number of side
theta = linspace(0,2*pi,N)';
figure(1)
plot(x,y,'v');
hold on;

%%
for i=1:length(x)
    X = cos(theta)*r(i)+ones(N,1)*x(i);
    Y = sin(theta)*r(i) + ones(N,1)*y(i);
    figure(1)
    plot(X,Y);
    axis equal
    hold on
    if i~=length(x)
        b(i,:) = ((r(i))^2-(r(i+1))^2)-((x(i))^2-x((i+1))^2)-((y(i))^2-(y(i+1))^2);
        c(i,:) = [(x(i)-x(i+1))*-2 (y(i)-y(i+1))*-2];
    else if i==length(x)
            b(i,:) = ((r(i))^2-(r(i-2))^2)-((x(i))^2-x((i-2))^2)-((y(i))^2-(y(i-2))^2);
            c(i,:) = [(x(i)-x(i-2))*-2 (y(i)-y(i-2))*-2];
        end
    end
end
A = lsqr(c,b)
figure(1)
plot(A(1),A(2),'or');
hipo=sin(acos(sqrt((A(1)-x(1))^2+(A(2)-y(1))^2)/r(1)))*r(1)+z(2)
figure(2)
plot3(x,y,z,'v');
set(gca,'zdir','reverse');
grid on
hold on
plot3(A(1),A(2),hipo,'*k')

%% Naming Figure
figure(1)
title('3-circle Method Map View');
xlabel('UTM Easting (km)');
ylabel('UTM Northing (km)');
figure(2)
title('3-circle Method 3D View');
xlabel('UTM Easting (km)');
ylabel('UTM Northing (km)');
zlabel('Depth (km)');