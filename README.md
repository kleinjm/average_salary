== Average Salary
=== Description
Average Salary is an application that pulls employee data from the publicly available [Boston Employee Earnings Report](https://data.cityofboston.gov/Finance/Employee-Earnings-Report-2014/4swk-wcg8) and calculates an average salary for a given job title.

The search will match similar titles in the given query while being case insensitive. I.e. `teacher` will match `Teacher`, `Teacher I, `Subsitute Teacher`, etc.)

=== Usage
===== JSON
To use the JSON API interface, simply hit the following path with your given `title` query. `/salary.json`
I.e. `https://average-salary.herokuapp.com/salary.json?title=teacher` will respond with the average salary as an unformatted decimal.

===== HTML UI
To use the UI, simply navigate to the home page `https://average-salary.herokuapp.com/` and type your search into the text box.
The average salary, number of records searched, and query string will display in a nicely formated space below the search form.

===== Error handling
Two unexpected situations are gracefully handled.
1. No title query is entered. In this situation the the JSON response will respond with a string asking for a valid query. The UI will display a modal with the same message.
2. No job titles match the given title query. The JSON response will respond with a string stating that no records were discovered with a title matching or similar to the given title query. The UI will display an alert underneith the search form with the same message.

=== Design and Archetechture
The application is designed to be extinsible in as many ways as possible. Good code is flexible code.

To fetch the data initially, a rake task is run that parses the relevant report data into a Postgres database. This decision was made for several reasons.
1. The report is a relatively small set of data.
2. The data model representing an employee can be extended easily to include addition fields from the report that may later be needed for additional functionality.
3. Rails provides record validation upon creation, thus data is sanitized.
4. Having the data locally reduces the risk of external API changes, trottling, etc.
5. Having the data locally allows for native rails queries rather than iterating a JSON response in memory. The query can be done in one database call.
6. The data in this example is historical and inherantly static.
7. The report JSON can be changed easily through an environment variable or rake task argument (future feature).

==== Additional Notes
* The controller is lightwieight and input data is validated. 
* The import is tested via the `EmployeeImport` class in the partnering spec using a stubbed request.

