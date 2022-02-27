%--makesinQ.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-17
%
% Description: This script includes a matlab function which generates a
%              sinusoid (a cosine) given in-phase and quadrature
%              components.
%              Function inputs: In-Phase Component (Aip) in mV
%                               Quadrature Component (Aqu) in mV
%                               Frequency (fo) in Hz
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz

function [g_t,t,arr]= makesinQ(varargin)
% Setting Default Parameters
Aip = 0.5*1e-3; %In-Phase Component
Aqu = (sqrt(3)/2)*1e-3; %Quadrature Component
f0=60;  % Frequency (f0) in Hz
T=1;    % Duration (T) in seconds
fs=1000;% Sampling rate (fs) in Hz

if isempty(varargin)    %If no input is found use default values
    dt=1/fs;
    t=0:dt:T-dt; % time range
    g_t = Aip*cos(deg2rad(90)-2*pi*f0*t) + Aqu*cos(2*pi*f0*t);
    
else   % Overwriting the default values if varargin isn't empty
    %If a parameter is not empty it overwrites the default value
    if ~isempty(cell2mat(varargin(1))); Aip=cell2mat(varargin(1)); end
    if ~isempty(cell2mat(varargin(2))); Aqu=cell2mat(varargin(2)); end
    if ~isempty(cell2mat(varargin(3))); f0=cell2mat(varargin(3)); end
    if ~isempty(cell2mat(varargin(4))); T=cell2mat(varargin(4)); end
    if ~isempty(cell2mat(varargin(5))); fs=cell2mat(varargin(5)); end
    
    dt=1/fs;
    t=0:dt:T-dt; % time range
    g_t = Aip*cos(deg2rad(90)-2*pi*f0*t) + Aqu*cos(2*pi*f0*t);
    
end
arr=[Aip Aqu f0 T fs];
end

