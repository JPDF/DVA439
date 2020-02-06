clear; clc; close all;
TrumpC = fileread('trump.txt');
trumpTXT = textscan(TrumpC,'%s','delimiter','\n'); 
trump = trumpTXT{1};