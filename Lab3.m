%temperatury wody geotermalnej kierowanej do otworu zat�aczaj�cego
%moc netto uk�adu N
%sprawno�� termiczna obiegu
%ca�kowite straty egzergii uk�adu
%sprawno�� egzergetycznej si�owni

addpath(genpath('C:\Program Files (x86)\REFPROP'))



%Uk�ad geotermalny
V_geo = 290/3600; %m3/s
t_geo1 = 86+273.15; %K
t_par = 70; %K
deltat_par= 5; %K
t_geo3 = t_par+deltat_par+273.15; %K
P_geo = 1000; %kPa
t_par = 70+273.15; %K
m_geo = V_geo * 1000; %kg/s
t_skr = 40+273.15; %K
czynnik = 'R227ea';

%t_1=t_pr+t_przegrzew

t_1 = t_par+5; %K

c_geo = refpropm('C','T', t_geo1, 'P', P_geo, 'water'); %J/(kg*K)

%Dodaj� parametr "Q" (zak�adamy jak�� warto��)
P_g = refpropm('P','T', t_par, 'Q', 0.4, czynnik); %kPa


%Sucho�� "Q" si� zmniejsza
P_d = refpropm('P','T', t_skr, 'Q', 0.2, czynnik); %kPa


h1 = refpropm('H','T', t_1, 'P', P_g, czynnik); %J/kg


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Obieg pompowania
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%h3=f(t_sk, Q = 0)
%h4S=f(P_g,s3)
%h4 to nale�y uwzgl�dni� sprawno�� izentropow� pompy
%n_i,P = (h4s - h3)/(h4-h3)

%h4 = ((h4s - h3)/(n_iP))+h3

h3 = refpropm('H','T', t_skr, 'Q', 0, czynnik); %J/kg
s3 = refpropm('S','T', t_skr, 'Q', 0, czynnik); %J/(kg*K)
h4s = refpropm('H','P', P_g, 'S', s3, czynnik); %J/kg
n_iP = 0.75; %tre�� zadania
h4 = (((h4s - h3)/(n_iP))+h3); %J/kg

h5 = refpropm('H','T', t_par, 'Q', 0, czynnik); %J/kg




A = [m_geo*c_geo h1-h4
    0 h1-h5];
    
B = [m_geo*c_geo*t_geo1
    m_geo*c_geo*(t_geo1-t_geo3)];

X = A\B;

t_geo2 = X(1)-273.15; %oko�o 70 stopni
m_orc = X(2); %oko�o 40 kg/s
%b)
%dopisz h2

N_net = m_orc*(h1-h2-(h4-h3))

%Analiza parametryczna wp�ywu t_par na moc netto N_net











