clc
clear
close all
p=input("tedad taghsimat ra dar rastaye shoaee vared konid\n");
q=input("tedad taghsimat ra dar rastaye tooli vared konid\n");
t1=input("damaye ebtedaye loole ra dar meghyas celcius vared konid\n");
t2=input("damaye entehaye loole ra dar meghyas celcius vared konid\n");
t3=input("damaye sat'h loole ra dar meghyas celcius vared konid\n");
Q=input("heat flux ra dar system S.I. vared konid\n");
% T0= hadse avaliye hadse avaliye baraye Gauss Seidel ya meghdar ghabli mohasebeh shodeh
% baray check kardan khata nesbat be tolerrance
T0=ones(q+1,p+1);
T0(:,end)=t3;
for z=1:p
T0(:,z)=linspace(t1,t2,q+1);
end
T1=T0;
h=1;
while h>0
    T0=T1;
    for y=2:q
        for w=2:p
             T1(y,w)=(T1(y+1,w)+T1(y-1,w)+T1(y,w+1)+T1(y,w-1))/4;
        end
    end
   h=(q-1)*(p-1);
    e=T1-T0;
    for m=2:q
        for n=2:p
            if e(m,n)<0.1
                h=h-1;
            end
        end
    end
end
fprintf('T1=\n');
disp(T1)
dr=0.1/p;
dz=0.4/q;
T=T1;
h=1;
u=0;
while h>0
    T1=T;
    for i=2:q
     T(i,1)=(dr^2*dz^2/(2*(dz^2+dr^2)))*(T(i,2)*2/(dr^2)+(T(i-1,1)+T(i+1,1))/(dz^2)+Q/(235+5.5*T(i,1)));
     %moadeleye damaye mehvar ba taghrib rond be delta
    end
    for y=2:q
        for w=2:p
            r=(w-1)*dr;
             T(y,w)=(dr^2*dz^2/(2*(dz^2+dr^2)))*((dr+2*r)*T(y,w+1)/(2*r*dr^2)+(T(y+1,w)+T(y-1,w))/dz^2+(2*r-dr)*T(y,w-1)/(2*r*dr^2)+Q/(235+5.5*T(y,w)));
             u=u+1;
        end
    end
    h=(p+1)*(q+1);
    e=T-T1;
    for m=1:q+1
        for n=1:p+1
            if e(m,n)<0.1
                h=h-1;
            end
        end
    end
end
fprintf('T=\n');
disp(T);
z1=linspace(0,0.4,q+1);
r1=linspace(0,0.1,p+1);
surf(r1,z1,T)