/* ----------  SCHEMA ---------- */
DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE pizzeria;

/* ----------  LOOK-UP TABLES ---------- */
CREATE TABLE province (
    idprovince      BIGINT UNSIGNED PRIMARY KEY,
    name            VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE locality (
    idlocality      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    idprovince      BIGINT UNSIGNED NOT NULL,
    KEY idx_locality_province (idprovince),
    CONSTRAINT fk_locality_province
        FOREIGN KEY (idprovince) REFERENCES province (idprovince)
) ENGINE = InnoDB;

CREATE TABLE address (
    idaddress       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    street          VARCHAR(50) NOT NULL,
    number          VARCHAR(45),
    door            VARCHAR(45),
    cp              CHAR(5)     NOT NULL,
    idlocality      BIGINT UNSIGNED,
    KEY idx_address_locality (idlocality),
    CONSTRAINT fk_address_locality
        FOREIGN KEY (idlocality) REFERENCES locality (idlocality)
) ENGINE = InnoDB;

CREATE TABLE order_type (
    idorder_type    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE job_position (
    idjob_position  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

/* ----------  CORE ENTITIES ---------- */
CREATE TABLE client (
    idclient        BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    surname         VARCHAR(50) NOT NULL,
    idaddress       BIGINT UNSIGNED NOT NULL,
    phone           VARCHAR(20) NOT NULL,
    UNIQUE KEY uq_client_phone (phone),
    KEY idx_client_address (idaddress),
    CONSTRAINT fk_client_address
        FOREIGN KEY (idaddress) REFERENCES address (idaddress)
) ENGINE = InnoDB;

CREATE TABLE shop (
    idshop          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    idaddress       BIGINT UNSIGNED NOT NULL,
    KEY idx_shop_address (idaddress),
    CONSTRAINT fk_shop_address
        FOREIGN KEY (idaddress) REFERENCES address (idaddress)
) ENGINE = InnoDB;

CREATE TABLE employee (
    idemployee      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(45) NOT NULL,
    lastname        VARCHAR(45) NOT NULL,
    NIF             VARCHAR(45) NOT NULL,
    phone           VARCHAR(20) NOT NULL,
    idjob_position  BIGINT UNSIGNED NOT NULL,
    idshop          BIGINT UNSIGNED NOT NULL,
    UNIQUE KEY uq_employee_nif   (NIF),
    UNIQUE KEY uq_employee_phone (phone),
    KEY idx_employee_job  (idjob_position),
    KEY idx_employee_shop (idshop),
    CONSTRAINT fk_employee_job
        FOREIGN KEY (idjob_position) REFERENCES job_position (idjob_position),
    CONSTRAINT fk_employee_shop
        FOREIGN KEY (idshop)        REFERENCES shop (idshop)
) ENGINE = InnoDB;

/* ----------  ORDERING ---------- */
CREATE TABLE client_order (
    idorder         BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date_time       DATETIME      NOT NULL,
    idorder_type    BIGINT UNSIGNED NOT NULL,
    idclient        BIGINT UNSIGNED NOT NULL,
    idemployee      BIGINT UNSIGNED NULL,
    delivery_at     DATETIME      NULL,
    total_price     DECIMAL(10,2) NOT NULL,
    idshop          BIGINT UNSIGNED NOT NULL,
    KEY idx_order_type  (idorder_type),
    KEY idx_order_client(idclient),
    KEY idx_order_employee (idemployee),
    KEY idx_order_shop     (idshop),
    CONSTRAINT fk_order_type     FOREIGN KEY (idorder_type) REFERENCES order_type (idorder_type),
    CONSTRAINT fk_order_client   FOREIGN KEY (idclient)     REFERENCES client     (idclient),
    CONSTRAINT fk_order_employee FOREIGN KEY (idemployee)   REFERENCES employee   (idemployee),
    CONSTRAINT fk_order_shop     FOREIGN KEY (idshop)       REFERENCES shop       (idshop)
    /* Optional business-rule check — uncomment if you use MySQL 8.0.16+:
    ,CONSTRAINT chk_rider_delivery CHECK (
        (idorder_type = 1 AND idemployee IS NOT NULL)  -- delivery
        OR
        (idorder_type = 2 AND idemployee IS NULL)      -- pick-up
    )
    */
) ENGINE = InnoDB;

/* ----------  PRODUCT CATALOG ---------- */
CREATE TABLE category (
    idcategory      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE product_type (
    idproduct_type  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    description     VARCHAR(50)
) ENGINE = InnoDB;

CREATE TABLE product (
    idproduct       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    description     VARCHAR(200),
    image           BLOB,
    price           DECIMAL(10,4) NOT NULL,
    idcategory_pizza BIGINT UNSIGNED,
    idproduct_type  BIGINT UNSIGNED NOT NULL,
    KEY idx_product_category (idcategory_pizza),
    KEY idx_product_type     (idproduct_type),
    CONSTRAINT fk_product_category
        FOREIGN KEY (idcategory_pizza) REFERENCES category      (idcategory),
    CONSTRAINT fk_product_type
        FOREIGN KEY (idproduct_type)   REFERENCES product_type  (idproduct_type)
) ENGINE = InnoDB;

/* ----------  ORDER LINE ITEMS ---------- */
CREATE TABLE order_product (
    idorder     BIGINT UNSIGNED NOT NULL,
    idproduct   BIGINT UNSIGNED NOT NULL,
    quantity    INT            NOT NULL,
    PRIMARY KEY (idorder, idproduct),
    KEY idx_op_product (idproduct),
    CONSTRAINT fk_op_order   FOREIGN KEY (idorder)   REFERENCES client_order (idorder),
    CONSTRAINT fk_op_product FOREIGN KEY (idproduct) REFERENCES product      (idproduct)
) ENGINE = InnoDB;
