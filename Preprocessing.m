clear; clc; close all;
TrumpC = fileread('trump.txt');
trumpTXT = textscan(TrumpC,'%s','delimiter','\n'); 
trump = trumpTXT{1};

trumpOriginal = tokenizedDocument(trump);
trumpy = eraseTags(trump);
trumpy = eraseURLs(trumpy);
torep = {'(?:\@+[\w_]+)'};
trumpy = strip(regexprep(trumpy,torep,''));
torep = {'(?:\#+[\w_]+)'};
trumpy = strip(regexprep(trumpy,torep,''));
trumpy = tokenizedDocument(trumpy);
trumpy = erasePunctuation(trumpy);
trumpy = removeStopWords(trumpy);
trumpy = removeShortWords(trumpy, 3);
trumpy = lower(trumpy);
bag = bagOfWords(trumpy); 
wordcloud(trumpy)