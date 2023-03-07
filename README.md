# ELPaW

#GraphTheory

Community detection near-linear algorithm for discovering the structure of complex networks.

Adaptation Evedential Label Propagation Algorithm, based on theory of beliefs (Dempster–Shafer
Theory/DST) for modeling uncertainity, node influence calculations and searching user behavioral patterns on site/mobile app using Google Analytics or mobile tracker data.

Goal: Find out 
- behaviroal patterns among users who have comitted online conversions on site/mobile app
- how many patterns exist
- how patterns distinguish each other

In classic ELP algorithm edges are not weighted, due to implement community detection algorithms in digital we need to establish edge weights and make it correctly.
By the way, for edge weight we use mutual information (MI) between nodes.

$$MI^{t}((F_{p},F_{q}),Y) = \sum _{(i,j)\in (F_{p},F_{q})}\sum _{l\in \{0,1\}}p^{t}((i,j),l)\log \frac{p^{t}((i,j),l)}{p^{t}(i,j)p^{t}(l)}$$

ELP use formula to calculate local density:

$$ \delta _{uv} = sim(u,v)\left ( \frac{\rho _{v}}{\rho_{u}} \right )^{\eta }$$

Instead it, we implement this:

$$ \delta _{uv} = sim(u,v)\left ( \frac{\rho _{v}}{\rho_{u}} \right )^{\eta }\left (\frac{Ew_{v}}{Ew_{u}} \right )^{1-\zeta }$$

Input: weighted Graph G(V, W(E)), where W(E) weight of edge E.<br />
&nbsp;Parameters:<br />
&nbsp;&nbsp;η: the parameter to adjust the density influence <br />
&nbsp;&nbsp;ζ: the parameter to adjust the weight influence <br />
&nbsp;&nbsp;T: the maximum number of iteration steps <br />
&nbsp;&nbsp;α0, γ: the parameters in Eq. (12) to define mass functions <br />
&nbsp;Initialization: <br />
&nbsp;&nbsp;(1). Calculate the influence of node j to node i, δij .<br />
&nbsp;&nbsp;(2). Initialize a unique label of each node in the network. <br />
&nbsp;&nbsp;The matrix S = {sij} is initially set to be an identity matrix. <br />
&nbsp;&nbsp;repeat <br />
&nbsp;(1). Arrange the nodes in the network in a random order and save them in set σ orderly. <br />
&nbsp;(2). Update the label of node i one by one according to the order in σ. One can then assign node i to the community
ωk with the highest plausibility and update the matrix S using Eqs. (20) and (21) until the maximum iteration number is reached or all
domain labels become stable. <br />
&nbsp;&nbsp;Output:  <br />
&nbsp;For each node, calculate the bba (mass) according to the labels of each node i, and output the bba matrix M = {mi}.




