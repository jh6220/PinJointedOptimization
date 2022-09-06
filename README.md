# Drone arm structure optimizer
This code was created as a part of a second-year aerospace engineering module at Imperial College London. The goal was to design a 3D-printable drone arm that is able to witstand the forces from the motor and has the minimal possible mass (minimal 3D-printing cost). My approach was to idealize the structure as a 2D pinjointed structure and optimize it using a finite element solver and a gradient descent algorithms to minize its volume. 
# Optimization
To reduce dimensionality the algorithm only optimizes the nodes x and y coordinates while the cross-section is calculated to withstand the stress and buckling with given safety factor. The example of an inital design and optimized design is shown bellow:
![Initial and Final Optimisation](https://user-images.githubusercontent.com/72938727/188738473-0b427d77-170c-4b04-9050-45aac2e8c413.png)
The boundary conditions of the problem are shown bellow:
<img width="929" alt="Solver2" src="https://user-images.githubusercontent.com/72938727/188739238-95eec5db-78b8-4c31-a72a-8cca2ed04f56.png">
the main input into the solver are the safety factors, the allowable deflection and number of nodes. The comparison of the optimized designs for different number of nodes is shown below. The varation of number of nodes shown an optimal number. This is caused by the fact that with few nodes the dominant failure mode is buckling while at high number number of nodes its stress. The structure is optimized when both stress and buckling are a porblem as no material is wasted. 
<img width="1140" alt="Nodal Comparison" src="https://user-images.githubusercontent.com/72938727/188738992-51a09ad2-3b1c-41b8-a470-2a12fd2192e8.png">
the effects 
The dependecies between the other parameters were investigated are the results are shown bellow:
![number of nodes](https://user-images.githubusercontent.com/72938727/188739552-4f798239-d3f7-461e-bed8-808970f495af.png)
![max allowable deflection](https://user-images.githubusercontent.com/72938727/188739560-c3f26fda-bdd5-4624-8220-4500a981cfdd.png)
![buckling sf](https://user-images.githubusercontent.com/72938727/188739566-3af091a6-2e32-44b7-ad8e-d309389e96d6.png)

