# Pewlett Packard Analysis

## Retiring Employees and Mentorship Eligibility

Hello Bobby, 

I am presenting my conclusions of the Retiring Employees analysis. The information can be found in the "PH Challenge Final Analysis" a large amount of employees that are going to be retiring so the databases created show all the employees that are about to retire as well as the count of job openings there will be per job title. The database "retire_emp_current_title", contains the list of all retiring employees and their current job title. There are 33,118 employees that are close to their retirement. The csv file "count_per_title", shows the count of job openings there will be per title. For the second deliverable, I have included the number of employees and their current job titles. There are 1,549 that are eligible for mentorship.

For the first retiring employees database, we have selected only the employees with a year of birth between 1952 and 1955. We only want the employees that are still working at the company, and where hired between 1985 and 1988. The first pass at the code was run without the hire date information, so the count was doubled, and the narrowed down with the hire date information. I have use the to_date value to check on the employees that have a current to_date meaning this employees are still working at the company. There were some hiccups on deciding which tables to join, as some tables contain almost the same information except for one column. In the end I decided to join different columns with each other, for example the titles and salary tables and create a new one, and then join this table with the one that had the required information for our investigation, giving me the results I needed. For the second deliverable we only wanted the employees with a birth year of 1965, again the employees that are still at the company, and then their current job title. The same steps were followed for this deliverable. The partitioning portion of the code got a bit tricky, but with the documentation you shared I was able to write a working code.

As final conclusions having the amount of retiring employees, their names, and their titles, can help us prepare ahead. It would be beneficial to also have the amount of retiring employees per department, that way we would know which departments will need more attention when we get to the hiring state. Every department is of great importance to the company, yet there are some that are more relevant to the business, and need more immediate attention. A bit of a further investigation comparing other pieces of information can help us create a better plan to face the upcoming “silver tsunami” impact. For the mentorship eligible employees the information is straight forward with the current title of each employee eligible. We can create a mentorship program per title so that we know the mentorship team have the same experience and information. It would be valuable as well to have the count per department so we can better organize mentoring teams. 

Please let me know what additional information you would like to have and we can get right into it. 

Regards, 
Leo
