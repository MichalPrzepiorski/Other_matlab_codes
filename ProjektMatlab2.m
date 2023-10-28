addpath(genpath('C:\Program Files (x86)\REFPROP'))

czynnik = 'R1233zd';
t_par = 100+273.15;%K %potem nale¿y to zmieniaæ do 100
t_skr = 27+273.15; %K
Stopien_przegrzania = 6.5; %K
Sprawnosc_wew = 0.76;
Reakcyjnosc = 0.54;
v = 22; %m/s


P_skr = refpropm('P', 'T', t_skr, 'Q', 0, czynnik);

P_par = refpropm('P', 'T', t_par, 'Q', 0, czynnik);

h_3 = refpropm('H', 'T', t_skr+6.5, 'P', P_skr, czynnik); 

h_1 = refpropm('H', 'P', P_par, 'Q', 1, czynnik);

%Sprawnoœæ turbiny zdefiniowana jako: Sprawnosc_wew = (h_1-h_3)/(h_1-h_3s)

h_3s = (-(h_1-h_3)+h_1*Sprawnosc_wew)/Sprawnosc_wew;

%Reakcyjnosc = rho = (h_2-h_3)/(h_1-h_3)

h_2 = Reakcyjnosc*(h_1-h_3) + h_3;

h_2s = h_2 - (((-3.58)*(10^(-5))*((100)^(2)) + 0.01*(100) - 0.28)*1000);

s_1 = refpropm('S', 'H', h_1, 'P', P_par, czynnik);

P_2s = refpropm('A', 'H', h_2s, 'S', s_1, czynnik);

%Q = refpropm('Q', 'H', h_2, 'P', P_2s, czynnik)

T_2 = refpropm('T', 'H', h_2, 'P', P_2s, czynnik);

T_1 = refpropm('T', 'H', h_1, 'P', P_par, czynnik);

v_dysza = v * (P_par / T_1) * (T_2 / P_2s)

Liczba_macha = v_dysza/(refpropm('A', 'H', h_2, 'P', P_2s, czynnik))


