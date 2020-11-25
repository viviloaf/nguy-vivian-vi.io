function [ ] = Graham_Hodge_Nguyen_Fluid_Calculator_Final_Project1_ME1311_003( )
%Group Project, Phase 1 single variable
%   %   Vinh Nguyen, Akil Hodge, Frederic Graham
%test values
%e= 45.72nm, roughness of pipe
%D=6 cm, diameter of pipe
%l=30m, length of pipe
%meu = 1.002x10^-3 , dynamic viscosity
%v = 1.004x1-^-6 , kinematic viscosity
%v_bulk - .1 m/s
%rho = meu/v kg/m^3= density of liquid (water) (is about 1)
%P_i = 200 pressure (KPa) convert to pa
%delta_p=
%Q_i=.0001 m^3 /s
%f = friction factor
%g = 9.81
clc
clear all
close all
%==========================================================================    
% User Inputs
disp('This program was coded by, Frederic Graham, Akil and Vinh Nguyen'); disp(' ');
disp('This program is the first phase of the final project');
disp('As a test measure, we have included test values that can be viewed inside the code');
disp('If not, the program will prompt you for inputs');
[Y,y]=deal(1);
[N,n]=deal(0);
user_input=input('Do you want to use predefined test values? Enter Y/N: ');
if user_input==1
    e=4.572e-8;
    D=.06;
    l=30;
    meu=1.002e-3;
    v=1.004e-6;
    rho=meu/v;
    Q_i=10e-8;
    p_i=200;
    p_i_conv=p_i*1000;
elseif user_input==0
    Q_i=input('Please input the intial flow rate: ')
    e=input('Please input the absolute roughness of the pipe in meters: ')
    D=input('Please input the diameter of the pipe in meters: ')
    v=input('Please input the kinematic viscosity in m^2/s: ')
    meu=input('Please input the dynamic viscosity in pa*s: ')
    l=input('Please input the length of the pipe in meters: ')
    p_i=input('Please input the entry pressure in K-pascals: ')
else
    disp('Please Input values. The function will restart in 5 seconds.')
    pause(5)
    Graham_Hodge_Nguyen_Fluid_Calculator_Final_Project1_ME1311_003;    
end
%==========================================================================    
% Function Inputs
g=9.81;
delta_Q=10e-9;
r=D/2;
a=pi*(r^2);
v_bulk=Q_i/a;
tic
%==========================================================================    
%Re Loop
            Re=(v_bulk)*D/(v);
            if Re<=2000;
                Regime='Laminar';
            else Re>2000; %bewteen 2000-4000 is both, normally flow is turbelent when Re==4000
                Regime='Turbulent';
            end
            switch Regime;
                case 'Laminar'
                    %disp('Flow is laminar');
                    f=64/Re;
                case 'Turbulent'
                  %disp('Flow is turbulent');
                  f=(1/(-1.81*log10((6.9/Re)+((e/D)/3.7)^1.11)))^2; 
            end
            h_l=(((v_bulk)^2)/(2*g))*(f*(l/(D)));
            h_i=p_i_conv/(rho*g);
            error_h_l=abs(h_l-(h_i))/h_l;
%==========================================================================    
% Error Loop
tic
disp('The program is running...');
   while error_h_l>1e-03;
                r=D/2;
                a=pi*(r^2);
                v_bulk=Q_i/a;
                Q_i=Q_i+delta_Q;
                v_bulk=Q_i/a;
                Re=(v_bulk)*D/(v);
               %Recaculation of friction
                Re=(v_bulk)*D/(v);
                if Re<=2000;
                    Regime='Laminar';
                else Re>2000; %bewteen 2000-4000 is both, normally flow is turbelent when Re==4000
                    Regime='Turbulent';
                end
%==========================================================================  
                switch Regime;
                    case 'Laminar'
                        %disp('Flow is laminar');
                        f=64/Re;
                    case 'Turbulent'
                      %disp('Flow is turbulent');
                      f=(1/(-1.81*log10((6.9/Re)+((e/D)/3.7)^1.11)))^2;  
                end
                h_l=(((v_bulk)^2)/(2*g))*(f*(l/(D)));
                h_i=p_i_conv/(rho*g);
                error_h_l=abs(h_l-(h_i))/h_l;
   end
 toc
disp(' ');
  if Re<2000
        Regime='Laminar';
        disp('Flow is laminar');
        p_i
        v_bulk
        h_l
        time_elapse=toc
    elseif Re>2000
        Regime='Turbulent';
        disp('Flow is turbulent');
        p_i
        v_bulk
        h_l
        time_elapse=toc
  end