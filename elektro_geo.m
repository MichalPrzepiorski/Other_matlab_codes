

addpath(genpath('C:\Program Files (x86)\REFPROP'));

% woda geotermalna
V_geo=290;
t_geo1=86;
p_geo=1;

% obieg ORC
czynnik_ORC='R227ea';
t_par=70;
dT=5;
t_skr=40;
dT_par=5;
eta_T=0.80;
eta_P=0.75;

% woda ch�odz�ca
tc1=20;
tc2=30;
p_c=1013;

% parametry otoczenia
t_ot=tc1;
p_ot=p_c;

% parametry do wyznaczenia bilansu energii

rho_geo=refpropm('D','T',t_geo1+273.15,'P',p_geo*1e3,'water');
m_geo = V_geo*rho_geo/3600;

c_geo=refpropm('C','T',t_geo1+273.15,'P',p_geo*1e3,'water')*1e-3;

t_geo3 = t_par + dT_par;


p_par = refpropm('P','T',t_par + 273,'Q',0.5,czynnik_ORC);
p_skr = refpropm('P','T',t_skr + 273,'Q',0.5,czynnik_ORC);

t1 = t_par + dT;

h1 = refpropm('H','T',t1 + 273,'P',p_par,czynnik_ORC)*1e-3;

h3 = refpropm('H','T',t_skr + 273,'Q',0,czynnik_ORC)*1e-3;
s3 = refpropm('S','T',t_skr + 273,'Q',0,czynnik_ORC);
h4s = refpropm('H','P',p_par,'S',s3,czynnik_ORC)*1e-3;

h4 = h3 + (h4s - h3)/eta_P;

h5 = refpropm('H','T',t_par + 273,'Q',0,czynnik_ORC)*1e-3;

A = [h4 - h1 -m_geo*c_geo
    h4 - h5 -m_geo*c_geo];

B = [-m_geo*c_geo*t_geo1
    -m_geo*c_geo*t_geo3];

X = A\B;

m_ORC = X(1);
t_geo2 = X(2);


% b) (moc netto)

s1 = refpropm('S','T',t1 + 273,'P',p_par,czynnik_ORC);
h2s = refpropm('H','P',p_skr,'S',s1,czynnik_ORC)*1e-3;

h2 = h1 - eta_T*(h1 - h2s);

N_net = m_ORC*(h1 - h2 - (h4 - h3));

% c) (sprawno�� termiczna)

eta_ORC = (N_net)/(m_ORC*(h1 - h4))*100;

% d) (straty egz)

s_geo1 = refpropm('S','T',t_geo1 + 273,'P',p_geo*1e3,'water');
s_geo_ot = refpropm('S','T',t_ot + 273,'P',p_ot*1e1,'water');

s_geo2 = refpropm('S','T',t_geo2 + 273,'P',p_geo*1e3,'water');

B_geo1 = m_geo*(c_geo*(t_geo1 - t_ot) - (t_ot + 273)*(s_geo1 - s_geo_ot)*1e-3);
B_geo2 = m_geo*(c_geo*(t_geo2 - t_ot) - (t_ot + 273)*(s_geo2 - s_geo_ot)*1e-3);

c_c = 4.19;

m_c = m_ORC*(h2 - h3)/(c_c*(tc2 - tc1));

s_c2 = refpropm('S','T',tc2 + 273,'P',p_c*1e1,'water');
s_c_ot = refpropm('S','T',t_ot + 273,'P',p_ot*1e1,'water');

B_c2 = m_c*(c_c*(tc2 - t_ot) - (t_ot + 273)*(s_c2 - s_c_ot)*1e-3);

dB_tot_bilans = B_geo1 - B_geo2 - B_c2 - N_net; % bilans


s_c1 = refpropm('S','T',tc1 + 273,'P',p_c*1e1,'water');
dB_tot_G_S = (t_ot + 273)*(m_c*(s_c2 - s_c1) - m_geo*(s_geo1 - s_geo2))*1e-3;


