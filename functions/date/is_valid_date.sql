CREATE OR REPLACE
  FUNCTION IS_VALID_DATE(
      DT_STR VARCHAR2)
    RETURN NUMBER
  AS
    RETVAL              NUMBER;
    DT_YEAR             NUMBER;
    DT_MONTH            NUMBER;
    DT_LST_DAY_OF_MONTH NUMBER;
    DT_DAY              NUMBER;
  BEGIN
  
    /*
    The function validates if the date is correct or not.
    Pass a string or number representing date in format YYYYMMDD.
    The results will indicate whether the passed value is a valid date or not.
        1. First it validates if the passed value is of length 8 for the format YYYYMMDD
        2. Then it separates year, month and day part from the input and assign it to respective variable
        3. Then is validates if the year is between 1900 - 2100, month is between 1 - 12 and day is between 1 - 31
        4. Then it validates if the day is less than or equal to the last day for a given month. e.g  29 for FEB 1996 and 28 for FEB 1990
     1 = input date is valid
     0 = input data length is smaller than expected
    -1 = day value out of bounds (1,31)
    -2 = month value out of bounds (1,12)
    -3 = year value out of bounds (1900,2100)
    -4 = day is not in between (max,min) of the month
    */ 
    
    RETVAL := -9; /* setting return value to random variable*/
    
    IF(LENGTH(DT_STR)=8) THEN
      /* extracts YYYY, MM and DD characters from string and convers it into number */
      DT_YEAR  := TO_NUMBER(SUBSTR(DT_STR,1,4));
      DT_MONTH := TO_NUMBER(SUBSTR(DT_STR,5,2));
      DT_DAY   := TO_NUMBER(SUBSTR(DT_STR,7,2));
      /*checking if the date parts are within acceptable limit*/
      IF(((DT_YEAR           >1900) AND (DT_YEAR<2100)) AND ((DT_MONTH>=1) AND (DT_MONTH<=12)) AND ((DT_DAY>=1) AND (DT_DAY<=31))) THEN
        DT_LST_DAY_OF_MONTH := TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(DT_YEAR||DT_MONTH,'YYYYMM')),'DD'));
        IF DT_DAY           <= DT_LST_DAY_OF_MONTH THEN
          RETVAL            := 1;
        ELSE
          RETVAL := -4;
        END IF;
      ELSE
        IF NOT ((DT_DAY     >=1) AND (DT_DAY<=31)) THEN
          RETVAL        := -1;
        ELSIF NOT ((DT_MONTH>=1) AND (DT_MONTH<=12)) THEN
          RETVAL        := -2;
        ELSIF NOT ((DT_YEAR  >1900) AND (DT_YEAR<2100)) THEN
          RETVAL        := -3;
        END IF;
      END IF;
    ELSE
      RETVAL := 0;
    END IF;
    RETURN RETVAL;
  END; 
