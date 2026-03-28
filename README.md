# OMR Sheet Evaluator (MATLAB)

## Overview

This project is a MATLAB-based Optical Mark Recognition (OMR) Sheet Evaluator. It processes scanned or photographed answer sheets, detects marked responses, and evaluates them against a provided solution key.

It is designed to handle different sets of OMR sheets such as 25, 30, and 50 questions. The system includes image preprocessing, alignment correction, and automatic result generation.

---

## Project Structure

```
├── 25_dataset/            
├── 30_dataset/            
├── 50_dataset/            

├── OMR_Sheet.jpg          
├── background2.jpg        

├── s1_*.jpg               
├── soln_*.jpg             

├── evaluate_single_omr.m  
├── evaluate_multiple_omr.m
├── get_roll.m             
├── get_soln.m             
├── get_code.m             
├── img_processed.m        
├── untitled.m             

├── OMR_Sheet_Evaluator.mlapp 
├── result.xlsx            
```

---

## Features

* Detection of marked bubbles from OMR sheets
* Image preprocessing including thresholding, alignment, and noise reduction
* Handling of tilted or slightly distorted images
* Extraction of roll number, exam code, and answers
* Comparison with solution key
* Export of results to Excel

---

## How to Run

### Using MATLAB App

1. Open MATLAB
2. Run the file:

   ```matlab
   OMR_Sheet_Evaluator.mlapp
   ```
3. Upload OMR sheet images
4. Select the dataset (25, 30, or 50 questions)
5. Run the evaluation

### Using Scripts

To evaluate a single sheet:

```matlab
evaluate_single_omr
```

To evaluate multiple sheets:

```matlab
evaluate_multiple_omr
```

---

## Input Requirements

* Clear image of the OMR sheet
* Proper lighting conditions
* Minimal shadows or noise
* Format similar to the provided template
* Supported formats include .jpg and .png

---

## Output

* Detected answers
* Extracted student information
* Calculated score
* Excel file (result.xlsx) containing evaluation results

---

## Notes

* Accuracy depends on image quality
* Proper alignment improves detection accuracy
* Extremely distorted images may not be processed correctly
* MATLAB Image Processing Toolbox is required

---

## Future Improvements

* Improved graphical user interface
* Support for more flexible OMR layouts
* Real-time processing using camera input
* Better error handling and robustness

---

## Author

Developed as part of an academic project on automated OMR evaluation using MATLAB.
Aurthors are 
Rahin Ibne Hasan
Al Maruf Ratul
Abirul Alam
Nanziba Islam

---

## License

This project is intended for educational use.
