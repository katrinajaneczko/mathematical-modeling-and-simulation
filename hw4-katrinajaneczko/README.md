# MATH2121 -- Homework #4
Katrina Janeczko

Spring 2022

### Problem 4a:

For both parts (a) and (b), the model initially spawns `N = 500` animals evenly 
dispersed on the left half of the 10x10 graph (the left side of the domain). 
If `n` represents the amount of agents (animals) in a cell, then cells that 
had `7 ≤ n ≤ 10` agents were given a variable chance to spawn a child, and we
can call this probability `q`.

In part (a), an offspring producing cell has probability `q = 1/4 = 0.25` 
(in each step) of producing a new agent. Then with this probability in part 
(a), I observe that the population of animals would demonstrate a pattern of 
increasing the amount of agents, while also spreading out across the coordinate plane. 
The spread across the coordinate plane would cause the population to dwindle slightly, 
but it would recuperate enough to see a steady increase over the lifetime of the 
simulation. Over time, the population definitely increaes. It seems like as time 
goes on, the value of `N` approaches `700`.


### Problem 4b:

In part (b), the model retains all the same conditions as in part (a) except that
the probability is modifed such that `q = 1/5 = 0.2`. When simulating with this 
probability, this means there is a lower probability that an offspring-producing
cell will create a new agent. I observed that running the model in part (b),
the popualation continuously declines as time went on. I noticed that over time, 
the population would go through a phase of steady decline, then a phase where the 
population plateaus for a moment, going up slightly at points, but never enough 
to see a significant increase. The simulation would eventually end with `0` agents. 
