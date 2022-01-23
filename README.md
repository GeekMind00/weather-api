Weather-API

## About The Project

> Weather-API is an API that provides endpoints for managing weather information.

### Built with

- main project [RoR](https://rubyonrails.org/)
- testing: [Rspec](https://rspec.info/).


## Getting Started

> This is an list of needed instructions to set up your project locally, to get a local copy up and running follow these instructions.

### Installation

1. **_Clone the repository_**

```sh
git clone git@github.com:GeekMind00/weather-api.git
```

2. **_Navigate to repository directory_**

```sh
$ cd weather-api
```

3. **_Install dependencies_**

```sh
$ bundle install
```

### Running

1. **_Running the application_**

```sh
$ rails s
```
- Routes:
    - To get a specific weather record using id:
   ```sh 
   get /weather/:id
   ```
    - To post a weather record : 
   ```sh 
   post /weather
   ```
   - To get all weather records sorted asc on id that match certain optional query parameters like (date,city,sort on date asc or desc):
   ```sh 
   get /weather?date=2000-05-05&city=New York&sort=-date
   ```

1. **Running the tests**

```sh
$ bundle exec rspec
```


