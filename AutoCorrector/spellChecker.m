function words = spellChecker(eds, words, details)
%SPELLCHECKER Summary of this function goes here
%   Detailed explanation goes here
allowedTypes = ...
    details.Type ~= "letters" & ...
    details.Type ~= "other";

wordsToCheckIds = ~ismember(details.Token, eds.Vocabulary) & ~allowedTypes;
wordsToCheckIds = find(wordsToCheckIds);
wordsToCheck = words(wordsToCheckIds);

nearestWordsIds = knnsearch(eds, wordsToCheck);
matches = ~isnan(nearestWordsIds);
correctedWords = eds.Vocabulary(nearestWordsIds(matches));

wordsToCorrectIds = wordsToCheckIds(matches);
words(wordsToCorrectIds) = correctedWords;
end

