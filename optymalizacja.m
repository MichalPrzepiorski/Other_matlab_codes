

czynniki = {'R227ea', 'R1234ze','R1234yf','R143a',...
    'R245fa'};

for c = 1:length(czynniki)

[t_par_opt, N_net_opt] = fmincon(@(t_par) elektro_geo_opt(t_par,czynniki{c}),65,[],[],[],[],50,70)

end