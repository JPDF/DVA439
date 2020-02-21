clear all; clc;
opts = detectImportOptions('EmojiConverter/emojiTable.xlsx');


%T = readtable('EmojiConverter/emojiTable.xlsx');
[~,convertTable]  = xlsread('EmojiConverter/emojiTable.xlsx');

tweet = "The end &lt;3 of maths&lt;3 atx $ x (:school :'(:'(:'( the end of my school life :'(:'( I like school :'( who said sth else:'(";
file = 'Data/Twitter/1-100SentimentDataset.csv';
rawData = readtable(file);

tweet = decodeHTMLEntities(rawData.SentimentText)
wordsToChange = ["<3",  " x " , "$"];
referingWords = [" love ", "kiss", "money"];
tweet = regexprep(tweet,wordsToChange,referingWords)

documents = tokenizedDocument(tweet)%rawData.SentimentText);


newStr = replace(documents,string(convertTable(:,1)),string(convertTable(:,2)))




% HTML translate
%(<3)= heart
%( x )= kiss
%( o )= hug
%tokenize
%the rest