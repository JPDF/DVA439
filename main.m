%Start up
clear all; clc; close all;
file1 = '1-100SentimentDataset.csv';
file2 = 'sample-tweets.csv';
T = readtable(file1);
rawTweets = table2cell(T); %Choose col containing the tweets

% Remove HTML tags, @mentions, hashtags(#), tickers($), and
% numeric values 
toRemoveRegex = {'<[^>]+>', '(?:@[\w_]+)', '(?:&[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'}; 
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
%Calls the preprocess function and returns the preprocessed data.
tokenizedTweetsPreprocessed = preprocess(rawTweets(:,4), toRemoveRegex, wordsToKeep, customStopWords);
%Converts to cell array
tokenizedTweetsCells = doc2cell(tokenizedTweetsPreprocessed);
for i = 1:length(rawTweets)
    rawTweets(i, 5) = cellstr(join(tokenizedTweetsCells{i}));
end
%Adds the strings to column 6 for classification training.
rawTweets(:, 6) = tokenizedTweetsCells;
