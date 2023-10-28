t_par = linspace(50,70,10);

czynniki = {'R227ea', 'R1234ze','R1234yf','R143a',...
    'R245fa'};

for c = 1:length(czynniki)

    for i = 1:length(t_par)
        N_net(i,c) = elektro_geo_par(t_par(i),czynniki{c});
    end
    
end
%analiza par

plot(t_par, N_net)
legend(czynniki)