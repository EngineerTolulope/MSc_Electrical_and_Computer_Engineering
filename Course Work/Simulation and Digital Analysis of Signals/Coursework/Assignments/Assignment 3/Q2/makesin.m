%--makesin.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-07-29
%
% Description: This script includes a matlab function which generates two
%              sinusoids with different time interval.
%              Function inputs: Amplitude (A) in mV
%                               Frequency (f0) in Hz
%                               Phase angle (phi) in degree
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz

function [g_t,t,g_f,f,g_t1,t1,g_f1,f1]= makesin(varargin)
% Setting Default Parameters
A=5e-3; % amplitude in mV
f0=3;  % Frequency (f0) in Hz
phi=0;  % Phase angle (phi) in degree
T=5;    % Duration (T) in seconds
fs=30;% Sampling rate (fs) in Hz

if ~isempty(varargin)
    %If a parameter is not empty it overwrites the default value
    if ~isempty(cell2mat(varargin(1))); A=cell2mat(varargin(1)); end
    if ~isempty(cell2mat(varargin(2))); f0=cell2mat(varargin(2)); end
    if ~isempty(cell2mat(varargin(3))); phi=cell2mat(varargin(3)); end
    if ~isempty(cell2mat(varargin(4))); T=cell2mat(varargin(4)); end
    if ~isempty(cell2mat(varargin(5))); fs=cell2mat(varargin(5)); end
end

phi_rad=deg2rad(phi); % conversion of phase angle into radians

dt=1/fs; N=T*fs; df = 1/T;
t=0:dt:T-dt; % time range
f = 0:df:fs-df; % frequency range

g_t=A*cos(2*pi*f0*t + phi_rad);  % cosine function
g_f=abs(fft(g_t));  %Frequency Spectrum of the Signal
g_f=(2/N)*g_f;

%% New Sinusoid with T=1sec
T=1;
dt=1/fs; N=T*fs; df = 1/T;
t1=0:dt:T-dt; % time range
f1 = 0:df:fs-df; % frequency range

g_t1=A*cos(2*pi*f0*t1 + phi_rad);  % cosine function
g_f1=abs(fft(g_t1));  %Frequency Spectrum of the Signal
g_f1=(2/N)*g_f1;

end
