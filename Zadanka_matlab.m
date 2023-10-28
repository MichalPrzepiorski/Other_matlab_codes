%h_4reg policz
addpath(genpath('C:\Program Files (x86)\REFPROP'))

p_par = 1858; %kPa
p_skr = 528.4; %kPa
h_1 = 375.1*1000; %J/kg
h_2 = 362.1*1000; %J/kg
h_3 = 234.6*1000; %J/kg
h_4 = 235.9*1000; %J/kg
czynnik = 'R227ea';
deltaT_sch = 10; %K



T_2 = refpropm('T','H', h_2, 'P', p_skr, czynnik);
T_2reg = T_2 - deltaT_sch;
h_2reg = refpropm('H','T', T_2reg, 'P', p_skr, czynnik);

h_4reg = -h_2reg + h_2 + h_4