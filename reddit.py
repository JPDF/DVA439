import configparser
import praw

conf = configparser.ConfigParser()
conf.read('config.ini')

client_id = conf['REDDIT']['client_id']
client_secret = conf['REDDIT']['client_secret']
username = conf['REDDIT']['username']
password = conf['REDDIT']['password']
user_agent = conf['REDDIT']['user_agent']

reddit = praw.Reddit(client_id=client_id, client_secret=client_secret, password=password, user_agent=user_agent, username=username)

