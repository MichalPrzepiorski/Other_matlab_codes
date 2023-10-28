%W jakim stanie jest para? Przegrzana czy mokra
%Generowana moc
%
%R152a, 2,5 kg/s
%Izentropa
%
%
addpath(genpath('C:\Program Files (x86)\REFPROP'))
Czynnik = 'R152a';
Strumien = 2.5;
Temperatura_wlot = 97+273;
Cisnienie_wlot = 2.5*1000;
Cisnienie_wylot = Cisnienie_wlot*0.25;

H_wlot = refpropm('H','T', Temperatura_wlot, 'P', Cisnienie_wlot, Czynnik)/1000;
S_wlot = refpropm('S','T', Temperatura_wlot, 'P', Cisnienie_wlot, Czynnik);
H_wylot = refpropm('H','P', Cisnienie_wylot, 'S', S_wlot, Czynnik)/1000;

P = Strumien*(H_wlot-H_wylot);

Suchosc=refpropm('Q','P', Cisnienie_wylot,'S',S_wlot, Czynnik);


if Suchosc<1
    disp('Para mokra')
    disp(P)
else
    disp('Para sucha')
    disp(P)
end