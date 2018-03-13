WEEK 1 SQL Homework
Andrew Goldberg
07/03/15

Q1 CODE:
SELECT
'Total Number of Flights:' as Heading,
Count(*) as totalflights
FROM flights

Q1 Answer:
"heading";"totalflights"
"Total Number of Flights:";336776 


Q2 CODE:
SELECT
Carrier,
Count(*) as totalflights
FROM flights
GROUP BY Carrier
ORDER BY Carrier

Q2 ANSWER:
"carrier";"totalflights"
"9E";18460
"AA";32729
"AS";714
"B6";54635
"DL";48110
"EV";54173
"F9";685
"FL";3260
"HA";342
"MQ";26397
"OO";32
"UA";58665
"US";20536
"VX";5162
"WN";12275
"YV";601

Q3 CODE:
SELECT
Carrier,
Count(*) as totalflights
FROM flights
GROUP BY Carrier
ORDER BY totalflights DESC

Q3 ANSWER:
"carrier";"totalflights"
"UA";58665
"B6";54635
"EV";54173
"DL";48110
"AA";32729
"MQ";26397
"US";20536
"9E";18460
"WN";12275
"VX";5162
"FL";3260
"AS";714
"F9";685
"YV";601
"HA";342
"OO";32

Q4 CODE:
SELECT
Carrier AS top5carriers,
Count(*) as totalflights
FROM flights
GROUP BY Carrier 
ORDER BY totalflights DESC
LIMIT 5

Q4 ANSWER:
"top5carriers";"totalflights"
"UA";58665
"B6";54635
"EV";54173
"DL";48110
"AA";32729

Q5 CODE:
SELECT
Carrier AS top5carriers,
Count(*) as totalflights
FROM flights
WHERE distance > 1000
GROUP BY Carrier 
ORDER BY totalflights DESC
LIMIT 5

Q5 ANSWER:
"top5carriers";"totalflights"
"UA";41135
"B6";30022
"DL";28096
"AA";23583
"EV";6248

Q6 Question: Show the average amount of seats per plane built by each manufacturer

Q6 CODE: 
SELECT
manufacturer,
round(AVG(seats)) as avgseats
FROM PLANES
GROUP BY manufacturer
ORDER BY manufacturer

Q6 RESULTS:
"manufacturer";"avgseats"
"AGUSTA SPA";8
"AIRBUS";221
"AIRBUS INDUSTRIE";187
"AMERICAN AIRCRAFT INC";2
"AVIAT AIRCRAFT INC";2
"AVIONS MARCEL DASSAULT";12
"BARKER JACK L";2
"BEECH";10
"BELL";8
"BOEING";175
"BOMBARDIER INC";74
"CANADAIR";55
"CANADAIR LTD";2
"CESSNA";5
"CIRRUS DESIGN CORP";4
"DEHAVILLAND";16
"DOUGLAS";102
"EMBRAER";46
"FRIEDEMANN JON";2
"GULFSTREAM AEROSPACE";22
"HURLEY JAMES LARRY";2
"JOHN G HESS";2
"KILDALL GARY";2
"LAMBERT RICHARD";2
"LEARJET INC";11
"LEBLANC GLENN T";2
"MARZ BARRY";2
"MCDONNELL DOUGLAS";162
"MCDONNELL DOUGLAS AIRCRAFT CO";142
"MCDONNELL DOUGLAS CORPORATION";142
"PAIR MIKE E";2
"PIPER";7
"ROBINSON HELICOPTER CO";5
"SIKORSKY";14
"STEWART MACO";2

