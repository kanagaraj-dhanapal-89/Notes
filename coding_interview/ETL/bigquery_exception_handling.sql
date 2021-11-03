BEGIN
  DECLARE emp_1_count, emp_2_count INT64;

  BEGIN TRANSACTION;
  INSERT INTO emp_2
  SELECT *
  FROM emp_1
  WHERE salary is not null;
  COMMIT TRANSACTION;

  SET emp_1_count = (
    SELECT COUNT(1)
    FROM emp_1
  );

  SET emp_2_count = (
    SELECT COUNT(1)
    FROM emp_2
  );
  SELECT IF (emp_1_count == emp_2_count, FORMAT("inserted %d numer of records successfully", emp_2_count) , ERROR("Failed in insertion"))

EXCEPTION WHEN ERROR THEN
  SELECT @@error.message;
  ROLLBACK TRANSACTION;
END;

BEGIN
  DECLARE emp_3_count, emp_4_count INT64;

  BEGIN TRANSACTION;
  INSERT INTO emp_4
  SELECT *
  FROM emp_3
  WHERE salary is not null;
  COMMIT TRANSACTION;

  SET emp_3_count = (
    SELECT COUNT(1)
    FROM emp_3
  );

  SET emp_4_count = (
    SELECT COUNT(1)
    FROM emp_4
  );
  SELECT IF (emp_3_count == emp_4_count, FORMAT("inserted %d numer of records successfully", emp_4_count) , ERROR("Failed in insertion"))

EXCEPTION WHEN ERROR THEN
  SELECT @@error.message;
  ROLLBACK TRANSACTION;
END;
