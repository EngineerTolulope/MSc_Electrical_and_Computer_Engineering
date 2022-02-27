%--makesin.m
%
% Author: Tolulope Olugbenga
% Id: 3643581
% Date: 2019-05-17
%
% Description: This script includes a matlab function which generates a
%              sinusoid (a cosine) waveform.
%              Function inputs: Amplitude (A) in mV
%                               Frequency (f0) in Hz
%                               Phase angle (phi) in degree
%                               Duration (T) in seconds
%                               Sampling rate (fs) in Hz



function [g_t,t]= makesin(varargin)
% Setting Default Parameters
A=1e-3; % amplitude in mV
f0=60;  % Frequency (f0) in Hz
phi=0;  % Phase angle (phi) in degree
T=1;    % Duration (T) in seconds
fs=1000;% Sampling rate (fs) in Hz

if ~isempty(varargin)
    %If a parameter is not empty it overwrites the default value
    if ~isempty(cell2mat(varargin(1))); A=cell2mat(varargin(1)); end
    if ~isempty(cell2mat(varargin(2))); f0=cell2mat(varargin(2)); end
    if ~isempty(cell2mat(varargin(3))); phi=cell2mat(varargin(3)); end
    if ~isempty(cell2mat(varargin(4))); T=cell2mat(varargin(4)); end
    if ~isempty(cell2mat(varargin(5))); fs=cell2mat(varargin(5)); end
end

dt=1/fs;
t=0:dt:T-dt; % time range
phi_rad=deg2rad(phi); % conversion of phase angle into radians
g_t=A*cos(2*pi*f0*t+phi_rad);  % cosine function


end
