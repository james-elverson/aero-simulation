function out = airfoilLiftBasic(params)
% airfoilLiftBasic - basic lift/downforce estimator for a 2D airfoil section
%
% Inputs (params struct):
%   alpha_deg   : angle of attack [deg]
%   camber_u    : "upper camber" (e.g., max camber fraction of chord, 0.00-0.08)
%   camber_l    : "lower camber" (same convention)
%   rho         : air density [kg/m^3]
%   V           : freestream speed [m/s]
%   chord       : chord length [m]
%   span        : span [m] (use 1 for "per meter span" 2D)

    alpha_deg = params.alpha_deg;
    cu = params.camber_u;
    cl = params.camber_l;
    rho = params.rho;
    V = params.V;
    c = params.chord;

    if isfield(params,'span'); b = params.span; else; b = 1.0; end

    % ---- optional ----
    if isfield(params,'Km'); Km = params.Km; else; Km = 2.0; end
    if isfield(params,'alpha_stall_deg'); a_stall = params.alpha_stall_deg; else; a_stall = 14; end
    if isfield(params,'CL_max'); CL_max = params.CL_max; else; CL_max = 1.4; end
    if isfield(params,'postStallModel'); psm = params.postStallModel; else; psm = 'clamp'; end

    %  mean camber proxy 
    m = 0.5*(cu + cl);           % dimensionless
    alpha0L = -Km * m;           % radians, negative for positive camber

    %  thin airfoil baseline 
    alpha = deg2rad(alpha_deg);
    CL_lin = 2*pi*(alpha - alpha0L);

    %  stall handling 
    alpha_stall = deg2rad(a_stall);

    if abs(alpha - alpha0L) <= alpha_stall
        CL = CL_lin;
    else
        switch lower(psm)
            case 'clamp'
                CL = sign(CL_lin) * min(abs(CL_lin), CL_max);
            case 'drop'
                excess = abs(alpha - alpha0L) - alpha_stall;
                dropFactor = max(0, 1 - excess/deg2rad(10)); 
                CL = sign(CL_lin) * min(abs(CL_lin), CL_max) * dropFactor;
            otherwise
                error('Unknown postStallModel. Use clamp or drop.');
        end
    end

    %  force 
    S = c * b;                   % planform area (2D: per span)
    q = 0.5*rho*V^2;              % dynamic pressure
    L = q * S * CL;               % lift (positive up)

    % Downforce 
    Dn = -L;

    %  output 
    out.CL = CL;
    out.L  = L;
    out.downforce = Dn;
    out.alpha0L_deg = rad2deg(alpha0L);
    out.q = q;
    out.S = S;
end
