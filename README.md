# ELPaW

#GraphTheory

Community detection near-linear algorithm for discovering the structure of complex networks.

Adaptation Evedential Label Propagation Algorithm, based on theory of beliefs (Dempster–Shafer
Theory/DST) for modeling uncertainity, node influence calculations and searching user behavioral patterns on site/mobile app using Google Analytics or mobile tracker data.

Goal: Find out 
-behaviroal patterns among users who have comitted online conversions on site/mobile app
-how many patterns exist
-how patterns distinguish each other

In classic ELP algorithm edges are not weighted, due to implement community detection algorithms in digital we need to establish edge weights and make it correctly.
By the way, for edge weight we use mutual information (MI) between nodes.

$$MI^{t}((F_{p},F_{q}),Y) = \sum _{(i,j)\in (F_{p},F_{q})}\sum _{l\in \{0,1\}}p^{t}((i,j),l)\log \frac{p^{t}((i,j),l)}{p^{t}(i,j)p^{t}(l)}$$

ELP use formula to calculate node influence:

$$ \delta _{uv} = sim(u,v)\left ( \frac{\rho _{v}}{\rho_{u}} \right )^{\eta }$$




