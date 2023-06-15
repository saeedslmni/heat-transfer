
% The following differential equation shows the concentration differences in a catalyst particle. Using finite difference method to solve it (0<x<1)
% (1/x)*d/dx (x*dy/dx) - y = 0     
% B.C: 1) @x = 0 , dy/dx = 0  2) @x = 1 , y=1
clc
clear
close all
p=input("enter the number of divisions\n");%receive the number of divisions from the user
y_end=input("enter a number between 0 and 1 as the mole fraction of the absorbate on the surface of the catalyst\n");%receive the mole fraction of the absorbate on the surface of the catalyst from the user
x_end=input("enter the thickness of the catalyst\n");%receive the thickness of the catalyst from the user
y0=linspace(0,y_end,p+1);%initial guess (y0 is also used to keep last iteration values of vector 'y' in the loop 'while' to calculate errors)
dx=x_end/p;%calculate delta x
y=y0;%defining vector 'y' and initialize with y0 values because of the 'for' loop's format for calculating y in line 17
h=1;%to enter while loop
u=0;%initialize iteration counter with Zero
 while h>0%all unknown y values will be calculated untill the error tolerance reaches below 0.001%
    y0=y;%valuation y0 with the vector 'y' in last iteration
    y(1)=y(2);%boundary condition in derivative form (first boundary condition) 
    for w=2:p % 'w' is vector 'y' index
        x=(w-1)*dx;%updating the value of x
        y(w)=((dx/(2*x))*(y(w+1)-y(w-1))+y(w+1)+y(w-1))/(2+dx^2);%calculating vector 'y' cells
    end
    h=p;%valuation of 'h' to check all unknown y values in vector y (we have p+1 variables and p unknowns)
    e=(y0-y)./y;%calculating relative error for y vector
    for n=1:p%y values check list loop
       if abs(e(n))<0.00001 %comparing error values with the desired tolerance
           h=h-1;%each unknown error below 0.001% is eliminated from the list
       end
    end
    u=u+1;%counting iterations
 end
fprintf('y values=\n');%printing "y values=" for the user interfacing
disp(y);%printing y values
fprintf('number of iterations=\n');%printing "number of iterations=" for the user interfacing
disp(u);%printing number of iterations
x1=linspace(0,x_end,p+1);%defining x vector
plot(x1,y)%plot the y-x curve
xlabel('catalyst thickness (x)')% labeling the x direction
ylabel('mole fraction (y)')% labeling the y direction