# Url Shortener

✨✨[Online Demo](https://rongteng.herokuapp.com/)✨✨

📌 Url Shortener Service implements with Ruby on Rails.

Currently Support:

👉🏻 Generate shortened URLs (starts from 2 letters and is unique)

> Before:
> https://richitech.carto.com/u/manage/builder/f1ac72ff-499d-4b5c-8432-903ef164b8a8/embed
> 
> ✔️After
> https://rongteng.herokuapp.com/yf54TmBCn3enNnrchvvKeRfGa6

👉🏻 Be able to redirect to the original URL or copy the shortened URL

👉🏻 Can custom your shortened path
> 
> Before:
> https://richitech.carto.com/u/manage/builder/f1ac72ff-499d-4b5c-8432-903ef164b8a8/embed
> 
> ✔️After
> https://rongteng.herokuapp.com/taiwan-mask
> 

👉🏻 Shortened URLs click count statistics (May support analyze in the future)


## Requirement

- ruby 2.6.3
- rails 5.2.3
- Postgres


### Update configuration files

```
setup .env file (or .env.development), refer to the example file at .env.example
```

### Install Gem and Setup Database

```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec yarn install
```

### Run the server

Just run the rails command to start the server

```
bundle exec rails s
```

Then visit http://localhost:3000


### Testing

```
bundle exec rspec
```

## Author

- **Ya-Rong, Teng** - [RongRongTeng](https://github.com/RongRongTeng)

