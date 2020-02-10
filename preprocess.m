function [data] = preprocess(inputData, toRemoveRegex, wordsToKeep, customStopWords)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here
% Removal of tags and urls since they hold no value
data = eraseTags(inputData); 
data = eraseURLs(data);
% Remove words using regex           
data = strip(regexprep(data,toRemoveRegex,''));
data = tokenizedDocument(data);
%Make everything lowercase for dimension reduction
data = lower(data);
%Removal of specialcharacters etc
data = erasePunctuation(data);
%Specialized stop words list for tweets to keep sentiment and dimension
%reduction
stopWordsList = stopWords;
stopWordsList(ismember(stopWordsList,wordsToKeep)) = [];
data = removeWords(data, stopWordsList);
%Removal of short words of 2 character since they hold no meaning.
data = removeShortWords(data, 2);
data = removeWords(data,customStopWords);
%data = normalizeWords(data);
end

