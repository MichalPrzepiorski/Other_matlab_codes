addpath(genpath('C:\Program Files (x86)\REFPROP'))

t_par = 50;

for c = 1:51
    X(c) = t_par;
    Y(c) = ProjektMatlab1(t_par);
    t_par = t_par + 1;
end

Liczba_macha_wieksza_od_1 = Y > 1;

Ponad_X = X(Liczba_macha_wieksza_od_1);
Ponad_Y = Y(Liczba_macha_wieksza_od_1);


plot(X,Y, "Color", "Green", 'LineWidth',5)
hold on
plot(Ponad_X, Ponad_Y, "Color", "Red", 'LineWidth',5)
hold on
yline(1, "Color", "Magenta", 'LineWidth',3)
xlabel('Temperatura parowania °C') 
ylabel('Liczba Macha') 
legend('Liczba Macha mniejsza ni¿ 1','Liczba Macha wiêksza ni¿ 1', 'Liczba Macha równa 1', ... 
'NumColumns',3, ... 
'Location','southoutside');

function Liczba_macha = ProjektMatlab1(t_par)

    czynnik = 'R1233zd';
    t_par = t_par+273.15;
    %t_par = 100+273.15;%K %potem nale¿y to zmieniaæ do 100
    t_skr = 27+273.15; %K
    Stopien_przegrzania = 6.5; %K
    t_przeg = t_par + Stopien_przegrzania;
    Sprawnosc_wew = 0.76;
    Reakcyjnosc = 0.54;
    v = 22; %m/s


    P_skr = refpropm('P', 'T', t_skr, 'Q', 0.1, czynnik);
    P_par = refpropm('P', 'T', t_par, 'Q', 0.5, czynnik);

    h_1 = refpropm('H', 'T', t_przeg, 'P', P_par, czynnik);
    s_1 = refpropm('S', 'T', t_przeg, 'P', P_par, czynnik);
    h_3s = refpropm('H', 'P', P_skr, 'S', s_1, czynnik);

    %Sprawnoœæ turbiny zdefiniowana jako: Sprawnosc_wew = (h_1-h_3)/(h_1-h_3s)
    h_3 = -Sprawnosc_wew*(h_1-h_3s)+h_1;

    %Reakcyjnosc = (h_2-h_3)/(h_1-h_3)
    h_2 = Reakcyjnosc*(h_1-h_3)+h_3;

    h_2s = h_2 - (((-3.58)*(10^(-5))*((t_par-273.15)^(2)) + 0.01*(t_par-273.15) - 0.28)*1000);

    P_2 = refpropm('P', 'H', h_2s, 'S', s_1, czynnik);

    v_dysza = sqrt(2*(h_1-h_2)+v^2);
   
    Liczba_macha = v_dysza / refpropm('A', 'H', h_2, 'P', P_2, czynnik);

end


