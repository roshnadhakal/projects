--creating sequence for auto-increment of id primary key

CREATE SEQUENCE seq_admin START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cart START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cartproduct START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_categories START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_collection_slot START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_customer START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_fav_product START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_featured_product START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_newsletter START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_orderdetail START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_our_brands START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_payment START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_products START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_shipping_address START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_shop START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_slider START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_testimony START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_trader START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_userreview START WITH 1 INCREMENT BY 1;

 --creating triggers for auto increment of id
 
 --admin_id trigger
CREATE OR REPLACE TRIGGER trg_admin_id
BEFORE INSERT ON "ADMIN"
FOR EACH ROW
BEGIN
    SELECT seq_admin.NEXTVAL INTO :new.ADMIN_ID FROM dual;
END;
/

--cart_id trigger
CREATE OR REPLACE TRIGGER trg_cart_id
BEFORE INSERT ON "CART"
FOR EACH ROW
BEGIN
    SELECT seq_cart.NEXTVAL INTO :new.CART_ID FROM dual;
END;
/

--cart_product_id trigger
CREATE OR REPLACE TRIGGER trg_cartproduct_id
BEFORE INSERT ON "CARTPRODUCT"
FOR EACH ROW
BEGIN
    SELECT seq_cartproduct.NEXTVAL INTO :new.CART_PRODUCT_ID FROM dual;
END;
/

--categories_id trigger
CREATE OR REPLACE TRIGGER trg_categories_id
BEFORE INSERT ON "CATEGORIES"
FOR EACH ROW
BEGIN
    SELECT seq_categories.NEXTVAL INTO :new.CATEGORY_ID FROM dual;
END;
/

--collection_slot_id trigger
CREATE OR REPLACE TRIGGER trg_collection_slot_id
BEFORE INSERT ON "COLLECTION_SLOT"
FOR EACH ROW
BEGIN
    SELECT seq_collection_slot.NEXTVAL INTO :new.SLOT_ID FROM dual;
END;
/

--customer_id trigger
CREATE OR REPLACE TRIGGER trg_customer_id
BEFORE INSERT ON "CUSTOMER"
FOR EACH ROW
BEGIN
    SELECT seq_customer.NEXTVAL INTO :new.CUSTOMER_ID FROM dual;
END;
/

--fav_product_id trigger
CREATE OR REPLACE TRIGGER trg_fav_product_id
BEFORE INSERT ON "FAV_PRODUCT"
FOR EACH ROW
BEGIN
    SELECT seq_fav_product.NEXTVAL INTO :new.FAV_ID FROM dual;
END;
/

--featured_product_id trigger
CREATE OR REPLACE TRIGGER trg_featured_product_id
BEFORE INSERT ON "FEATURED_PRODUCT"
FOR EACH ROW
BEGIN
    SELECT seq_featured_product.NEXTVAL INTO :new.FEATURED_ID FROM dual;
END;
/

--newsletter_id trigger
CREATE OR REPLACE TRIGGER trg_newsletter_id
BEFORE INSERT ON "NEWSLETTER"
FOR EACH ROW
BEGIN
    SELECT seq_newsletter.NEXTVAL INTO :new.NEWSLETTER_ID FROM dual;
END;
/

--order_detail_id trigger
CREATE OR REPLACE TRIGGER trg_orderdetail_id
BEFORE INSERT ON "ORDERDETAIL"
FOR EACH ROW
BEGIN
    SELECT seq_orderdetail.NEXTVAL INTO :new.ORDER_ID FROM dual;
END;
/

--our_brands_id trigger
CREATE OR REPLACE TRIGGER trg_our_brands_id
BEFORE INSERT ON "OUR_BRANDS"
FOR EACH ROW
BEGIN
    SELECT seq_our_brands.NEXTVAL INTO :new.BRAND_ID FROM dual;
END;
/

