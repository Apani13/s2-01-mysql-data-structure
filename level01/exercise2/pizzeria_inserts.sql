/* =========  LOOK-UP TABLES  ========= */

/* Provinces */
INSERT INTO province (idprovince, name)
VALUES (10, 'Barcelona'),
       (20, 'Madrid');

/* Localities */
INSERT INTO locality (idlocality, name, idprovince)
VALUES (100, 'Barcelona', 10),
       (101, 'L’Hospitalet de Llobregat', 10),
       (200, 'Madrid', 20);

/* Addresses */
INSERT INTO address (idaddress, street, `number`, door, cp, idlocality)
VALUES (1000, 'Carrer Major',    '123', '1A',  '08001', 100),
       (1001, 'Carrer Laura',    '45',  '2B',  '08902', 101),
       (1002, 'Gran Vía',        '12',  NULL,  '28013', 200),
       (1003, 'Calle del Sol',   '55',  '1C',  '28014', 200);

/* Order types */
INSERT INTO order_type (idorder_type, name)
VALUES (1, 'Delivery'), (2, 'Pick-up');

/* Job positions */
INSERT INTO job_position (idjob_position, name)
VALUES (1, 'Cook'), (2, 'Rider');

/* Pizza categories */
INSERT INTO category (idcategory, name)
VALUES (1, 'Classic'), (2, 'Gourmet');

/* Product types */
INSERT INTO product_type (idproduct_type, name, description)
VALUES (1, 'Pizza',  'Oven-baked flatbread'),
       (2, 'Burger', 'Grilled sandwich'),
       (3, 'Drink',  'Beverage');

/* =========  CORE ENTITIES  ========= */

/* Shops */
INSERT INTO shop (idshop, name, idaddress)
VALUES (1, 'Pizzeria Central',       1000),
       (2, 'Pizzeria Madrid Centro', 1002);

/* Clients */
INSERT INTO client (idclient, name, surname, idaddress, phone)
VALUES (1, 'John', 'Smith',  1001, '600111222'),
       (2, 'Ana',  'Pérez',  1003, '600333444');

/* Employees */
INSERT INTO employee (idemployee, name, lastname, NIF, phone,
                      idjob_position, idshop)
VALUES (1, 'Carlos', 'Gómez',     '12345678A', '620111222', 1, 1),  -- cook BCN
       (2, 'Marta',  'Ruiz',      '12345678B', '620222333', 2, 1),  -- rider BCN
       (3, 'Luis',   'Hernández', '12345678C', '620333444', 1, 2),  -- cook MAD
       (4, 'Sara',   'López',     '12345678D', '620444555', 2, 2);  -- rider MAD

/* =========  PRODUCT CATALOGUE  ========= */

/* Products */
INSERT INTO product (idproduct, name, description, price,
                     idcategory_pizza, idproduct_type)
VALUES (1, 'Margherita', 'Tomato, mozzarella & basil',  8.50, 1, 1),
       (2, 'BBQ Burger', 'Beef, cheese, BBQ sauce',     6.70, NULL, 2),
       (3, 'Cola 330 ml', 'Soft drink can',             1.50, NULL, 3);

/* =========  ORDERS  ========= */

/* Client orders */
INSERT INTO client_order (idorder, date_time, idorder_type, idclient,
                          idemployee, delivery_at, total_price, idshop)
VALUES
  -- Delivery order: rider Marta delivers to John
  (1, '2025-07-10 19:30:00', 1, 1, 2, '2025-07-10 20:00:00', 16.70, 1),
  -- Pick-up order: Ana collects herself
  (2, '2025-07-11 12:15:00', 2, 2, NULL, NULL, 8.50, 2);

/* Order line items */
INSERT INTO order_product (idorder, idproduct, quantity)
VALUES
  (1, 1, 1),  -- Margherita
  (1, 2, 1),  -- BBQ Burger
  (1, 3, 1),  -- Cola
  (2, 1, 1);  -- Margherita (pick-up)
