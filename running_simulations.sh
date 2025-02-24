# Create (or overwrite) the results.txt file with a header
echo "time	EP0	EQ	EP*	[PC]	[PC+]	[Q]	[Q-]	[PC*]	EQh	lambda	Ilamp	Abscoef	k2	Gdiff" > results.txt

# Define the filename to be used in the simulation
fname="FOTO_MODELL_2022.cps"

# reading the parameters we might want to change
declare -A input_names_values
while IFS=' ' read -r name value; do
    input_names_values["$name"]="$value"
done <<EOF
tbdEPgr 1.29
tbdEPstar -0.83
tbdABS 1.00
tbdcPC 6.022140857e23
tbdcQ 6.022140857e23
tbdEQ -0.45
tbdIlamp 1.0000
tbdGrelax 54392 
EOF


# Process each line of cat_data.txt, which contains the parameters we are studying:
tail -n +1 data.txt | while read line; do
    # Copy the template file
    cp init.cps "$fname"

    # Extract parameters from the line and replace them in the file
    set -- $line  # Set positional parameters ($1, $2, etc.) based on the read line
    sed -i "s/$1/$2/g" "$fname"
    sed -i "s/$3/$4/g" "$fname"

    # now we use the associative array created; only those parameters are replaced which
    # have not yet been replaced by using cat_data.txt above 
    for name in "${!input_names_values[@]}"; do
        sed -i "s/$name/${input_names_values[$name]}/g" "$fname"
    done
    # Run the COPASI simulation
    /opt/COPASI/4.44.295/bin/CopasiSE "$fname"

    # Append the last line of the results to results.txt
    tail -1 time_course_results.txt >> results.txt
done

