-- userAccount
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user.csv'
into table User_Account
fields terminated by ';' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(userAccount_posting_user, userAccount_name,userAccount_sub_category,userAccount_category,userAccount_location,userAccount_followers,userAccount_following);

-- newtweet
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tweets.csv'
INTO TABLE newtweet
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(newTweet_tid,newTweet_textbody,newTweet_retweet_count,@col4,@col,newTweet_posting_user)
set newTweet_posted=@col,
newTweet_day_posted= day(str_to_date(@col, '%Y-%m-%d %H:%i:%s')),
newTweet_month_posted= month(str_to_date(@col, '%Y-%m-%d %H:%i:%s')),
newTweet_year_posted= year(str_to_date(@col, '%Y-%m-%d %H:%i:%s'));

-- url_table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/urlused.csv'
into table url_table
fields terminated by ';' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(url_tid,url_address);

-- hashtag
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tagged.csv'
into table hashtag
fields terminated by ';' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(hash_tid,hash_name);

-- mentioned
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mentioned.csv'
into table mentioned
fields terminated by ';' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(mentioned_tid,mentioned_posting_user);

-- fix this
-- us_state
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/user.csv'
into table us_state
fields terminated by ';' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1,@col2,@col3,@col4,ofstate,@col6,@col7);

DELIMITER $$
create trigger delete_related_tweets after delete 
on User_Account for each row 
begin
delete from newtweet
    where newtweet.newTweet_posting_user = old.userAccount_posting_user;
end$$
DELIMITER ;

