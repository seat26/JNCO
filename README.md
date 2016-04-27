# JNCO
JNCO is a robust and efficient model to identify both the recurrently group-wised and individually sample-wised CNVs from aCGH data. JNCO is written in Matlab 2012b. It runs within envioments of the Matlab 2012b or higher version.

##1. File list:
	Experiment_Simulated.m: the demo of experiments on simulated data.
	Expeirment_Pig_Data.m: the demo of emprical experiment on  12 pig aCGH sample.
	Experiment_Breast_Cancer.m: the demo of emprical experiment 44 breast cancer sample (aCGH).
	JNCO.m: the algorithm for the proposed JNCO model.
	ROC.m: Receiver operating characteristic. For each threshold, the True Positive Ratio and the False Positive Ratio are calculated.
	flsa.*: external mex functions to solve flsa.
	data/*: It includes the simulated data, breast cancer data and pig sample data.

##2. Code execute: 
	Please run Experiment_Simulated.m, Expeirment_Pig_Data.m and Experiment_Breast_Cancer.m to conduct the exriments on different datasets.

##3. Contact:
   hmcai@scut.edu.cn
