function sequences = docSequence(emb, docs)
%WORDSEQUENCE Converting the tokenized documents into sequences
%   inputs
%       emb: Text word embedding
%       docs: The documents to be converted into sequences
%   output
%       Sequences of every document
sequences = doc2sequence(emb, docs, 'PaddingDirection', 'none');
for i = 1:length(sequences)
    %Take the mean of every word vector
    sequences{i} = mean(sequences{i},2);
end
%Convert cell to matrix array
sequences = cat(2, sequences{:})';
end

