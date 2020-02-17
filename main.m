%Start up
clear all; clc; close all;

file = '1-100SentimentDataset.csv';
T = readtable(file);
rawTweets = table2cell(T); %Choose col containing the tweets

% Remove HTML tags, @mentions, hashtags(#), tickers($), and numeric values 
toRemoveRegex = {'<[^>]+>', '(?:@[\w_]+)', '(?:&[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'}; 
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
%Calls the preprocess function and returns the preprocessed data.
tokenizedTweetsPreprocessed = preprocess(rawTweets(:,4), toRemoveRegex, wordsToKeep, customStopWords);
%Converts to cell array
tokenizedTweetsCells = doc2cell(tokenizedTweetsPreprocessed);

emb = fastTextWordEmbedding;



for i = 1:length(rawTweets)
    idDelete = ~isVocabularyWord(emb,tokenizedTweetsCells{i});
    tokenizedTweetsCells{i}(idDelete) = [];
    rawTweets(i, 5) = cellstr(join(tokenizedTweetsCells{i}));
    wordVector(i,:) = mean(word2vec(emb, string(tokenizedTweetsCells{i})));
end

wordVector(:,301) = cell2mat(rawTweets(:,2));
trainingTweets = cell2table(rawTweets,'VariableNames',{'Index','Sentiment', 'Sentiment_Source', 'Sentiment_Text', 'Preprocessed_Sentiment_Text'});

%Term Frequency - Inverse Document Frequency(TF-IDF)
[termFreqMatrix, words] = termFrequency(tokenizedTweetsPreprocessed);
termFreqMatrix(:,words+1)= cell2mat(rawTweets(:,2));

