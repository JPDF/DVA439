clearvars; clc; close all;

% Includes
addpath('./AutoCorrector')

fprintf('Importing data...\n-Why? '); why
%Import data from file
file = 'Data\Twitter\1000_weighted.csv';
rawData = readtable(file);

fprintf('Preprocessing...\n-Why? '); why
%Remove HTML tags, @mentions, hashtags(#), tickers($), and numeric values 
toRemoveRegex = {'<[^>]+>', '(?:@[\w_]+)', '(?:&[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'}; 
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
%Calls the preprocess function and returns the preprocessed data.
preprocessedData = preprocess(rawData.SentimentText, toRemoveRegex, wordsToKeep, customStopWords);

%Auto-correct
% fprintf('Auto correcting...\n-Why? '); why
% [preprocessedData, correctedWords] = autoCorrect(preprocessedData);

%Converting the tokenized documents into word sequences
fprintf('Text word embedding...\n-Why? '); why
emb = fastTextWordEmbedding;
docSeqMatrix = docSequence(emb, preprocessedData);
docSeqMatrix(:,301) = rawData.Sentiment;

%Term Frequency - Inverse Document Frequency(TF-IDF)
fprintf('TF-IDF...\n-Why? '); why
termFreqMatrix = termFrequency(preprocessedData);
termFreqMatrix(:,end+1) = rawData.Sentiment;

%Clear unnecessary variables in workspace
clearvars -except correctedWords eds preprocessedData rawData docSeqMatrix termFreqMatrix;
fprintf('Done!\n-Why? '); why