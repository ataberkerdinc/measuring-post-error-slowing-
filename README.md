# Post Error Slowing Analysis

This repository contains an R script for analyzing Post Error Slowing (PES) using a robust method (Dutilh et al. 2012). The analysis is centered on identifying specific sequences of responses and calculating reaction time differences around error responses. 

This approach avoids contamination by global performance trends by comparing post-error RTs to pre-error RTs that are also post-correct trials from the same trial sequence

## Overview of the Analysis
The main purpose of this script is to compute Post Error Slowing (PES) values using reaction time (RT) data. The PES is calculated as the difference between the reaction times immediately before and after an error response. This method is designed to ensure robustness by employing a systematic sequence detection and handling missing data appropriately.

## Key Features
1. **Sequence Detection:**
   - The script identifies rows of the data matching a specific response sequence: **`C C E C`** to avoid the effects of double errors (Hajcak &
Simons, 2008).

2. **Highlighting Identified Sequences:**
   - Rows matching the sequence are highlighted for verification.

3. **PES Calculation:**
   - The reaction time immediately before an error (`RTpre_error`) and the reaction time immediately after an error (`RTpost_error`) are calculated.
   - The PES is computed as: `PES = RTpost_error - RTpre_error`.

4. **Aggregation:**
   - PES values are summarized at the participant level to compute average PES scores.
   - This approach removes the influence of block, ear condition, and reward condition for simplicity.

5. **Visualization:**
   - The script generates a line plot showing the mean reaction times for conditions:
     - `E-1` (reaction time before the error)
     - `E` (reaction time at the error)
     - `E+1` (reaction time after the error)

## Input Data
The script expects an Excel file containing the following columns:
- `participant`: Identifier for participants.
- `response`: The sequence of responses (`C`, `E`, etc.).
- `RT`: Reaction time corresponding to each response.

## Output Files
1. `Participant_PES_results.csv`: Average PES values for each participant.
2. `raw_pes_data.csv`: Processed data including computed PES and highlighted sequences.

## Instructions
1. Update the script to match your file name and directory.
2. Run the script in an R environment.
3. Output files will be generated in the working directory.

## Visualization Details
Two visualizations are created:
1. **Reaction Time by Condition:**
   - Plots mean reaction times for `E-1`, `E`, and `E+1` conditions.

## Methodology
This analysis uses a robust approach to ensure accurate PES calculation:
- Specific response sequences (`C C E C`) are used to identify relevant error responses.
- Missing values are handled systematically to avoid biases.
- Aggregation at the participant level provides meaningful insights while simplifying comparisons.

## Dependencies
The script uses the following R packages:
- `readxl`
- `dplyr`
- `ggplot2`
- `tidyr`
- `writexl`

To install missing packages, run:
```R
install.packages(c("readxl", "dplyr", "ggplot2", "tidyr", "writexl"))
```

## License
This project is licensed under the MIT License. Feel free to use, modify, and distribute the code as needed.

## Contact
For any questions or issues, feel free to open an issue or reach out via email.

