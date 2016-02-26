## Average Salary
### Description
[Average Salary](https://average-salary.herokuapp.com) is an application that pulls employee data from the publicly available [Boston Employee Earnings Report](https://data.cityofboston.gov/Finance/Employee-Earnings-Report-2014/4swk-wcg8) and calculates an average salary for a given job title.

The search will match similar titles in the given `title` query while being case insensitive. I.e. `teacher` will match `Teacher`, `Teacher I`, `Substitute Teacher`, etc.)

### Usage
##### JSON
To use the JSON API interface, simply hit `/salary.json` with your given `title` query.

I.e. `https://average-salary.herokuapp.com/salary.json?title=teacher` will respond with the average salary as an unformatted decimal.

`title` is the only parameter

##### HTML UI
To use the UI, simply navigate to the [home page](https://average-salary.herokuapp.com/) and type your search into the text box.

The average salary, number of records searched, and query string will display in a nicely formatted space below the search form.

##### Error handling
Two unexpected situations are gracefully handled.

1. No `title` query is entered. In this situation the JSON response will respond with a string asking for a valid query. The UI will display a modal with the same message.
2. No job titles match the given `title` query. The JSON response will respond with a string stating that no records were discovered with a title matching or similar to the given `title` query. The UI will display an alert underneath the search form with the same message.

### Design and Architecture
The application is designed to be extensible in as many ways as possible. Good code is flexible code.

To fetch the data initially, a rake task is run that parses the relevant report data into a Postgres database. This decision was made for several reasons.

1. The report is a relatively small set of data.
2. The data model representing an employee can be extended easily to include addition fields from the report that may later be needed for additional functionality.
3. Rails provides record validation upon creation, thus data is sanitized.
4. Having the data locally reduces the risk of external API changes, throttling, etc.
5. Having the data locally allows for native rails queries rather than iterating a JSON response in memory. The query can be done in one database call.
6. The data in this example is historical and inherently static.
7. The report JSON can be changed easily through an environment variable or rake task argument (future feature).

### Libraries and Dependencies
Some gems were added to the out-of-the-box gems that come with a new `Rails 4.2.5` project.

1. `pg` - Postgres was used as the database due to Heroku's preference.
2. Bootstrap - CSS, theme, and JS library are linked to from the [Bootstrap](http://getbootstrap.com/) CDN. Additionally, `bootstrap_form` was bundled to add style to the main form. All used for clean and responsive design.
3. `factory_girl_rails` - Used to produce mock test objects.
4. `pry` tools - Personal preference for debugging.
5. `guard` - Personal preference for watching files and running tests.
6. `webmock` - Stubbing API calls in tests.
7. `database_cleaner` - Wiping the test DB after each test.
8. `haml-rails` - HAML generator

### Additional Notes
* The `EmployeeController` is lightweight and input data is validated. 
* The import is tested via the `EmployeeImport` class in the partnering spec using a stubbed request.
* Each gem in the gemfile has a note explaining it.

### References
[James M Klein](www.jamesmklein.com)

[Resume](http://www.jamesmklein.com/James_Klein_Resume.pdf)
