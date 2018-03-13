---
output:
  pdf_document: default
  html_document: default
---

Data 609 Presentation
========================================================
author: Andrey_Golberg & Valerie Briot 
date:   May 18th 2017
autosize: true

Solutions to Dynamical Systems; Mercury in Fish
(project 4, page 36))

Spread of contagious disease; 
(project 5, page 499)

Overview
========================================================

Chapter 1, Solutions to Dynamical Systems, project 4 (page 36):

Mercury in Fish: 

Humans can eliminate mercury from their system at a rate proportional to the amount remaining. Methyl mercury decays 50% every 65 to 75 days (known as the half-life of mercury) if no further mercury is ingested during that time. Officials in your city have collected and tested 2425 samples of largemouth bass from the reservoirs and provided the following data. All fish were contaminated. The mean value of the methyl mercury in the fish samples was 0.43 $\mu$g (microgram) per gram. The average weight of the fish was 0.817 kg. 

Part A
========================================================

-Assume the average adult person (70 kg) eats one fish (0.817 kg) per day.  

-Construct a difference equation to model the accumulation of methyl mercury in the average adult. 

-Assume the half-life is approximately 70 days.   

-Use your model to determine the maximum amount of methyl mercury that the average adulthuman will accumulate in her or his lifetime.  

Formula Formation: Half-life
========================================================

Half-life of Mercury (M) over 70 days:  $\ M(t) = M_{o}e^{-kt}$  

$M(70) = M_{o}e^{-k70} = \frac{M_{o}}{2}$ 

$e^{-70k} = \frac{1}{2}$  

$-70k = ln(\frac{1}{2})$  

$k = \frac{ln\frac{1}{2}}{-70} = .0099 = .01$  

So the formula made flexible for time:
$(e^{-t\frac{ln.5}{-70}})$
 

Formula Formation: The rest
========================================================

Humans eliminate mercury at rate proportional to amount remaining:
$(1-\frac{a_{n}}{70})$

Average adult person (70 kg or 70000 grams) eats one fish (0.817 kg or 817 grams) per day:  

Fish weight in grams = $f_{w}$  
Mercury level = $m$    
New mercury added per day:
$f_{w}m$  

Final formula:
$$a_{n+1}=a_{n}e^{-n\frac{ln.5}{-70}}(1-\frac{a_{n}}{70000})+(f_{w}m)$$

Calculations
========================================================


```r
#formula above
fish_mercury <- function(a){  
  a*((exp(1))^(-1*((log(.5))/-70)))*(1-(a/70000))+(((.817*1000)*.43))
}

#iterating through formula
life_mercury_levels <- function(days, starting_level){
  merc <- c(1:days+1)
  merc[1] <- fish_mercury(0)
  day <- c(0:days)
  for (i in 2:(days+1)){
    merc[i] <- fish_mercury(merc[i-1])
  }
  return(cbind(day, merc))
}
```

Data: Mercury Accumulation
========================================================
Mercury maxes out at 4647 grams

| days| mercury level|
|----:|-------------:|
|   59|      4646.447|
|   60|      4646.593|
|   61|      4646.717|
|   62|      4646.825|
|   63|      4646.917|
|   64|      4646.996|
|   65|      4647.064|
|   66|      4647.122|
|   67|      4647.172|
|   68|      4647.215|
|   69|      4647.252|
|   70|      4647.283|

Plot of data
========================================================
Mercury levels off quickly after 20 days
![plot of chunk unnamed-chunk-3](Briot_Goldberg_Final-figure/unnamed-chunk-3-1.png)

Part B
========================================================

-You find out that there is a lethal limit to the amount of mercury in the body; it is 50 mg/kg. 

-What is the maximum number of fish per month that can be eaten without exceeding this lethal limit?  

Formula Formation: Half-life
========================================================

Adjusting each portion of the formula for a 30 day period requires multiplying daily mercury intake per fish by a new variable denoting how many fish $d$ digested per day.  

Daily intake of mercury = $df_{w}m$

