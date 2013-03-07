#!/usr/bin/env gawk -f
#FUNCTIONS
function printRecords(array, isLastArray) {
  if( array[0] != "" ) {
    arrayLength = asort(array);
    #arrayLength = length(array);
    for( j = 1; j < arrayLength + 1; j++ ) {
      #remove last comma and extra characters like spaces and tabs
      array[j] =  gensub(/^(.*),[:space:]*$/, "\\1", "g", array[j]);
      #add the comma unless isLastArray and isLastRecord
      if( !(j == arrayLength && isLastArray == 1) ){
        array[j] = array[j] ","
      }
      print array[j];
    }
    delete array;
  }
}

#MAIN
BEGIN {
  fieldRegex= "[ ]{2}`.*";
  primaryRegex= "[ ]{2}PRIMARY.*";
  uniqueRegex= "[ ]{2}UNIQUE.*";
  keyRegex = "[ ]{2}KEY.*";
  constraintRegex = "[ ]{2}CONSTRAINT.*";

  aFieldIndex = 0;
  aPrimaryIndex = 0;
  aUniqueIndex = 0;
  aKeyIndex = 0;
  aConstraintIndex = 0;

  aField[0] = "";
  aPrimary[0] = "";
  aUnique[0] = "";
  aKey[0] = "";
  aConstraint[0] = "";
}
{
  if( match($0, keyRegex) ) {
    aKey[aKeyIndex++] = $0;
  } else if( match($0, constraintRegex) ) {
    aConstraint[aConstraintIndex++] = $0;
  } else if( match($0, fieldRegex) ) {
    aField[aFieldIndex++] = $0;
  } else if( match($0, primaryRegex) ) {
    aPrimary[aPrimaryIndex++] = $0;
  } else if( match($0, uniqueRegex) ) {
    aUnique[aUniqueIndex++] = $0;
  } else {
    printRecords(aField, 0);
    printRecords(aPrimary, 0);
    printRecords(aUnique, 0);
    printRecords(aKey, 0);
    printRecords(aConstraint, 1);
    aKeyIndex = 0;
    aConstraintIndex = 0;
    aFieldIndex = 0;
    aPrimaryIndex = 0;
    aUniqueIndex = 0;
    print $0;
  }
}
END {
}
