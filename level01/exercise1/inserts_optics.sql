INSERT INTO contact_information
  (phone, street, street_number, floor, city, zip_code, province_state)
VALUES
  -- customers
  ('+34 123 456 789', 'Calle Mayor',     10, 2, 'Madrid',    '28001', 'Madrid'),
  ('+34 987 654 321', 'Avenida Diagonal',500, 0, 'Barcelona','08001', 'Barcelona'),
  ('+34 555 123 456', 'Gran Vía',        45, 1, 'Valencia',  '46001', 'Valencia'),
  ('+34 666 789 123', 'Calle Sierpes',   20, 0, 'Sevilla',   '41001', 'Sevilla'),
  ('+34 777 456 789', 'Calle Uría',      30, 3, 'Oviedo',    '33001', 'Asturias'),
  -- suppliers
  ('+34 900 111 000', 'Parque Empresarial', 1, 0, 'Madrid',    '28050', 'Madrid'),
  ('+34 900 111 001', 'Carrer chinchin', 2, 0, 'Barcelona',    '28050', 'Barcelona'),
  ('+34 900 111 002', 'Avinguda vista', 3, 0, 'Tarragona',    '28050', 'Tarragona'),
  ('+34 900 111 003', 'carrero Sègol de mar', 4, 0, 'Girona',    '28050', 'Girona'),
  ('+34 900 111 004', 'rambla soga', 5, 0, 'Lleida',    '28050', 'Lleida');

INSERT INTO supplier
  (name, fax, NIF, contact_information_idcontact_information)
VALUES
  ('Luxottica Spain',  NULL, 'A0000000A', 6),
  ('Oakley Iberia',    NULL, 'A0000001B', 7),
  ('Prada Eyewear ES', NULL, 'A0000002C', 8),
  ('Gucci Vision ES',  NULL, 'A0000003D', 9),
  ('Armani Optics ES', NULL, 'A0000004E',10);

INSERT INTO brand (name, supplier_idsupplier) VALUES
  ('Ray-Ban', 1),
  ('Oakley',  2),
  ('Prada',   3),
  ('Gucci',   4),
  ('Armani',  5);

INSERT INTO customer
  (name, email_address, registration_date, contact_information_idcontact_information)
VALUES
  ('Juan Pérez',      'juan.perez@email.com',  '2023-01-15 10:00:00', 1),
  ('María García',    'maria.garcia@email.com','2023-02-20 11:30:00', 2),
  ('Carlos López',    'carlos.lopez@email.com','2023-03-10 09:15:00', 3),
  ('Ana Martínez',    'ana.martinez@email.com','2023-04-05 16:45:00', 4),
  ('Luisa Fernández', 'luisa.fernandez@email.com','2023-05-12 14:20:00', 5);

INSERT INTO employee (name, lastname) VALUES
  ('Pedro',  'Gómez'),
  ('Sofía',  'Ruiz'),
  ('Miguel', 'Hernández'),
  ('Elena',  'Díaz'),
  ('Javier', 'Moreno');

INSERT INTO glasses
  (brand_idbrand, graduation_left_eye, graduation_right_eye,
   frame, frame_color, glass_color, price)
VALUES
  (1, -1.50, -1.75, 'metallic', 'negro',     'transparente', 150.00),
  (2, -2.00, -2.00, 'plastic',  'azul',      'espejado',     200.00),
  (3, -0.75, -1.25, 'plastic',  'dorado',    'degradado',    350.00),
  (4,  0.00,  0.00, 'floating', 'plateado',  'polarizado',   400.00),
  (5, -3.00, -3.50, 'metallic', 'titanio',   'transparente', 250.00);


INSERT INTO sale
  (idsale, sale_date, customer_idcustomer, employee_idemployee)
VALUES
  (1, '2023-06-01 12:30:00', 1, 1),
  (2, '2023-06-02 15:45:00', 2, 2),
  (3, '2023-06-03 10:15:00', 3, 3),
  (4, '2023-06-04 17:30:00', 4, 4),
  (5, '2023-06-05 11:00:00', 5, 5);

INSERT INTO sales_glasses (idsale, idglasses, quantity) VALUES
  (1, 1, 1),
  (2, 4, 1),
  (3, 3, 1),
  (4, 2, 2),
  (5, 5, 1);

INSERT INTO recommendation (recommendation_by) VALUES
  (1), (2), (3), (4), (5);
