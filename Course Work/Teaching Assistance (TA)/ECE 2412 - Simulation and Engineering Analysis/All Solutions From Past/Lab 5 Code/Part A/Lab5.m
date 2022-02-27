%% Lab 5
% data encoding / decoding exercise
% RTervo January 2013
% Updated with new seeding method February 2015 BC
% --------------------------------
% create an input text string

clear;
clc;

input = 'Success is not a moment but a process';
% N = the number of input characters
N = length( input );
% use your secret key value here to seed the pseudo-random number generator, you must
%reset the generator each time you call rand.
key= 13579;
rng(key); % seed the random number generator
% generate N 4-bit random numbers [0..15]
psrand = round( 15*rand(1,N) );
% convert text to numeric codes (ASCII)
data_in = double( input );
% scramble each character with the key
tx_data = bitxor( data_in, psrand );

%% see the scrambled text
tx_text = char( tx_data )





% % unscramble using the same key
% rx_data = bitxor( tx_data, psrand );
% % see the unscrambled text
% rx_text = char( rx_data )


