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

%Add part-of-speech details to improve lemmatization
data = addPartOfSpeechDetails(data);
%Remove words to keep from the stop words list
stopWordsList = stopWords;
stopWordsList(ismember(stopWordsList,wordsToKeep)) = [];
%Remove stop words
data = removeWords(data, stopWordsList);
%Lemmatizise the data
data = normalizeWords(data, 'Style', 'lemma');

%Removal of specialcharacters etc
data = erasePunctuation(data);

%Removal of short words of 2 character since they hold no meaning.
data = removeShortWords(data, 2);
data = removeWords(data,customStopWords);
%data = normalizeWords(data);

end

