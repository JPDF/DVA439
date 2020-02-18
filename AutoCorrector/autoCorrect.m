function [docs, correctedWords] = autoCorrect(docs)
%AUTOCORRECT Spell checks tokenized documents
%   Detailed explanation goes here
% https://www.mathworks.com/help/textanalytics/ug/correct-spelling-using-edit-distance-searchers.html?fbclid=IwAR3y0ONcDlp9sBIEI4HtebhaKmrQPm_u_YATkeS6Y5hmi7xPbIh_g6ze_oc
if isfile('AutoCorrector/eds.mat')
    load('eds.mat', 'eds');
else
    setup
end
oldWords = tokenDetails(docs).Token;
docs = docfun(@(words, details) spellChecker(eds, words, details), docs);
newWords = tokenDetails(docs).Token;
correctedWordsIds = find(oldWords ~= newWords);
correctedWords = [oldWords(correctedWordsIds) newWords(correctedWordsIds)];
end

