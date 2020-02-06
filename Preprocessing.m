clear; clc; close all;
TrumpC = fileread('trump.txt');
trumpTXT = textscan(TrumpC,'%s','delimiter','\n'); 
trump = trumpTXT{1};

trumpOriginal = tokenizedDocument(trump); %original tweets saved for viewing
trumpy = eraseTags(trump); 
trumpy = eraseURLs(trumpy);
%torep is set to remove HTML tags, @mentions, hashtags(#), tickers($), and
%numeric values
torep = {'<[^>]+>', '(?:@[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'};                                  
trumpy = strip(regexprep(trumpy,torep,''));
trumpy = tokenizedDocument(trumpy);
trumpy = erasePunctuation(trumpy);
trumpy = removeStopWords(trumpy);
trumpy = removeShortWords(trumpy, 1);
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc"];
trumpy = removeWords(trumpy,customStopWords);
trumpy = lower(trumpy)
