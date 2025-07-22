/* --- create / select schema --- */
CREATE SCHEMA IF NOT EXISTS optics
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE optics;

/* --- reference data (address book) --- */
CREATE TABLE contact_information (
  idcontact_information INT AUTO_INCREMENT PRIMARY KEY,
  phone           VARCHAR(20)  NOT NULL,
  street          VARCHAR(45)  NOT NULL,
  street_number   INT          NOT NULL,
  floor           INT          NOT NULL,
  city            VARCHAR(45)  NOT NULL,
  zip_code        VARCHAR(10)  NOT NULL,
  province_state  VARCHAR(45)  NOT NULL
) ENGINE = InnoDB;

/* --- customers --- */
CREATE TABLE customer (
  idcustomer       INT AUTO_INCREMENT PRIMARY KEY,
  name             VARCHAR(45)  NOT NULL,
  email_address    VARCHAR(100) NOT NULL,
  recommendation_by VARCHAR(45),
  registration_date DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  contact_information_idcontact_information INT NOT NULL,
  UNIQUE KEY uq_email (email_address),
  CONSTRAINT fk_customer_contact
    FOREIGN KEY (contact_information_idcontact_information)
    REFERENCES contact_information(idcontact_information)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

/* --- employees --- */
CREATE TABLE employee (
  idemployee INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(45) NOT NULL,
  lastname   VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

/* --- suppliers --- */
CREATE TABLE supplier (
  idsupplier  INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(45) NOT NULL,
  fax         VARCHAR(30),
  NIF         CHAR(9)     NOT NULL,
  contact_information_idcontact_information INT NOT NULL,
  UNIQUE KEY uq_nif (NIF),
  CONSTRAINT fk_supplier_contact
    FOREIGN KEY (contact_information_idcontact_information)
    REFERENCES contact_information(idcontact_information)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

/* --- brands --- */
CREATE TABLE brand (
  idbrand           INT AUTO_INCREMENT PRIMARY KEY,
  name              VARCHAR(45) NOT NULL,
  supplier_idsupplier INT       NOT NULL,
  CONSTRAINT fk_brand_supplier
    FOREIGN KEY (supplier_idsupplier)
    REFERENCES supplier(idsupplier)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

/* --- products --- */
CREATE TABLE glasses (
  idglasses          INT AUTO_INCREMENT PRIMARY KEY,
  brand_idbrand      INT          NOT NULL,
  graduation_left_eye  DECIMAL(4,2) NOT NULL,
  graduation_right_eye DECIMAL(4,2) NOT NULL,
  frame             ENUM('metallic','plastic','floating') NOT NULL,
  frame_color       VARCHAR(45) NOT NULL,
  glass_color       VARCHAR(45) NOT NULL,
  price             DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_glasses_brand
    FOREIGN KEY (brand_idbrand)
    REFERENCES brand(idbrand)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

/* --- sales header --- */
CREATE TABLE sale (
  idsale            INT AUTO_INCREMENT PRIMARY KEY,
  sale_date         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  customer_idcustomer INT  NOT NULL,
  employee_idemployee INT  NOT NULL,
  CONSTRAINT fk_sale_customer
    FOREIGN KEY (customer_idcustomer)
    REFERENCES customer(idcustomer)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_sale_employee
    FOREIGN KEY (employee_idemployee)
    REFERENCES employee(idemployee)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

/* --- sales lines (bridge) --- */
CREATE TABLE sales_glasses (
  idsale     INT NOT NULL,
  idglasses  INT NOT NULL,
  quantity   INT NOT NULL,
  PRIMARY KEY (idsale, idglasses),
  CONSTRAINT fk_salesglasses_sale
    FOREIGN KEY (idsale)
    REFERENCES sale(idsale)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_salesglasses_glasses
    FOREIGN KEY (idglasses)
    REFERENCES glasses(idglasses)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;