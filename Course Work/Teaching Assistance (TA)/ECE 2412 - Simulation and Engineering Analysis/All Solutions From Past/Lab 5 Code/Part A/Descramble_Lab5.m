clear;
clc;
%% Descramble Code
% From a remote user perspective
% They have the key transmitted by other means.
% They receive the scrambled text ‘tx_text’
%% Added code
tx_text = 'Ppam`{+gu!df~*b.hjlndy"e{|)d''uxkia}x'; % Add ' in case of "'"
tx_data = double(tx_text); % tx_data has to be in double format
N = length( tx_text );


%Step one is to generate the pseudorandom sequence using the key
key= 13579;
rng(key); % seed the random number generator
% generate N 4-bit random numbers [0..15]
psrand = round( 15*rand(1,N) );
% Step two is to unscramble the data


% unscramble using the same key
rx_data = bitxor( tx_data, psrand );
% Convert this back to readable text
rx_text = char( rx_data )
