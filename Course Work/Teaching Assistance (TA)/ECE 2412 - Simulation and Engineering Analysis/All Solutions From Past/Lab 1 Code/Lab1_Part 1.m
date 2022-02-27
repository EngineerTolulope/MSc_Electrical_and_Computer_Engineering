
clear;
clc;
close all;

%% Case 1
%v_out/v_in = (1 + jwRC)^-1
%% input
f = linspace(10^4,10^7,100);

%% constant
R = 50;
C = 1 * 10^-9;
%% processing
w = 2*pi*f;
Vout_in = (1 + 1i.*w.*R.*C).^(-1);
%% plotting

%% Case A
figure(1);
plot(f,abs(Vout_in));
grid on;
% Create title
title({'Frequency vs Vin/Vout'});

% Create xlabel
xlabel({'Frequency'});

% Create ylabel
ylabel({'Vin/Vout'});

axis([0 10^7 0 1]);
 
% Create line
annotation('line',[0.127187994462025 0.902504450158228],[0.518 0.518]);
% annotation('line',[0.127187994462025 0.902504450158228],[0.52 0.52]);


% Create textarrow
annotation(figure(1),'textarrow',[0.523214285714286 0.553928571428571],...
   [0.701380952380952 0.518],'TextEdgeColor','none');
 
% Create textbox
annotation(figure(1),'textbox',...
   [0.520642857142857 0.695238095238096 0.327571428571429 0.0809523809523875],...
    'String',{'The point at V_in/V_out = 0.5'},...
   'FitBoxToText','off');


%% Case B
figure(2);
semilogx(f,abs(Vout_in));
grid on;
% Create title
title({'Frequency vs Vin/Vout'});
% Create xlabel
xlabel({'Frequency'});
% Create ylabel
ylabel({'Vin/Vout'});
axis([0 10^7 0 1]);

% Create line
annotation('line',[0.127187994462025 0.902504450158228],[0.518 0.518]);

% Create textarrow
annotation(figure(2),'textarrow',[0.843214285714286 0.833928571428571],...
   [0.701380952380952 0.518],'TextEdgeColor','none');
 
% Create textbox
annotation(figure(2),'textbox',...
   [0.520642857142857 0.695238095238096 0.327571428571429 0.0809523809523875],...
    'String',{'The point at V_in/V_out = 0.5'},...
   'FitBoxToText','off');


% figure(3);
% semilogy(f,abs(Vout_in));
% grid on;
% % Create title
% title({'Frequency vs Vin/Vout'});
% % Create xlabel
% xlabel({'Frequency'});
% % Create ylabel
% ylabel({'Vin/Vout'});
% axis([0 10^7 0 1]);

%% Case C

figure(4);

for count = 1:20:100
% constant
old_C = 1 * 10^-9;
C = old_C *count* 0.01;
% processing
w = 2*pi*f;
Vout_in = (1 + 1i.*w.*R.*C).^(-1); 
semilogx(f,abs(Vout_in));
hold on;    
end

for count = 1:1:5
% constant
old_C = 1 * 10^-9;
C = old_C *count;
% processing
w = 2*pi*f;
Vout_in = (1 + 1i.*w.*R.*C).^(-1); 
semilogx(f,abs(Vout_in));
hold on;    
end

% Create title
title({'Family of curves'});
% Create xlabel
xlabel({'Frequency'});
% Create ylabel
ylabel({'Vin/Vout'});
axis([0 10^7 0 1]);
legend('C = 0.01', 'C = 0.2', 'C = 0.4', 'C = 0.6', 'C = 0.8', 'C = 1', 'C = 2', 'C = 3', 'C = 4', 'C = 5');
grid on;
hold off;