Now we can run a simulation of the full formula over a 30 day period for different amounts of daily fish intake:
$$a_{n+1}=a_{n}e^{-n\frac{ln.5}{-70}}(1-\frac{a_{n}}{70000})+(df_{w}m)$$

Calculations
========================================================


```r
#formula above
fish_mercury <- function(a, d){
  a*((exp(1))^(-1*((log(.5))/-70)))*(1-(a/70000))+((d)*(((.817*1000)*.43)))
}
#iterating through for different amounts of fish a day
life_mercury_levels <- function(days, max_daily_fish){
  totals <- data.frame(matrix(ncol = length(max_daily_fish), nrow = days))
  for (j in 1:max_daily_fish){
    fish_iter <- seq(0, j, j/days)
    totals[1,j] <- fish_mercury(0,(fish_iter[2]))
    for (i in 2:(days)){
      totals[i,j] <- fish_mercury((1+totals[i-1,j]), j)
    }
  }
  colnames(totals) <- c(1:max_daily_fish)
  return(totals)
}
```
Data: Mercury Accumulation after 30 Days
========================================================
We see the total amount of mercury in the system after 30 days, to reach the fatal 50k grams, would require 103 fish/month

|   |      101|      102|      103|
|:--|--------:|--------:|--------:|
|28 | 49737.33| 49984.66| 50230.77|
|29 | 49737.33| 49984.66| 50230.77|
|30 | 49737.33| 49984.66| 50230.77|

![plot of chunk unnamed-chunk-5](Briot_Goldberg_Final-figure/unnamed-chunk-5-1.png)

Data: Monthly Mercury Accumulation
========================================================
However, if we look at the relative mercury levels per day, we see a quick spike maxing out on the third day, then a resettling decrease on the fourth day.

|       101|       102|       103|
|---------:|---------:|---------:|
|  1182.744|  1194.454|  1206.164|
| 36634.569| 36997.080| 37359.587|
| 52772.039| 53104.717| 53433.677|
| 48341.757| 48524.232| 48705.515|

![plot of chunk unnamed-chunk-6](Briot_Goldberg_Final-figure/unnamed-chunk-6-1.png)

Data: Mercury Accumulation on 3rd Day
========================================================
So looking at the third day of each, we hit 50k grams at 94 fish/month, meaning 93 is the max amount of fish one can eat a month. 

|       90|       91|        92|        93|        94|        95|        96|        97|
|--------:|--------:|---------:|---------:|---------:|---------:|---------:|---------:|
|  1053.93|  1065.64|  1077.351|  1089.061|  1100.771|  1112.482|  1124.192|  1135.902|
| 32646.69| 33009.25| 33371.797| 33734.343| 34096.885| 34459.423| 34821.957| 35184.487|
| 48867.20| 49240.78| 49610.635| 49976.775| 50339.197| 50697.900| 51052.885| 51404.152|
| 46225.01| 46427.78| 46628.142| 46826.208| 47022.095| 47215.917| 47407.789| 47597.821|

![plot of chunk unnamed-chunk-7](Briot_Goldberg_Final-figure/unnamed-chunk-7-1.png)

The Spread of a Contagious Disease.
========================================================

Consider the following ordinary differential equation model for the spread of a communicable disease:
$\frac { dN }{ dt } =.25N(10-N),\quad N(0)=2$  

where N is measured in 100's.  
this is an autonomous differential equation and we will analyse its behavior using various methodologies.

  
Analysis Methodologies
========================================================
1. Qualitative graphical analysis  
    + (i) Plot dN/dt versus N and equilibrium points  
    + (ii) Estimate fastest rate of change of the disease
    + (iii) Plot N versus t for N(0)=2, N(0)=7, and N(0)=14  
    + (iv) Describe the stability of each equilibrium point  
    
2. Slope Field  
3. Solve Differential Equation and plot solution  
4. Compute t when N is changing the fastest, N(0) = 2  
5. Approximation of solution curves using Euler method
6. Approximation of solution curves using Runge-Kutta 4th


