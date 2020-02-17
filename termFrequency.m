function termFreqMatrix = termFrequency(tokenDoc)
%INPUT: Tokenized document.
%OUTPUt: Matrix where each column is for each unique word in the document
%and the rows are for each tweet. The number stands for the frequency of
%that word in that tweet.

bag = bagOfWords(tokenDoc);
termFreqMatrix = full(tfidf(bag,'TFWeight','raw','IDFWeight','normal'));
end

