%--sincomp.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-31
%
% Description: This script includes a matlab function which generates a
%              sinusoid waveform based on the bn component of a Fourier
%              Series.
%              Function inputs: Amplitude(k) in mV
%                               Odd positive intergers(n)
%                               Frequency (f0) in Hz
%                               Duration (T) in Seconds
%                               Sampling rate (fs) in Hz
%
function [g_t,t,Amp,freq,fs]= sincomp(varargin)
% Setting Default Parameters
k=1e-3; %Amplitude
n=3;    %Odd positive interger
f0 = 1/(2*pi);  %Frequency
T = 10;         %Duration
fs = 20;    %Sampling rate

if ~isempty(varargin)% Overwriting the default values if varargin isn't empty
    %If a parameter is not empty it overwrites the default value
    if ~isempty(cell2mat(varargin(1))); k=cell2mat(varargin(1)); end
    if ~isempty(cell2mat(varargin(2))); n=cell2mat(varargin(2)); end
    if ~isempty(cell2mat(varargin(3))); f0=cell2mat(varargin(3)); end
    if ~isempty(cell2mat(varargin(4))); T=cell2mat(varargin(4)); end
    if ~isempty(cell2mat(varargin(5))); fs=cell2mat(varargin(5)); end
end

Amp =(4*k)/(pi*n);  % Amplitude in Volts
freq = f0*n;    % Frequency in Hz
dt=1/fs;
t=0:dt:T-dt; % time range
g_t= Amp*sin(2*pi*freq*t);  %Calculating the non zero component of the square wave

end