Graphical Analysis - Plot dN/dt vs N
========================================================
We will first plot dN/dt versus N, for some value of N. 
Equilibrium (or rest point) are all the values of N
for which dN/dt = 0.  

We will find these by setting the equation to Zero.  

$\frac { dN }{ dt } =.25N(10-N)=0$ 

Hold true for  N=0 or N=10 

We will first construct a phase line for the equation 
by ploting the equilibrium value on the y axis and 
analysis the intervals 
where $\frac { dN }{ dt }$ and $\frac { { d }^{ 2 }N }{ { (dt) }^{ 2 } }$ are positive and negative.  


Graphical Analysis - Plot dN/dt vs N 
========================================================
We will first derive $\frac { { d }^{ 2 }N }{ { (dt) }^{ 2 } }$ by differentiating N' 
with respect to t using implicit differentiation.  

$N'\quad =\quad \frac { 1 }{ 4 } N(10-N)\quad \Leftrightarrow \quad N'\quad =\quad \frac { 5 }{ 2 } N\quad -\quad \frac { 1 }{ 4 } { N }^{ 2 }$  

Differentiating on each side, we get:  

$N''\quad =\quad \frac { d }{ dt } (\frac { 5 }{ 2 } N\quad -\quad \frac { 1 }{ 4 } { N }^{ 2 })\quad \Leftrightarrow \quad \frac { 5 }{ 2 } N'\quad -\quad \frac { 1 }{ 4 } (2N.N')\quad \Leftrightarrow \quad \frac { 1 }{ 2 } (5-N)N'$  

Substituting dN/dt for N', we get:  

$N''\quad =\quad \frac { 1 }{ 2 } (5-N)\cdot \frac { 1 }{ 4 } N(10-N)\quad \Leftrightarrow \quad \frac { 1 }{ 8 } N(5-N)(10-N)$  


Graphical Analysis - Plot dN/dt vs N 
========================================================

 |                                            | '< 0' | $0<N<5$ |  $5<N<10$  | $N>10$ |       
 |--------------------------------------------|:-----:|:-------:|:----------:|:------:|       
 | N                                          | -     | +       | +          | +      |      
 | 10-N                                       | +     | +       | +          | -      |          
 | 5-N                                        | +     | +       | -          | -      |           
 | $\frac { dN }{ dt }$                       | -     | +       | +          | -      |                
 | $\frac { { d }^{ 2 }N }{ { (dt) }^{ 2 } }$ | -     | +       | -          | +      |  
 

![phase line](C:\Users\vbrio\Documents\Cuny\DATA_609\Final Project\Andrew_Golberg_Valerie_Briot_slides-figure\final_figure1.png)
  
  
  
Graphical Analysis - Plot dN/dt vs N 
========================================================

**Analysis**  

N=0 and N=10 are equilibrium points. 

The solution curve below line N=0 woud fall away from line N=0, 
however, since N>0, this is not part of solution curve.

The solution curve between N=0 and N=10 raise away from N=0 and towards N=10,  

Finally, the solution curve above N=10 falls towards N=10.  


Graphical Analysis - Fastest Rate of Change  
========================================================

From the phase line analysis, we can see that the solution curve change concavity at N=5.  This will be an inflection point.  
At this point, the rate of the change of the function will be the higest.

The rate of change correspond to the first derivative (N'),  

Since $\frac { { d }^{ 2 }N }{ { (dt) }^{ 2 } }$ goes from positive to negative, 
this will be a maximum  when its derivative (N''=0).


Graphical Analysis - N vs t
========================================================
(see Figure 2 for plot)  
![Solution Curves N(t)](C:\Users\vbrio\Documents\Cuny\DATA_609\Final Project\final_figure2.jpg)

Graphical Analysis - Stability of Equilibrium point(s)  
========================================================  

Once the solution curve has a value near N=10, 
it tends steadily towards this value, N=10 is a stable equilibrium.

However for N=0, is a trivial solutioln, since we would have no population and no growth.  

Slope Field  
========================================================  





























































```
Error in eval(expr, envir, enclos) : could not find function "ggplot"
```
