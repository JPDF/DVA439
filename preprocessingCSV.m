clear all;
clc;
%[num, txtTweets, rawTweets] = xlsread('sample-tweets.csv');

T = readtable('sample-tweets.csv');
rawTweets = table2cell(T(:,1)); %Removes the tweet data, keeps only the text

tweetsOriginal = tokenizedDocument(rawTweets) %original tweets saved for viewing
%% 
clc;
% Removal of tags and urls since they hold no value
tweets = eraseTags(rawTweets); 
tweets = eraseURLs(tweets);

%torep is set to remove HTML tags, @mentions, hashtags(#), tickers($), and
%numeric values
torep = {'<[^>]+>', '(?:@[\w_]+)', '(?:\#+[\w_]+[\w\''_\-]*[\w_]+)', '(?:\$+[\w_]+)','\d'};                                  
tweets = strip(regexprep(tweets,torep,''));
tweets = tokenizedDocument(tweets);

%Removal of specialcharacters etc
tweets = erasePunctuation(tweets);

%Specialized stop words list for tweets to keep sentiment and dimension
%reduction
wordsToKeep = ["are", "aren't", "arent", "can", "can't", "cant", "cannot", "could", "couldn't", "did", "didn't", "didnt", "do", "does", "doesn't", "doesnt", "don't", "dont", "is", "isn't", "isnt", "no", "not", "was", "wasn't", "wasnt", "with", "without", "won't", "would", "wouldn't"];
stopWordsList = stopWords;
stopWordsList(ismember(stopWordsList,wordsToKeep)) = [];
tweets = removeWords(tweets, stopWordsList);

%Removal of short words of 1 character since they hold no meaning.
tweets = removeShortWords(tweets, 1);

%Make everything lowercase for dimension reduction
tweets = lower(tweets);
customStopWords = ["rt","retweet","amp","http","https","stock","stocks","inc","msnbc", "cont", "text", "am", "pm", "createdat", "mdash", "januari", "februari", "march", "april", "may", "june", "july", "august", "september", "oktober", "november", "december"];
tweets = removeWords(tweets,customStopWords);
tweets