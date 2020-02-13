CREATE DATABASE IF NOT EXISTS tweetcmp;
use tweetcmp;

drop table if exists User_Account;
create table User_Account(
userAccount_name char(50),
userAccount_posting_user varchar(15) not null,
userAccount_followers int,
userAccount_following int,
userAccount_sub_category varchar(100),
userAccount_category varchar(100),
userAccount_location varchar(100),
unique(userAccount_posting_user),
primary key(userAccount_posting_user)
);

drop table if exists newtweet;
create table newtweet(
newTweet_day_posted int,
newTweet_month_posted int,
newTweet_year_posted int,
newTweet_posted date,
newTweet_posting_user varchar(15) not null,
newTweet_tid bigint,
newTweet_retweet_count int,
newTweet_textbody varchar(280),
unique(newTweet_tid),
primary key(newTweet_tid),
foreign key(newTweet_posting_user) references User_Account(userAccount_posting_user)
);

drop table if exists Hashtag;
create table Hashtag(
hash_name varchar(280),
hash_tid bigint,
foreign key(hash_tid) references newtweet(newTweet_tid) on delete cascade
);

drop table if exists URL_Table;
create table URL_Table(
url_tid bigint,
url_address varchar(500),
foreign key (url_tid) references newtweet(newTweet_tid) on delete cascade
);

drop table if exists US_State;
create table US_State(
ofstate char(48)
);

drop table if exists mentioned;
create table mentioned(
mentioned_tid bigint,
mentioned_posting_user varchar(15) not null
);

drop table if exists appuser;
create table appuser(
username varchar(15),
pwd varchar(100),
app_privileges text
);


delimiter //
CREATE TRIGGER upd_check before insert ON us_state
     FOR EACH ROW
     BEGIN
         IF new.ofstate = '' or new.ofstate is null
         THEN
             SET new.ofstate = 'na';
         END IF;
    END;//
 delimiter ;
