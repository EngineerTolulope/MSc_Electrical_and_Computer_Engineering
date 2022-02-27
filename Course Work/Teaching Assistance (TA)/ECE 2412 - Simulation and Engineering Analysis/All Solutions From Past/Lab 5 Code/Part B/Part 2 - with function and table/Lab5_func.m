function [distance,volume] = Lab5_func(r,L,d)
% Calculation with input r, L , d and output distance, volume
y1 = d - r;
x1 = sqrt(r^2 - y1^2);

    if (d>=r)
        f=@(x) sqrt(r.^2-x.^2) - y1;
        area_half = quad(f,0,x1);
        area_full = 2*area_half;

        volume = L * area_full;
        distance = d;       
    else
        % Calculate the volume of half tank is full or d = r (V_full)
        f1=@(x) sqrt(r.^2-x.^2);
        area_half = quad(f1,0,r);
        area_full = 2*area_half;
        volume1 = L * area_full * 2; 
        
        % Calculate the volume that is not filled (V_not_filled)
        f=@(x) sqrt(r.^2-x.^2) + y1;
        area_half = quad(f,0,x1);
        area_full = 2*area_half;

        % Calculate the volume that is filled V = V_full - V_not_filled
        volume = volume1 -  L * area_full;
        distance = d;       
    end

end

