function Zin = find_root( Zo,Zl,Bl )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Zin = Zo *(Zl + 1j*Zo*tan(Bl))/(Zo + 1j*Zl*tan(Bl));
end

