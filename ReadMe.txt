Use Matlab 2016b. 

Run 1st section of demo_script.m to make the path.
In this section, you choose the dataset you want to work on :
	% choose dataset
	list={...}
	loadDataset(list{i});
i is the number of the chosen dataset : i = 
	1 : Double Swissroll (not use in the report)
	2 : Iris 
	3 : Parkinson (not use in the report)
	4 : Swissroll used in the report
	5 : Breast Cancer

2nd section : Eigenmap
You can modify in the options structure :
	The number of eigenvectors to compute
	The number of neighbors k (discussed in the report)
	The standard deviation sigma (discussed in the report)
    for each dataset, here are some good values:
    dataset eigenvectors neighbors sigma
    1		4			15			1
    2		4			15			2
    3		4			15 or 25	2
    4		4			20			1
    5		4			20			5

3rd section : Complexity analysis of eigenmap (with the Swissroll (i=4))
(Need the 2nd section to be run before)

4th section : Isomap
You can modify in the options structure :
	The number of eigenvectors to compute
	The number of neighbors k (discussed in the report)
    dataset eigenvectors neighbors	Comments
    1		2			 12
    2		2		     20
    3		4			 15			No good results
    4		2		     20
    5		2			 40

5th section: Plot of the neighbors graph
You can modify k the number of neighbors

6th section : Complexity analysis of isomap (with the Swissroll (i=4))
(Need the 4th section to be run before)  