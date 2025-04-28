#### This project features the following files to easily reproduce the data in the article.
 data.txt:\
* a simple text file featuring four columns, where the first and third columns are names,
 and the second and fourth columns are their respective values.
 * This file is read by the running_simulations.sh script line by line

init.cps: 
* initial COPASI file, where selected initial simulation values are replaced by strings; these strings
will be substituted with the values set in data.txt and in running_simulations.sh.
* the COPASI file can be run by the COPASI reaction kinetics simlation software which is freely available
under the Artistic License 2.0 (https://copasi.org/Download/License/) and can be downloaded from:
https://copasi.org/Download/

running_simulations.sh: 
* this script first creates the output file (results.txt) which will contain the final, steady-state values of
the selected variables (concentrations, potentials), relevant constants (such as standard portentials, 
rate constant, solvent reorganization energy, etc); and set the column names; 
* then defines a filename for the temporary COPASI input file, where all the initial parameters are substituted with their
actual values
* then a list of parameters and their values are set
* then the data.txt file is read line-by-line and for each line the actual parameter and value pairs are read and inserted into
the temporary COPASI file
* then the remaining parameters are substituted with their values
* then for this new proper input file the COPASI run is carried out
* then from the COPASI output file (time_course_results.txt) the last line is copied to our results file.

results.txt:
* this file is created by the running_simulations.sh and it contains the steady-state values of the selected properties for
each combination of the standard ground-state and excited-state reduction potentials of PC.
* note that during the run, a temporary file is created and rewritten (time_course_results.txt) which contains the time evolution of the
selected properties (concentrations, potentials, etc.). At the end of a time-course simulation the last line of this file is concatenated to "results.txt" after each time-course simulations.
 
results_analysis.ipynb:
* this is a jupyter-notebook file which reads the output file created by running_simulations.sh; cleans the data and visualizes the
  actual quencher redox potential as a function of the standard ground and excited state reduction potentials of the photocatalyst.
