CREATE USER 'cs363'@'%1' IDENTIFIED WITH mysql_native_password BY 'SirRammington123';
UPDATE mysql.user SET Delete_priv='Y', Select_priv='Y', Insert_priv='Y', Drop_priv='Y',Create_priv='Y' WHERE User='cs363';
FLUSH PRIVILEGES;
GRANT create, drop, select, insert, delete ON tweetcmp.* TO 'cs363'@'%1';
