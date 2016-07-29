Utility tools for Time Series 
========================================================
author: Joaquim Assuncao
date: 08/2015


Introduction
========================================================
Time Series (TS) are broadly used both in academia and industry. 
However, considering a casual user, still difficult to find a user friendly tool.

In a moment, this tool focus on get the distance between two TS.
These measurements are used in many domains and for many purposes such as:

* Speech recognition
* Economy
* Behavior analysis
* Pattern recognition
* <i>etc.</i>


Distance Measurements
========================================================
There are a vast amount of works to measure distance between time series.
So far, the most known distance measurements are the Euclidian Distance (ED).

Although, there are many other techniques that could have a better performance depending on the used scenario, Dynamic Time Warping (DTW) for example, is efficient to get a good alignment between two time series.


Distance Measurements - ED
========================================================
Let's consider two time series, $V$ and $S$, with the same length $T$, then:

$V=  v_1,v_2,...,v_T$

$S= s_1,s_2,...,s_T$


Euclidean Distance (ED) is formally defined as:
$ED=|S-V|= \sqrt{\sum_{i=1}^{n}(s_i-v_i)^2}$


Euclidian Distance - Example
========================================================
![plot of chunk unnamed-chunk-1](presentation.R-figure/unnamed-chunk-1-1.png) 

```
         TSa
TSb 1.414214
```


```r
V <- c(2,3,2,3,4)
S <- c(3,4,2,3,4)
```
or...
$ED=|S-V|= \sqrt{\sum_{i=1}^{5}(s_i-v_i)^2}$ $=$ $\sqrt{2} = 1.414214$


Measurements - DTW
========================================================

Dynamic Time Warping (DTW) is a technique that allows a non-linear mapping of one time series to another, minimizing the distance between then. 

The non-linear mapping performed by DTW, allows us to get the distance between two TS considering their alignment.
In other words, the time warping is considered to get the best relation between distance and alignment.

Measurements - DTW example
========================================================
Consider two TS, $S=\{1,2,1,2,1,2,1\}$ and $V=\{1,1,2,1,2,1,2\}$.

Using the traditional Euclidean distance, these TS are very distant from each other. 
However their both have a similar behavior, $V$ is just a bit shifted from $S$, thus an alignment would group the points $S_{(t)}$ and $V_{(t+1)}$, retrieving a lower distance through DTW.

![plot of chunk unnamed-chunk-3](presentation.R-figure/unnamed-chunk-3-1.png) 


Measurements - DTW example
========================================================


Euclidean Distance

```
        s
v 2.44949
```

##### DTW distance

```
[1] 1.5
```

![plot of chunk unnamed-chunk-6](presentation.R-figure/unnamed-chunk-6-1.png) 



Online
======================
GO ahead: <small>https://joaquim.shinnyapps.io/TS</small>


