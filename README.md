# Student Profiles

This is companion software that extends the functionality of the popular educational software PowerSchool. It adds data visualizations, easier access to historical records, and a simple, but powerful, user interface to analyze student progress. 

## Getting Started

First, clone this repo and install dependencies:
```
git clone git@github.com:nptravis/student-profiles.git
cd student-profiles
bundle install
```

### Importing Data

This step requires you get data in JSON format, in order to import into the system. You will need 3 files exported from PowerSchool in JSON format, I recommend using SQLDeveloper to do this. Create a directory in the base level of the application name 'data' to place the files in. The SQL queries you will need are packed with this repositorym named sql-queries.sql. Once you have the data change this line of the included seeds file:
```SQL
Dir[File.join(Rails.root, 'db', 'seeds', '<change name to name of file>')].sort.each do |seed|
  load seed
end
```
First, migrate the database:
```
rails db:migrate
```
Now, for each file run:
```
rails db:seed
```

Now, seed the database in this order:
1. all-sections.rb
2. all-final-standards.rb
3. all-semester-comments.rb



## Click Around

Now, start the rails server like so:
```
rails s
```
Navigate to localhost:3000 and you will see the application, feel free to click around and explore all the data visualizations and easy access to your staff records. 

## Built With

* [Rails 5.1](https://guides.rubyonrails.org/v5.1/) - The web framework used
* [OmniAuth](https://github.com/omniauth/omniauth) - for google authentication
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers) - For JSON serialization
* [jQuery](https://jquery.com/) - Used to generate AJAX calls
* [Charts.js](https://www.chartjs.org/) - Javascript charting library used for data visualizations


## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Nic Travis** - *All work* - [nptravis](https://github.com/nptravis)


## License

This project is licensed under the Academic Free License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* A big hat tip to those at Chart.js! A great open source charting library, very customizable, wouldn't be able to create this software without them, thank you!

