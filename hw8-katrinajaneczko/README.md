# MATH2121 -- Homework #8
Katrina Janeczko

Spring 2022

### (a) Add a zone of attraction (agents steer towards average position of neighbors) to the swarming model, so that there is repulsion for distances less than 1/3, alignment for distances between 1/3 and 2/3, and attraction for a distances between 2/3 and 1. Compare the modified model (with attraction) to the model without attraction, describe the differences, and explain why they happen.

In the model without attraction, they begin to disperse from the middle and move toward the edges of the domain immediately. This is most likely due to the zone of repulsion causing the agents to turn away from each other right after being introduced to the model at its start when they are close together, and then aligning once they begin to move. The alignment is the main driving force causing the agents to swarm, since by turning to face the same direction, they all tend to begin traveling that same direction. This is especially obvious when the agents begin hitting the walls, clustering and aligning and creating a flock as they move by the boundary.

In the model with attraction, we see that agents cluster together in small groups soon after the start of the model. Minutes into the model running, we see that these clusters tend to be maintained.

### (c) Change your code from part (b) to have a zone of attraction, as in part (a). Now, using the codes from parts (b) and (c), run representative simulations that investigate whether the presence of a zone of attraction makes it more likely (or less likely) for all agents to form a single swarm. Explain your observations and interpret them.

In part (c), the zone of attraction tends to keep smaller swarms that form together, rather than tending toward a single swarm. In part (b) which does not have the zone of attraction, the main force being the zone of alignment between a distance of 1/3 to 1 is what drives the agents to be more likely to form a single swarm, rather than clustering together in smaller tight groups as in part (c).
