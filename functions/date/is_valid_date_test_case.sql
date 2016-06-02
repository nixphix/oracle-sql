Test Cases:

-- correct date
SELECT IS_VALID_DATE(19900228) FROM DUAL 

-- extra digits in input
SELECT IS_VALID_DATE(1990022800) FROM DUAL

-- day value out of bound 65
SELECT IS_VALID_DATE(19900265) FROM DUAL

-- month value out of bound 20
SELECT IS_VALID_DATE(19902006) FROM DUAL

-- year value out of bound 2990
SELECT IS_VALID_DATE(29900206) FROM DUAL

-- 1990 Feb month is not a leap year do 28 is max date
SELECT IS_VALID_DATE(19900229) FROM DUAL
