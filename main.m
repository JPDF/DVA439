clear; clc; close all;
%Import data from file
file = 'Data\Twitter\1-100SentimentDataset.csv';
rawData = readtable(file);

file = 'Data/Twitter/1-1kSentimentDataset.csv';
T = readtable(file);
rawTweets = table2cell(T); %Choose col containing the tweets

% Remove HTML tags, @mentions, hashtags(#), tickers($), and numeric values 
toRemoveRegex = {'<[^>]+>', '(?:@[\w_]+)', '(?:&[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'}; 
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
%Calls the preprocess function and returns the preprocessed data.
preprocessedData = preprocess(rawData.SentimentText, toRemoveRegex, wordsToKeep, customStopWords);

%Converting the tokenized documents into word sequences
emb = fastTextWordEmbedding;
docSeqMatrix = docSequence(emb, preprocessedData);
docSeqMatrix(:,301) = rawData.Sentiment;

%Term Frequency - Inverse Document Frequency(TF-IDF)
termFreqMatrix = termFrequency(preprocessedData);
termFreqMatrix(:,end+1) = rawData.Sentiment;

%Clear unnecessary variables in workspace
clear file toRemoveRegex wordsToKeep customStopWords i emb;