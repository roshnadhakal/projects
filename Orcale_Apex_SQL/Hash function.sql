create or replace FUNCTION hash_password(p_password IN VARCHAR2) RETURN VARCHAR2 IS
  v_hashed_password VARCHAR2(2000);
BEGIN
  -- Use DBMS_OBFUSCATION_TOOLKIT.MD5 to hash the password
  SELECT LOWER(RAWTOHEX(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => UTL_I18N.STRING_TO_RAW(p_password, 'AL32UTF8'))))
  INTO v_hashed_password
  FROM DUAL;
  
  RETURN v_hashed_password;
END;
