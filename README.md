# StarStruck Cafe sales management tool

## Setup process for ubuntu 16.04

Make sure you have the latest version of ruby installed.

Install the database and related gems:

```
sudo apt-get install sqlite3 libsqlite3-dev

sudo gem install sqlite3 -v 1.3.11

sudo gem install sequel
```

Then prepare database:

```
ruby db_setup.rb

```

Run the app:

```
ruby main.rb
```
