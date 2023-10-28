%zmienne wejsciowe
addpath(genpath('C:\Program Files (x86)\REFPROP')) %dodaj scie¿ke
% refpropm('D','T', 293, 'P', 101, 'water')

m_ob = 8;
m_c = 15;
t_c1 = 25;
c_c = 4.19;
t_skr = 50;
h_3 = refpropm('H','T', t_skr+273.15, 'Q', 0, 'R227ea')/1000;
h_2 = refpropm('H','T', t_skr+273.15, 'Q', 1, 'R227ea')/1000;

t_c2 = (t_c1 + (m_ob*(h_2-h_3))/(m_c*c_c));

%podpunkt b)

delta_t_skr = t_skr - t_c2;

%podpunkt c) dodanie wektora wartosci
t_skr_wek = linspace(30,50,10);

for i=1:length(t_skr_wek)
    h_2(i) = refpropm('H','T', t_skr_wek(i) + 273.15, 'Q', 0, 'R227ea')/1000;
    h_3(i) = refpropm('H','T', t_skr_wek(i) + 273.15, 'Q', 1, 'R227ea')/1000;
end

t_c2_wek = (t_c1 + (m_ob*(h_2-h_3))/(m_c*c_c));

delta_t_skr_wek = t_skr_wek - t_c2_wek;
%wykres
plot(t_skr_wek, delta_t_skr_wek)
