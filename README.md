# README

Photo management application (with tweet function)

System requirements:

* Ruby version - ruby 2.6.0

* Rails version - Rails 5.2.3

Installation:

* Clone the project and enter the project directory

* Run `bundle install` to install gems.

* Create `config/local_env.yml` from `config\local_env.yml.example` and don't forget to put your credential in `local_env.yml`

* Run `rails db:setup` to setup the database. It uses SQLite database (the default one).

* Run `rails db:seed`. It will create two following users for testing. 

`UserID: unifa Password: 12345678` 

`UserID: sahidul Password: 12345678`

* Run `rails s` to run the project in development environment. Access this link `http://localhost:3000/`

Thank you :)