--payment_id trigger
CREATE OR REPLACE TRIGGER trg_payment_id
BEFORE INSERT ON "PAYMENT"
FOR EACH ROW
BEGIN
    SELECT seq_payment.NEXTVAL INTO :new.PAYMENT_ID FROM dual;
END;
/

--products_id trigger
CREATE OR REPLACE TRIGGER trg_products_id
BEFORE INSERT ON "PRODUCTS"
FOR EACH ROW
BEGIN
    SELECT seq_products.NEXTVAL INTO :new.ADD_PRODUCT_ID FROM dual;
END;
/

--shipping_address_id  trigger
CREATE OR REPLACE TRIGGER trg_shipping_address_id
BEFORE INSERT ON "SHIPPING_ADDRESS"
FOR EACH ROW
BEGIN
    SELECT seq_shipping_address.NEXTVAL INTO :new.ADDRESS_ID FROM dual;
END;
/

--shop_id trigger
CREATE OR REPLACE TRIGGER trg_shop_id
BEFORE INSERT ON "SHOP"
FOR EACH ROW
BEGIN
    SELECT seq_shop.NEXTVAL INTO :new.SHOP_ID FROM dual;
END;
/

--slider_id trigger
CREATE OR REPLACE TRIGGER trg_slider_id
BEFORE INSERT ON "SLIDER"
FOR EACH ROW
BEGIN
    SELECT seq_slider.NEXTVAL INTO :new.ID FROM dual;
END;
/

--testimony_id trigger
CREATE OR REPLACE TRIGGER trg_testimony_id
BEFORE INSERT ON "TESTIMONY"
FOR EACH ROW
BEGIN
    SELECT seq_testimony.NEXTVAL INTO :new.ID FROM dual;
END;
/

--trader_id trigger
CREATE OR REPLACE TRIGGER trg_trader_id
BEFORE INSERT ON "TRADER"
FOR EACH ROW
BEGIN
    SELECT seq_trader.NEXTVAL INTO :new.TRADER_ID FROM dual;
END;
/

--userreview_id trigger
CREATE OR REPLACE TRIGGER trg_userreview_id
BEFORE INSERT ON "USERREVIEW"
FOR EACH ROW
BEGIN
    SELECT seq_userreview.NEXTVAL INTO :new.REVIEW_ID FROM dual;
END;
/

--PAYMENT DATA INSERTION TABLE
CREATE OR REPLACE TRIGGER trg_after_order_insert
AFTER INSERT ON "ORDERDETAIL"
FOR EACH ROW
DECLARE
    v_first_name VARCHAR2(255);
    v_last_name VARCHAR2(255);
    v_email VARCHAR2(255);
    v_mobile_no VARCHAR2(20);
    v_address VARCHAR2(500);
BEGIN
    -- Fetch customer details
    SELECT FIRSTNAME, LASTNAME, EMAIL, PHONE_NUMBER, ADDRESS INTO v_first_name, v_last_name, v_email, v_mobile_no, v_address
    FROM "CUSTOMER"
    WHERE CUSTOMER_ID = :NEW.CUSTOMER_ID;

    -- Insert into PAYMENT table
    INSERT INTO "PAYMENT" (FIRST_NAME, LAST_NAME, EMAIL, MOBILE_NO, ADDRESS, STATUS, PAYMENT_DATE, CUSTOMER_ID)
    VALUES (v_first_name, v_last_name, v_email, v_mobile_no, v_address, 0, SYSTIMESTAMP, :NEW.CUSTOMER_ID);
END;
/

--HASH PASSWORD TRIGGER
create or replace TRIGGER hash_admin_password
BEFORE INSERT OR UPDATE ON ADMIN
FOR EACH ROW
DECLARE
BEGIN
  -- Check if the password is being updated
  IF :NEW.ADMIN_PASSWORD <> :OLD.ADMIN_PASSWORD OR :OLD.ADMIN_PASSWORD IS NULL THEN
    :NEW.ADMIN_PASSWORD := hash_password(:NEW.ADMIN_PASSWORD);
  END IF;
END;
