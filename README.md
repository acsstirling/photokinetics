#### This project features the following files to easily reproduce the data in the article.
 data.txt:\
* a simple text file featuring four columns, where the first and third columns are names,
 and the second and fourth columns are their respective values.
 * This file is read by the running_simulations.sh script line by line

init.cps: 
* initial COPASI file, where selected initial simulation values are replaced by strings; these strings
are the substituted with the values set in data.txt and in running_simulations.sh.

running_simulations.sh: 
* this script first creates the output file which will contain the final, steady-state values of
the selected variables (concentrations, potentials), relevant constants (such as standard portentials, 
rate constant, solvent reorganization energy, etc); and set the column names; 
* then defines a filename for the temporary COPASI input file, where all the initial parameters are substituted with their
actual values
* then a list of parameters and their values are set
* then the data.txt file is read line-by-line and for each line the actual parameter and value pairs are read and inserted into
the temporary COPASI file
* then the remaining parameters are substituted with their values
* then for this new proper input file the COPASI run is carried out
* then from the result file the last line is copied to the output file.

results.txt:
* this file is created by the running_simulations.sh and it contains the steady-state values of the selected properties for
each combination of the standard ground-state and excited-state reduction potentials of PC.
* note that during the run, a temporary file is created and rewritten (time_course_results.txt) which contains the time evolution of the
selected properties (concentrations, potentials, etc.). In fact the last line of this file is concatenated to "results.txt" after
each time-course simulations.
 
results_analysis.ipynb:
* this is a jupyter-notebook file which reads the output file created by running_simulations.sh; cleans the data and visualizes the
  actual quencher redox potential as a function of the standard ground and excited state reduction potentials of the photocatalyst.
