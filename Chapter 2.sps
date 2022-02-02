* Encoding: UTF-8.

CD 'C:\Users\gmeye\Dropbox\My Documents\UT\Classes\6930 Psychometrics\Datasets'.


GET DATA
  /TYPE=XLSX
  /FILE='MRMT Ch2.xlsx'
  /SHEET=name 'MRMT Ch2'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

FREQUENCIES VARIABLES=Gender Age Ethnicity Race Religion
  /STATISTICS=STDDEV MEAN SKEWNESS SESKEW
  /HISTOGRAM
  /ORDER=ANALYSIS.

STRING Gender2 (A8).
RECODE Gender (1 = 'Male') (2 = 'Female') INTO Gender2.
EXECUTE.

VALUE LABELS 
  Gender
  1 'Male' 2 'Female'
 /Race 
  1 'Amer Ind or AK Native' 2 'Asian' 3 'Black' 4 'Native Hawaiian or Pacific Islander' 5 'White' 6 'Bi-racial' 7 'Multi-racial'
 /Ethnicity 
  1 'Hispanic or Latino' 2 'Not Hispanic or Latino'
 /Religion 
  1 'Comitted Theist' 2 'Lukewarm Theist' 3 'Diest' 4 'Panthiest' 5 'Agnostic' 6 'Spiritual Atheist' 7 'Not Spiritual Athiest' 8 'Other'
 /MRS_1 TO SWL_5 
  1 'Strongly Disagree' 2 'Somewhat Disagree' 3 'Neither Agree nor Disagree' 4 'Somewhat Agree' 5 'Strongly Agree'.


SAVE OUTFILE='MRMT Ch3.sav'
  /COMPRESSED.
