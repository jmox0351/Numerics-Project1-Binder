%%%%%Stuart McDonald, Jacob Moxley flat plate project
%%%%F'''+1/2F*F''=0%%%%%%%

%%create a general matrix to hold the solution and define parameters
F = [];
h = 0.1;
%%apply initial conditions to F to kick off the for loop
%%initial condition for F
F(1,1) = 0;
%%initial condition for F'
F(2,1) = 0;
%%initial conditions for F'' this is the guess from the notes start the
F(3,1) = 0.332057; %%0.332057
%%build Eta values for F(eta), 
%%pdf notes as a guide go from [0,10]
a = 0;
b = 10;
eta = linspace(a,b,101);
%%functions for f
f1 = @(y2) y2; %kind of pointless easier to plug in values in for loop
f2 = @(y3) y3; %also kind of pointless
f3 = @(y1,y3) -1/2.*y1.*y3;
[r, l] = size(eta);
for i = 1:l-1
    k11 = h.*F(2,i);%h*f1(y2)
    k12 = h.*F(3,i);%h*f2(y3)
    k13 = h.*f3(F(1,i),F(3,i));%h*f3(y1,y3)
    k21 = h.*(F(2,i)+1/2.*k12);%hf1(y2+1/2k12)
    k22 = h.*(F(3,i)+1/2.*k13);%hf2(y3+1/2k12)
    k23 = h.*(f3(F(1,i)+1/2.*k11,F(3,i)+1/2.*k13));%hf3(y1+1/2k11,y3+1/2k13)
    k31 = h.*(F(2,i)+1/2.*k22); %hf1(y2+1/2k22)
    k32 = h.*(F(3,i)+1/2.*k23); %hf2(y3+1/2k23)
    k33 = h.*(f3(F(1,i),F(3,i)+1/2.*k23));%hf3(y1+1/2k21,y3+1/2k23)
    k41 = h.*(F(2,i)+k32);%hf1(y2+1/2k32)
    k42 = h.*(F(3,i)+k33);%hf2(y3+1/2k33)
    k43 = h.*(f3(F(1,i)+k31,F(3,i)+k33));%hf3(y1+k31,y3+k33)
    F(1,i+1) = F(1,i)+1/6.*(k11+2.*k21+2.*k31+k41);
    F(2,i+1) = F(2,i)+1/6.*(k12+2.*k22+2.*k32+k42);
    F(3,i+1) = F(3,i)+1/6.*(k13+2.*k23+2.*k33+k43);
end



Pr = 5; 

%%% system of odes %%
%G=g1
%equations needed
%G'=g2=g1'
%G''=g2'=-Pr/2FG'
g2dot = @(f,g2) -(Pr/2).*f.*g2;
G = [];
G(1,1) = 1;
G(2,1) = -0.576689; %also a guess


% for i = 1:l-1
%     k11 = h.*G(2,i);
%     k12 = h.*g2dot(F(1,i),G(2,i));
%     k21 = h.*(G(2,i)+1/2.*k12);
%     k22 = h.*(g2dot(F(1,i),G(2,i)+1/2.*k12));
%     k31 = h.*(G(2,i)+1/2.*k22);
%     k32 = h.*(g2dot(F(1,i), G(2,i) +1/2.*k22));
%     k41 = h.*(G(2,i)+k32);
%     k42 = h.*(g2dot(F(1,i), G(2,i) +k32));
%     G(1,i+1) = G(1,i)+1/6.*(k11+2.*k21+2.*k31+k41);
%     G(2,i+1) = G(2,i)+1/6.*(k12+2.*k22+2.*k32+k42);
%     
% end

for i = 1:l-1
    k11 = h.*F(2,i);%h*f1(y2)
    k12 = h.*F(3,i);%h*f2(y3)
    k13 = h.*f3(F(1,i),F(3,i));%h*f3(y1,y3)
    k14 = h.*G(2,i);%hf4(y5)
    k15 = h.*g2dot(F(1,i),G(2,i));%hf5(y1,y5)
    k21 = h.*(F(2,i)+1/2.*k12);%hf1(y2+1/2k12)
    k22 = h.*(F(3,i)+1/2.*k13);%hf2(y3+1/2k12)
    k23 = h.*(f3(F(1,i)+1/2.*k11,F(3,i)+1/2.*k13));%hf3(y1+1/2*k11,y3+1/2*k13)
    k24 = h.*(G(2,i)+1/2.*k15);%hf4(y5+1/2*k15)
    k25 = h.*(g2dot(F(1,i)+1/2.*k11,G(2,i)+1/2.*k15));%hf4(y1+1/2*k11,y5+1/2*k15)
    k31 = h.*(F(2,i)+1/2.*k22); %hf1(y2+1/2k22)
    k32 = h.*(F(3,i)+1/2.*k23); %hf2(y3+1/2k23)
    k33 = h.*(f3(F(1,i),F(3,i)+1/2.*k23));%hf3(y1+1/2k21,y3+1/2k23)
    k34 = h.*(G(2,i)+1/2.*k25);%hf4(y5+1/2k25)
    k35 =  h.*(g2dot(F(1,i)+1/2.*k21, G(2,i) +1/2.*k25));%hf5(y1+1/2k21+y5+1/2)
    k41 = h.*(F(2,i)+k32);%hf1(y2+1/2k32)
    k42 = h.*(F(3,i)+k33);%hf2(y3+1/2k33)
    k43 = h.*(f3(F(1,i)+k31,F(3,i)+k33));%hf3(y1+k31,y3+k33)
    k44 = h.*(G(2,i)+k35);%hf4(y5+k35)
    k45 = h.*(g2dot(F(1,i)+k31, G(2,i) +k35));%hf5(y1+k31,y5+k35)
    F(1,i+1) = F(1,i)+1/6.*(k11+2.*k21+2.*k31+k41);
    F(2,i+1) = F(2,i)+1/6.*(k12+2.*k22+2.*k32+k42);
    F(3,i+1) = F(3,i)+1/6.*(k13+2.*k23+2.*k33+k43);
    G(1,i+1) = G(1,i)+1/6.*(k14+2.*k24+2.*k34+k44);
    G(2,i+1) = G(2,i)+1/6.*(k15+2.*k25+2.*k35+k45);
end


plot(eta,F(1,:),eta,F(2,:),eta,F(3,:),eta,G(1,:),eta,G(2,:))


fun = @(t,y) [y(2);
              y(3);
              -1/2.*y(1).*y(3);
              y(5);
              -5/2.*y(1).*y(5)]; %system of differential equations
Y0 =[0 ;0;0.332057 ; 1;  -0.576689];%initial conditions
tspan = [0 10];%interval of integration
[T,Y]=ode45(fun,tspan,Y0);







