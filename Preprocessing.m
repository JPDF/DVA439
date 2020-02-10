%% Start up
clear; clc; close all;
TrumpC = fileread('trumpTw.txt');
trumpTXT = textscan(TrumpC,'%s','delimiter','\n'); 
trump = trumpTXT{1};

trumpOriginal = tokenizedDocument(trump); %original tweets saved for viewing
%% 
clc;
% Removal of tags and urls since they hold no value
trumpy = eraseTags(trump); 
trumpy = eraseURLs(trumpy);
%torep is set to remove HTML tags, @mentions, hashtags(#), tickers($), and
%numeric values
torep = {'<[^>]+>', '(?:@[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'};                                  
trumpy = strip(regexprep(trumpy,torep,''));
trumpy = tokenizedDocument(trumpy);
%Make everything lowercase for dimension reduction
trumpy = lower(trumpy);
%Removal of specialcharacters etc
trumpy = erasePunctuation(trumpy);
%Specialized stop words list for tweets to keep sentiment and dimension
%reduction
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
stopWordsList = stopWords;
stopWordsList(ismember(stopWordsList,wordsToKeep)) = [];
trumpy = removeWords(trumpy, stopWordsList);
%Removal of short words of 1 character since they hold no meaning.
trumpy = removeShortWords(trumpy, 1);
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
trumpy = removeWords(trumpy,customStopWords);
trumpy
%%
bag = bagOfWords(trumpy)
rng('default')
numTopics = 15;
mdl = fitlda(bag,numTopics,'Verbose',0);
k = 30;
topicIdx = 1;
tbl = topkwords(mdl,k,topicIdx)
figure
wordcloud(tbl.Word,tbl.Score);