p.alpha_deg = -10;
p.camber_u = 0.04;
p.camber_l = 0.00;
p.rho = 1.225;
p.V = 30;
p.chord = 0.25;
p.span = 1.0;   % 2D: per meter span

out = airfoil_sim(p);
disp(out)
