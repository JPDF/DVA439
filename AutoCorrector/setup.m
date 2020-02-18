% Create a distance searcher for the spell checker (Might take a while)
scowlFolder = 'AutoCorrector/scowl-2018-04-16';
vocabulary = scowlWordList(scowlFolder, 'english', 60);
eds = editDistanceSearcher(vocabulary, 2, 'SwapCost', 1);

save 'AutoCorrector/eds' eds