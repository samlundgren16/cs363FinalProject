insert into appuser(username,pwd) values ('all_user',sha1('Rammington1'));
set @pwd='Rammington1';
select * from appuser where username='all_user' and pwd=sha1(@pwd);

insert into appuser(username,pwd) values ('read_user',sha1('Rammington2'));
set @pwd='Rammington2';
select * from appuser where username='read_user' and pwd=sha1(@pwd);

CREATE USER 'all_user'@'%%' IDENTIFIED WITH mysql_native_password BY 'Rammington1';
UPDATE mysql.user SET Super_priv='Y' WHERE User='all_user';
FLUSH PRIVILEGES;
GRANT All ON tweetcmp.* TO 'all_user'@'%%';

CREATE USER 'read_user'@'%%' IDENTIFIED WITH mysql_native_password BY 'Rammington2';
UPDATE mysql.user SET Select_priv='Y' WHERE User='read_user';
FLUSH PRIVILEGES;
GRANT select ON tweetcmp.* TO 'read_user'@'%%';  

Update tweetcmp.appuser SET app_privileges='all_user' where appuser.username = 'all';
Update tweetcmp.appuser SET app_privileges='read_user' where appuser.username = 'read_only';
