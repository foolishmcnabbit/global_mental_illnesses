-- check the table
SELECT * FROM mental_illnesses
LIMIT 20;

-- maximum of each disorder
WITH schizophrenia AS (
	SELECT
		Country,
		Year,
		`Schizophrenia disorders` AS max_value
	FROM mental_illnesses
	ORDER BY `Schizophrenia disorders` DESC
	LIMIT 1
),
depressive AS (
	SELECT
		Country,
        Year,
        `Depressive disorders` AS max_value
	FROM mental_illnesses
    ORDER BY `Depressive disorders` DESC
    LIMIT 1
),
anxiety AS (
	SELECT
		Country,
        Year,
        `Anxiety disorders` AS max_value
	FROM mental_illnesses
    ORDER BY `Anxiety disorders` DESC
    LIMIT 1
)
SELECT
	"Schizophrenia disorders" AS disorder,
    schizophrenia.Country AS country,
    schizophrenia.Year AS year,
    schizophrenia.max_value
FROM schizophrenia
UNION ALL
SELECT
	"Depressive disorders",
    depressive.Country,
    depressive.Year,
    depressive.max_value
FROM depressive
UNION ALL
SELECT
	"Anxiety disorders",
    anxiety.Country,
    anxiety.Year,
    anxiety.max_value
FROM anxiety;

-- time series of disorders in the USA
SELECT
	Year,
    `Depressive disorders` AS depressive_disorders,
    `Schizophrenia disorders` AS schizophrenia_disorders,
    `Anxiety disorders` AS anxiety_disorders
FROM mental_illnesses
WHERE Country = "United States"
ORDER BY Year DESC;

-- order the countries by the highest depressive disorder value
SELECT
	Country,
    MAX(`Depressive disorders`) AS depressive_disorders,
    RANK() OVER (ORDER BY MAX(`Depressive disorders`) DESC) AS disorder_rank
FROM mental_illnesses
GROUP BY Country
ORDER BY MAX(`Depressive disorders`) DESC;

-- order the countries by the average depressive disorder value
SELECT
	Country,
    AVG(`Depressive disorders`) AS depressive_disorders,
    RANK() OVER (ORDER BY AVG(`Depressive disorders`) DESC) AS disorder_rank
FROM mental_illnesses
GROUP BY Country
ORDER BY AVG(`Depressive disorders`) DESC;