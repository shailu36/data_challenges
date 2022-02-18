# data-challenges
## Challenges
### 1. Query Optimization
A common challenge encountered when working with data related to financial entities is combining datasets that utilize different identifier schemes. For instance, a proprietary dataset from one provider might use a bespoke unique ID. While a publicly available dataset might use a standardized identifier like an alphanumeric Instrument ID. Being able to associate disparate datasets to individual financial entities using various identifiers like these in order to gain insight from them is a core function of our Data team.

Your task is to use the PostgreSQL schema and tables contained in [data.dmp](/query_optimization/data.dmp?raw=true) to summarize some (E)nvironmental, (S)ocial, (G)overnance, and Total Impact scores for fictitious entities listed on the S&P 500. Your requirements are as follows:
* Determine the most efficient method of joining the included `sp500`, `id_map`, and `esg_scores` tables
* Create a new `sp500_esg_scores` table that lists all available id, name, and score columns for the S&P 500 constituent entities
* Add a `rank` column to the new `sp500_esg_scores` table that ranks the S&P 500 constituent entities by percentile on `total_score` in ascending order
* Add a MEDIAN row to the `sp500_esg_scores` table that shows the median value for each score column across the S&P 500 constituents 
* Make sure that where S&P 500 constituent entities are missing score values they still appear in the `sp500_esg_scores` table and are ranked in the 0 percentile
* Suggest a database and ETL architecture if there were a much larger universe of companies eg. 50,000. This universe would be updated on a weekly basis and rankings would need to be recomputed upon update.

Your submission should include a new `esg_analysis.dmp` file with the database code to replicate your solution as well as a `query.sql` file containing the SQL query used to produce the `sp500_esg_scores` table.

### 2. Carbon Analytic Calculation
Utilizing the provided [Jupyter Notebook](/carbon_calculation/carbon_analytic_calculation.ipynb?raw=true) (and additional libraries/files/tools as needed) implement a function that can be utilized to calculate the (strawman) Adjusted CO2 Total emissions for a company. The calculation is laid out below. The data is stored inside of the [included data file](/carbon_calculation/data.json?raw=true). 

Your code structure can take whatever you believe to be best (individual function, class, module, etc.). Please implement the code as well as write tests with pytest or unittest for the calculation, showcasing how you would write tests for such requirements. Provide instructions with your submission for how to call your implemented function as well as how to run the tests.

![Calculation](/carbon_calculation/calculation.png?raw=true "Calculation")

* Suggest how to orchestrate updating the data and then computing this. Assume the data is saved in a PostgreSQL database.

## Submission
When you are ready to submit your solution, please follow these instructions:
* Please do not fork this repo to your own GitHub account!
* Instead, download this repo to your local machine and create a new repo as a copy of it on your own GitHub account.
* Commit all of your work to a new branch on your copy of the repo.
* Submit your work via email as a .zip file containing your working branch of the repo and include any necessary instructions.
