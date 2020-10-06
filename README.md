# README

#### 1. Environment
* ruby: 2.6.1
* rails: 5.2.3
* database: Postgres

#### 2. how to run
* 2.1 Install gems
````
bundle install
````
* 2.2 Regenerate master.key:

  Remove ```config/credentials.yml.enc```

  Run ```EDITOR=vim rails credentials:edit``` to create an default credentials.yml.enc
* 2.3 Setup database
````
rails db:create
rails db:migrate
`````
* 2.4 Run server
````
rails server
````
* open 'localhost:3000' in browser

