#!/bin/bash
# Create database flask_maria and user ram, also blank enployee table, mariadb bind address change
# Database credentials
db_user="root"
db_password="password"

# New user details
new_user="ram"
new_user_password="password"

# Database and privileges
database_name="flask_maria"

# Create the user and grant permissions
sudo mysql -u "$db_user" -p"$db_password" <<EOF
Create database $database_name;
CREATE USER '$new_user'@'localhost' IDENTIFIED BY '$new_user_password';
GRANT ALL PRIVILEGES ON $database_name.* TO '$new_user'@'localhost';
FLUSH PRIVILEGES;
USE flask_maria;
CREATE TABLE employees (
         employee_id INT PRIMARY KEY,
         first_name VARCHAR(50),
         last_name VARCHAR(50),
         job_title VARCHAR(100),
         salary DECIMAL(10, 2)
);
EOF

sudo echo "User '$new_user' created with password '$new_user_password' and granted all privileges on database '$database_name'."

#Changing bind port form 127.0.0.1 to 0.0.0.0, so that database access from romote
# Define the file you want to modify
file="/etc/mysql/mariadb.conf.d/50-server.cnf"

# Define the text you want to replace
old_text="bind-address            = 127.0.0.1"

# Define the new text you want to replace it with
new_text="bind-address            = 0.0.0.0"

# Replace the text in the file
sudo sed -i "s/${old_text}/${new_text}/g" "$file"

sudo echo "Text '${old_text}' replaced with '${new_text}' in ${file}."

sudo systemctl stop  mariadb; sudo systemctl start  mariadb; sudo systemctl enable mariadb
