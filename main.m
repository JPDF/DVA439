clearvars; clc; close all;

% Includes
addpath('./AutoCorrector')

fprintf('Importing data...\n-Why? '); why
%Import data from file
file = 'Data/Twitter/10k_weighted.csv';
rawData = readtable(file);

fprintf('Preprocessing...\n-Why? '); why

rawData.SentimentText = decodeHTMLEntities(rawData.SentimentText);
wordsToChange = ["<3",  " x " , "$"];
referingWords = [" love ", " kiss ", " money "];
rawData.SentimentText = regexprep(rawData.SentimentText,wordsToChange,referingWords);

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
% fprintf('TF-IDF...\n-Why? '); why
% termFreqMatrix = termFrequency(preprocessedData);
% termFreqMatrix(:,end+1) = rawData.Sentiment;

%Clear unnecessary variables in workspace
clearvars -except correctedWords eds preprocessedData rawData docSeqMatrix termFreqMatrix;
fprintf('Done!\n-Why? '); why

%%
load Models\boostedTrees.mat
load Models\KNN.mat
load Models\logisticRegression.mat
load Models\mediumGaussianSVM.mat
load Models\subspaceDiscriminant.mat

classifier = {boostedTrees, KNN, logisticRegression, MediumGaussianSVM, subspaceDiscriminant};
Y = docSeqMatrix(:,301);

for i = 1:length(classifier)
    pred_Y = classifier{i}.predictFcn(docSeqMatrix(:,1:300));
    
    % Plot the confusion matrix
    figure
    plotconfusion(Y', pred_Y')

    confusionMatrices{i} = confusionmat(Y,pred_Y)
end

probConfusionMatrix(confusionMatrices)

%figure
%confusionchart(pm{1}*100,'DiagonalColor','#82CF97','OffDiagonalColor','red');


% total0 = confusionMatrix(1,1)+confusionMatrix(2,1);
% total1 = confusionMatrix(1,2)+confusionMatrix(2,2);
% newConfusionMatrix(1,1) = confusionMatrix(1,1)/total0;
% newConfusionMatrix(1,2) = confusionMatrix(1,2)/total1;
% newConfusionMatrix(2,1) = confusionMatrix(2,1)/total0;
% newConfusionMatrix(2,2) = confusionMatrix(2,2)/total1;
% newConfusionMatrix
