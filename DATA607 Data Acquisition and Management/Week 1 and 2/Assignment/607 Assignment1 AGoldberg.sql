--1A. 
SELECT count(*)
  FROM planes
 WHERE speed IS NOT NULL;
--23 airplanes have listed speeds
 
--1B. 
SELECT max(speed), min(speed)
 FROM planes;
--Max = 432, Min = 90
  
--2a. 
SELECT sum(distance)
  FROM flights
 WHERE year = '2013' and month = '1';
 --Total distance in Jan 2013: 27188805
 
--2b.
SELECT sum(distance)
 FROM flights
WHERE year = '2013' and month = '1' and tailnum IS NULL
--Total distance in Jan 2013 w/out tailnum = 81763

--3a.
    SELECT p.manufacturer, sum(f.distance)
      FROM planes p
INNER JOIN flights f
        ON p.tailnum = f.tailnum
     WHERE f.year = '2013' and f.month = '7' and f.day = '5'
  GROUP BY p.manufacturer;

--manufacturer sum(f.distance) 	 
--AIRBUS	195089
--AIRBUS INDUSTRIE	78786
--AMERICAN AIRCRAFT INC	2199
--BARKER JACK L	937
--BOEING	335028
--BOMBARDIER INC	31160
--CANADAIR	1142
--CESSNA	2898
--DOUGLAS	1089
--EMBRAER	77909
--GULFSTREAM AEROSPACE	1157
--MCDONNELL DOUGLAS	7486
--MCDONNELL DOUGLAS AIRCRAFT CO	15690
--MCDONNELL DOUGLAS CORPORATION	4767

--3b.
SELECT p.manufacturer, sum(f.distance)
      FROM planes p
LEFT JOIN flights f
        ON p.tailnum = f.tailnum and f.year = '2013' and f.month = '7' and f.day = '5'
  GROUP BY p.manufacturer;

  --Inner joins reflect the intersection of both tables, where they share values on row conditions. Left outer joins 
  --include the full left table, even when there is no matching data from the right table, in example Agusta Spa
--manufacturer sum(f.distance) 	
AGUSTA SPA	
AIRBUS	195089
AIRBUS INDUSTRIE	78786
AMERICAN AIRCRAFT INC	2199
AVIAT AIRCRAFT INC	
AVIONS MARCEL DASSAULT	
BARKER JACK L	937
BEECH	
BELL	
BOEING	335028
BOMBARDIER INC	31160
CANADAIR	1142
CANADAIR LTD	
CESSNA	2898
CIRRUS DESIGN CORP	
DEHAVILLAND	
DOUGLAS	1089
EMBRAER	77909
FRIEDEMANN JON	
GULFSTREAM AEROSPACE	1157
HURLEY JAMES LARRY	
JOHN G HESS	
KILDALL GARY	
LAMBERT RICHARD	
LEARJET INC	
LEBLANC GLENN T	
MARZ BARRY	
MCDONNELL DOUGLAS	7486
MCDONNELL DOUGLAS AIRCRAFT CO	15690
MCDONNELL DOUGLAS CORPORATION	4767
PAIR MIKE E	
PIPER	
ROBINSON HELICOPTER CO	
SIKORSKY	
STEWART MACO	

--4. Which airplane model is used most by Delta? 
select * from airlines
	SELECT a.name, p.manufacturer, p.model, count(f.flight) as flights
	  FROM flights f
INNER JOIN airlines a
        ON f.carrier = a.carrier and a.name like '%Delta Air Lines Inc.%'
INNER JOIN planes p
        ON f.tailnum = p.tailnum
  GROUP BY p.model
  ORDER BY Flights desc;
  
Delta Air Lines Inc.
	MCDONNELL DOUGLAS CORPORATION	MD-88	10191
Delta Air Lines Inc.
	AIRBUS INDUSTRIE	A319-114	9713
Delta Air Lines Inc.
	BOEING	737-832	8735
Delta Air Lines Inc.
	AIRBUS INDUSTRIE	A320-212	4271
Delta Air Lines Inc.
	BOEING	757-232	3980
Delta Air Lines Inc.
	AIRBUS INDUSTRIE	A320-211	2906
Delta Air Lines Inc.
	BOEING	757-231	2380
Delta Air Lines Inc.
	BOEING	757-2Q8	2283
Delta Air Lines Inc.
	BOEING	737-732	1356
Delta Air Lines Inc.
	BOEING	767-332	1278
Delta Air Lines Inc.
	BOEING	717-200	376
Delta Air Lines Inc.
	BOEING	757-251	162
Delta Air Lines Inc.
	MCDONNELL DOUGLAS	DC-9-51	91
Delta Air Lines Inc.
	BOEING	767-3P6	87
Delta Air Lines Inc.
	MCDONNELL DOUGLAS	MD-90-30	74
Delta Air Lines Inc.
	BOEING	757-26D	65
Delta Air Lines Inc.
	BOEING	767-432ER	32
Delta Air Lines Inc.
	AIRBUS	A330-223	4
Delta Air Lines Inc.
	BOEING	757-351	4
Delta Air Lines Inc.
	BOEING	777-232	4
Delta Air Lines Inc.
	BOEING	767-324	4
Delta Air Lines Inc.
	BOEING	757-212	2
Delta Air Lines Inc.
	BOEING	747-451	1
Delta Air Lines Inc.
	AIRBUS	A330-323	1