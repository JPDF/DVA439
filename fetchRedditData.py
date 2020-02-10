import configparser
import logging
import praw
import csv
from tqdm import tqdm
from datetime import datetime

# Constants
CSV_FILE = 'data/reddit/popular.csv'

# Setup logging for praw
logging.basicConfig(filename='reddit.log', level=logging.DEBUG, format='%(asctime)s:%(levelname)s:%(name)s:%(message)s', datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger('prawcore')
logger.setLevel(logging.DEBUG)
# Read config file
conf = configparser.ConfigParser()
conf.read('config.ini')
# Reddit oath configs
client_id = conf['REDDIT']['client_id']
client_secret = conf['REDDIT']['client_secret']
username = conf['REDDIT']['username']
password = conf['REDDIT']['password']
user_agent = conf['REDDIT']['user_agent']
# Create reddit client handler
reddit = praw.Reddit(client_id=client_id, client_secret=client_secret, password=password, user_agent=user_agent, username=username)

# Open a write ready CSV file with utf-8 encoding to keep the emojies
with open(CSV_FILE, 'w', encoding='utf-8', newline='') as csvfile:
    csv_writer = csv.writer(csvfile, delimiter=',', quotechar='"')
    # CSV header
    csv_writer.writerow(['id', 'timestamp', 'comment', 'author'])
    # Loop over all the popular redditors
    for sub in tqdm(reddit.redditors.popular(limit=None)):
        # Get the redditor by name since redditors returns as a type of subreddit
        redditor = reddit.redditor(name=sub.display_name[2:])
        try:
            for comment in redditor.comments.new(limit=None):
                # Convert UTC timestamp format to a readable year-month-day hour:minute:second format
                timestamp = datetime.utcfromtimestamp(comment.created_utc).strftime('%Y-%m-%d %H:%M:%S')
                # Write comments to the CSV file
                csv_writer.writerow([comment.id, timestamp, comment.body, comment.author])
        except:
            # Skip the exception
            tqdm.write('Exception: ' + sub.display_name)
            pass

        