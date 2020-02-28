function [data] = preprocess(inputData, toRemoveRegex, wordsToKeep, customStopWords)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here

%Make everything lowercase for dimension reduction
data = lower(inputData);
% Removal of tags and urls since they hold no value
data = eraseTags(data);
data = eraseURLs(data);
%Remove words using regex           
data = strip(regexprep(data,toRemoveRegex,''));

%Tokenize the text
data = tokenizedDocument(data);

%Emoji to word
[~,convertTable]  = xlsread('EmojiConverter/emojiTable.xlsx');
data = replace(data,string(convertTable(:,1)),string(convertTable(:,2)));
%Add part-of-speech details to improve lemmatization
data = addPartOfSpeechDetails(data, 'RetokenizeMethod', 'none');
%Remove words to keep from the stop words list
stopWordsList = stopWords;
stopWordsList(ismember(stopWordsList,wordsToKeep)) = [];
%Remove stop words
data = removeWords(data, stopWordsList);
%Lemmatizise the data
data = normalizeWords(data, 'Style', 'stem');

%Removal of specialcharacters etc
data = erasePunctuation(data);

%Removal of short words of 2 character since they hold no meaning.
vocab = data.Vocabulary;
tf = strlength(vocab) <= 2 & ~ismember(vocab, wordsToKeep);
data = removeWords(data,vocab(tf));
%data = removeShortWords(data, 2);
%Remove custom stop words
data = removeWords(data,customStopWords);
%data = normalizeWords(data);

end

