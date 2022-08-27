# MATH2121 -- Homework #3
Katrina Janeczko

Spring 2022

### Problem 3b:

I ran my code from 3a with 500 butterflies and plotted their paths and endpoints of their paths. The resulting plot is shown in janeczko_problem3a_plot_without_ground_lowering.png, which I will refer to as plot 1. Then I removed the lowering of the ground, and plotted the paths and endpoints, and the resulting plot is shown in janeczko_problem3a_plot_with_ground_lowering.png. I will call this image plot 2.

In plot 1, we see there are only 2 distinct positions for the endpoints of the butterflies' paths, one at the leftmost hill top and one at the rightmost hill top. There are more butterflies ending up at the leftmost hilltop, attributed to the higher elevation of that hill top, but since the butterflies' behavior is randomized (at each step, a butterfly has a 40% chance of choosing to step towards the highest nighboring cell and a 60% chance of choosing a random direction), some still end up at the rightmost hill top. 

In plot 2, the pattern that more butterflies fly up the leftmost hill holds. However, we see many more endpoints which begin to spread out as the simulation runs, some even making it to the boundaries of the plot. Additionally, the corridor width, or the imprint of the paths that all butterflies take, is much wider due to the ground lowering in the wake of each butterfly's steps. While with each butterfly the elevation is changing, the butterflies still tend to move to higher ground (hill topping) so that means they will likely wander further from the paths that were formed in plot 1 which was without the ground being lowered. There is a visible difference in the colored elevation plot, with darker colors (indicating lower elevations) concentrated around where the butterflies' paths begin. This is showing that the ground is being obviously lowered and carved out when many butterflies go over the same spots, which is what causes the paths to be so spread out since they keep trying to move to higher elevations (with a 40% probability each step).

