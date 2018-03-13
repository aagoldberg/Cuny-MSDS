--QUESTION1 CODE
--I iterated through the dep_delay in where clause to compare. I could have unioned, but seemed computationally expensive. 
--Looking back, I should have used the case expression here

SELECT 
	AVG(temp) AS temp, 
	AVG(dewp) AS dewp, 
	AVG(humid) AS humid, 
	AVG(wind_speed) AS windspeed,
	AVG(wind_gust) AS windgust, 
	AVG(precip) AS precip, 
	AVG(pressure) AS pressure, 
	AVG(visib) AS visib
FROM 

(
SELECT f.dep_delay, w.temp, w.dewp, w.humid, w.wind_speed, w.wind_gust, w.precip, w.pressure, w.visib
FROM flights f
INNER JOIN weather w 
ON w.year = f.year AND w.month = f.month AND w.day = f.day AND w.origin = f.origin
WHERE f.dep_delay > 240
) as joined

--Q1 ANSWER1:
--With higher departure delays, visibility and pressure decrease, and dewpoint, humidity, and precipitation increase

--delay	temp	dewp	humid	windspeed	windgust	precip	pressure	visib
--<0	9.383990848	1018.257311	0.002271846	10.57768555	9.191753025	61.26830674	41.39290476	55.79604944
--0	55.44766763	41.30562784	61.77678495	9.317328418	10.7221952	0.002413322	1018.015472	9.334589378
--0 to 60	55.37785266	41.81115336	63.12223937	9.357672421	10.76862227	0.00329454	1017.607834	9.20091052
--60 to 120	56.67578951	44.56780186	66.723025	9.414257573	10.83373933	0.00516942	1016.579981	8.86967059
--120 and 180	57.79471182	46.40033058	68.52226837	9.514310084	10.94887776	0.005448275	1015.855582	8.668308825
--180 and 240	60.4446256	49.56498724	69.87474515	9.087534759	10.45775325	0.005253084	1015.899743	8.594450447
-->240	60.94464262	50.80109343	71.62332736	8.821214279	10.15127697	0.006343339	1015.589091	8.311584528

--QUESTION2 CODE

SELECT 
(CASE 
	WHEN p.year < 1980 THEN 'before80'
	WHEN p.year BETWEEN 1980 AND 1990 THEN '80to90'
	WHEN p.year BETWEEN 1990 AND 2000 THEN '90to00'
	WHEN p.year BETWEEN 2000 AND 2010 THEN '00to10'
	WHEN p.year > 2010 THEN 'after10' ELSE NULL END) as age,
avg(CASE
	WHEN dep_delay < 0 THEN 0 
	WHEN dep_delay > 0 THEN 1 ELSE NULL END) as average
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
GROUP BY age

--older planes, on average, experience fewer delays
--age;average delays
--"00to10";0.43616872197309417040
--"90to00";0.42171162090280898194
--"80to90";0.34966902152750737053
--"before80";0.31096563011456628478
--"after10";0.42392532255187585469


--wrote this first, should have used CASE
SELECT 'Before1980' AS age, round(avg(dep_delay)) AS avgdelay
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
WHERE p.year < 1980

UNION

SELECT '80to90' AS age, round(avg(dep_delay)) AS avgdelay
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
WHERE p.year BETWEEN 1980 and 1990

UNION

SELECT '90to00' AS age, round(avg(dep_delay)) AS avgdelay
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
WHERE p.year BETWEEN 1990 and 2000

UNION

SELECT '00to10' AS age, round(avg(dep_delay)) AS avgdelay
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
WHERE p.year BETWEEN 2000 and 2010

UNION

SELECT 'After10' AS age, round(avg(dep_delay)) AS avgdelay
FROM planes p
JOIN flights f ON f.tailnum = p.tailnum
WHERE p.year > 2010

--Q2 ANSWER
--delays are also shorter for older planes

--Age; average delay
--"Before1980";8
--"After10";11
--"80to90";11
--"90to00";12
--"00to10";14

--Q3 question: What plane manufacturer can boast about the most flights departing NYC?
--CODE:

SELECT p.manufacturer, count(f.tailnum) as flights
FROM flights f
INNER JOIN planes p
ON f.tailnum = p.tailnum
GROUP BY p.manufacturer
ORDER BY flights DESC
LIMIT 10

--Answer: Boeing, followed by Embraer
manufacturer;flights
"BOEING";82912
"EMBRAER";66068
"AIRBUS";47302
"AIRBUS INDUSTRIE";40891
"BOMBARDIER INC";28272
"MCDONNELL DOUGLAS AIRCRAFT CO";8932
"MCDONNELL DOUGLAS";3998
"CANADAIR";1594
"MCDONNELL DOUGLAS CORPORATION";1259
"CESSNA";658


