#!/bin/sh
sudo apt-get install postgresql -y

sudo apt-get install libpq-dev -y

sudo service postgresql start
sudo -u postgres psql -c "DROP DATABASE pesquini_development" || true
sudo -u postgres psql -c "DROP USER pesquini" || true
sudo -u postgres psql -c "CREATE USER pesquini CREATEDB CREATEROLE INHERIT LOGIN" || true
sudo -u postgres psql -c "CREATE DATABASE pesquini_development WITH OWNER = pesquini" || true
bundle install
rake db:migrate
