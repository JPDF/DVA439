TrumpC = fileread('trump.txt');
trumpTXT = textscan(TrumpC,'%s','delimiter','\n'); 
tweets = trumpTXT{1};

tweets(2)
tweets = lower(tweets);
tweets(2)
tweets = eraseTags(tweets);
tweets(2)
tweets = eraseURLs(tweets);
tweets(2)

torep = {'(?:\$+[\w_]+)?'};
strip(regexprep(tweet,torep,''))
tweets(2)

tweets = tokenizedDocument(tweets);