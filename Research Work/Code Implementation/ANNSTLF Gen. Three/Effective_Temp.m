
% inputs are the temperature in farenheit, humidity, and wind speed
function T_eff = Effective_Temp(Temp,Humid, WSpd)
    alpha = 0.5;

    if (Temp > 75)  % T > 75
        T_eff = Temp + alpha * Humid;
    elseif (65 <= Temp & Temp <= 75)   % 65 <= T <= 75
        T_eff = Temp;
    else
        T_eff = Temp - ((WSpd .*(65-Temp))/100);  % T < 65
    end  
end

