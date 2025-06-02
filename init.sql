-- Tabla de categorías de productos (opcional pero recomendado)
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    store_id INT NOT NULL, -- Relación lógica, no FK
    category_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0, -- <--- Valor de existencias
    available BOOLEAN DEFAULT TRUE,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tabla de imágenes adicionales para productos (opcional)
CREATE TABLE IF NOT EXISTS product_images (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    image_url TEXT NOT NULL,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Ejemplo de datos de prueba para categorías y productos

-- Categorías
INSERT INTO categories (name, description) VALUES
('Pizzas', 'Variedad de pizzas'),
('Bebidas', 'Bebidas frías y calientes'),
('Sushi', 'Rollos y combos de sushi'),
('Hamburguesas', 'Hamburguesas y acompañamientos'),
('Postres', 'Dulces y postres'),
('Ensaladas', 'Ensaladas frescas');

-- Productos para 6 tiendas (store_id: 1 a 6)
-- Tienda 1: Pizzería Italia
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(1, 1, 'Pizza Margarita', 'Pizza con salsa de tomate, mozzarella y albahaca', 25000, 10, TRUE, 'https://ejemplo.com/pizza-margarita.jpg'),
(1, 1, 'Pizza Pepperoni', 'Pizza con pepperoni y queso mozzarella', 27000, 15, TRUE, 'https://ejemplo.com/pizza-pepperoni.jpg'),
(1, 1, 'Pizza Hawaiana', 'Pizza con jamón y piña', 26000, 12, TRUE, 'https://ejemplo.com/pizza-hawaiana.jpg'),
(1, 1, 'Pizza Vegetariana', 'Pizza con vegetales frescos', 25500, 8, TRUE, 'https://ejemplo.com/pizza-vegetariana.jpg'),
(1, 2, 'Gaseosa 350ml', 'Bebida gaseosa', 4000, 50, TRUE, 'https://ejemplo.com/gaseosa.jpg'),
(1, 2, 'Agua sin gas', 'Botella de agua 500ml', 3000, 40, TRUE, 'https://ejemplo.com/agua.jpg'),
(1, 5, 'Tiramisú', 'Postre italiano clásico', 9000, 10, TRUE, 'https://ejemplo.com/tiramisu.jpg'),
(1, 5, 'Cannoli', 'Dulce relleno de ricotta', 8500, 7, TRUE, 'https://ejemplo.com/cannoli.jpg'),
(1, 6, 'Ensalada Caprese', 'Ensalada de tomate, mozzarella y albahaca', 12000, 9, TRUE, 'https://ejemplo.com/caprese.jpg'),
(1, 2, 'Jugo de naranja', 'Jugo natural', 6000, 20, TRUE, 'https://ejemplo.com/jugo-naranja.jpg'),
(1, 1, 'Pizza Cuatro Quesos', 'Pizza con mezcla de quesos', 28000, 10, TRUE, 'https://ejemplo.com/pizza-4quesos.jpg'),
(1, 1, 'Pizza BBQ', 'Pizza con pollo y salsa BBQ', 29000, 8, TRUE, 'https://ejemplo.com/pizza-bbq.jpg'),
(1, 1, 'Pizza Mexicana', 'Pizza con jalapeños y carne', 29500, 7, TRUE, 'https://ejemplo.com/pizza-mexicana.jpg'),
(1, 5, 'Helado artesanal', 'Helado de varios sabores', 7000, 20, TRUE, 'https://ejemplo.com/helado.jpg'),
(1, 6, 'Ensalada César', 'Ensalada con pollo y aderezo César', 13000, 10, TRUE, 'https://ejemplo.com/cesar.jpg'),
(1, 2, 'Cerveza', 'Cerveza nacional', 7000, 25, TRUE, 'https://ejemplo.com/cerveza.jpg'),
(1, 2, 'Vino tinto', 'Copa de vino', 12000, 15, TRUE, 'https://ejemplo.com/vino.jpg'),
(1, 5, 'Brownie', 'Brownie de chocolate', 6000, 12, TRUE, 'https://ejemplo.com/brownie.jpg'),
(1, 5, 'Cheesecake', 'Tarta de queso', 8500, 10, TRUE, 'https://ejemplo.com/cheesecake.jpg'),
(1, 6, 'Ensalada mixta', 'Ensalada de vegetales', 11000, 8, TRUE, 'https://ejemplo.com/mixta.jpg');

-- Tienda 2: Sushi Express
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(2, 3, 'Sushi Roll Clásico', 'Rollo de sushi con salmón y aguacate', 32000, 20, TRUE, 'https://ejemplo.com/sushi-roll.jpg'),
(2, 3, 'California Roll', 'Rollo con cangrejo y aguacate', 30000, 18, TRUE, 'https://ejemplo.com/california-roll.jpg'),
(2, 3, 'Tempura Roll', 'Rollo de camarón tempura', 34000, 15, TRUE, 'https://ejemplo.com/tempura-roll.jpg'),
(2, 3, 'Philadelphia Roll', 'Rollo con queso crema y salmón', 33000, 16, TRUE, 'https://ejemplo.com/philadelphia-roll.jpg'),
(2, 3, 'Vegetarian Roll', 'Rollo de vegetales', 29000, 12, TRUE, 'https://ejemplo.com/vegetarian-roll.jpg'),
(2, 2, 'Té verde', 'Té verde frío', 5000, 30, TRUE, 'https://ejemplo.com/te-verde.jpg'),
(2, 2, 'Sake', 'Bebida japonesa', 15000, 10, TRUE, 'https://ejemplo.com/sake.jpg'),
(2, 5, 'Mochi', 'Postre japonés de arroz', 9000, 10, TRUE, 'https://ejemplo.com/mochi.jpg'),
(2, 5, 'Helado de té verde', 'Helado japonés', 9500, 8, TRUE, 'https://ejemplo.com/helado-te-verde.jpg'),
(2, 6, 'Ensalada de algas', 'Ensalada japonesa', 12000, 10, TRUE, 'https://ejemplo.com/algas.jpg'),
(2, 3, 'Dragon Roll', 'Rollo con anguila y aguacate', 35000, 7, TRUE, 'https://ejemplo.com/dragon-roll.jpg'),
(2, 3, 'Rainbow Roll', 'Rollo con variedad de pescados', 36000, 6, TRUE, 'https://ejemplo.com/rainbow-roll.jpg'),
(2, 3, 'Spicy Tuna Roll', 'Rollo picante de atún', 34000, 8, TRUE, 'https://ejemplo.com/spicy-tuna.jpg'),
(2, 3, 'Ebi Roll', 'Rollo de camarón', 32000, 9, TRUE, 'https://ejemplo.com/ebi-roll.jpg'),
(2, 3, 'Nigiri Salmón', 'Bola de arroz con salmón', 28000, 10, TRUE, 'https://ejemplo.com/nigiri-salmon.jpg'),
(2, 3, 'Nigiri Atún', 'Bola de arroz con atún', 28500, 10, TRUE, 'https://ejemplo.com/nigiri-atun.jpg'),
(2, 3, 'Sashimi Salmón', 'Láminas de salmón fresco', 35000, 8, TRUE, 'https://ejemplo.com/sashimi-salmon.jpg'),
(2, 3, 'Sashimi Atún', 'Láminas de atún fresco', 35500, 7, TRUE, 'https://ejemplo.com/sashimi-atun.jpg'),
(2, 2, 'Agua mineral', 'Botella de agua', 4000, 20, TRUE, 'https://ejemplo.com/agua-mineral.jpg'),
(2, 5, 'Dorayaki', 'Pastel japonés', 8000, 12, TRUE, 'https://ejemplo.com/dorayaki.jpg');

-- Tienda 3: Burger House
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(3, 4, 'Hamburguesa Clásica', 'Carne, queso, lechuga y tomate', 18000, 20, TRUE, 'https://ejemplo.com/hamburguesa-clasica.jpg'),
(3, 4, 'Hamburguesa BBQ', 'Carne, queso, cebolla y salsa BBQ', 20000, 18, TRUE, 'https://ejemplo.com/hamburguesa-bbq.jpg'),
(3, 4, 'Hamburguesa Doble', 'Doble carne y doble queso', 22000, 15, TRUE, 'https://ejemplo.com/hamburguesa-doble.jpg'),
(3, 4, 'Hamburguesa Pollo', 'Pechuga de pollo empanizada', 19000, 12, TRUE, 'https://ejemplo.com/hamburguesa-pollo.jpg'),
(3, 4, 'Hamburguesa Vegetariana', 'Hamburguesa de vegetales', 17000, 10, TRUE, 'https://ejemplo.com/hamburguesa-veg.jpg'),
(3, 2, 'Gaseosa 400ml', 'Bebida gaseosa', 4500, 40, TRUE, 'https://ejemplo.com/gaseosa400.jpg'),
(3, 2, 'Malteada de chocolate', 'Malteada con helado', 9000, 15, TRUE, 'https://ejemplo.com/malteada-choco.jpg'),
(3, 5, 'Brownie', 'Brownie de chocolate', 6000, 20, TRUE, 'https://ejemplo.com/brownie-burger.jpg'),
(3, 5, 'Helado', 'Helado de vainilla', 7000, 18, TRUE, 'https://ejemplo.com/helado-burger.jpg'),
(3, 6, 'Ensalada fresca', 'Ensalada de vegetales', 11000, 10, TRUE, 'https://ejemplo.com/ensalada-burger.jpg'),
(3, 4, 'Hamburguesa con huevo', 'Carne, huevo y queso', 21000, 8, TRUE, 'https://ejemplo.com/hamburguesa-huevo.jpg'),
(3, 4, 'Hamburguesa con tocineta', 'Carne, tocineta y queso', 21500, 9, TRUE, 'https://ejemplo.com/hamburguesa-tocineta.jpg'),
(3, 4, 'Hamburguesa especial', 'Carne, queso azul y cebolla caramelizada', 23000, 7, TRUE, 'https://ejemplo.com/hamburguesa-especial.jpg'),
(3, 5, 'Cheesecake', 'Tarta de queso', 8500, 10, TRUE, 'https://ejemplo.com/cheesecake-burger.jpg'),
(3, 2, 'Jugo de mango', 'Jugo natural', 6000, 20, TRUE, 'https://ejemplo.com/jugo-mango.jpg'),
(3, 2, 'Cerveza', 'Cerveza nacional', 7000, 25, TRUE, 'https://ejemplo.com/cerveza-burger.jpg'),
(3, 5, 'Galleta', 'Galleta de chocolate', 4000, 30, TRUE, 'https://ejemplo.com/galleta.jpg'),
(3, 6, 'Ensalada César', 'Ensalada con pollo', 13000, 10, TRUE, 'https://ejemplo.com/cesar-burger.jpg'),
(3, 2, 'Agua', 'Botella de agua', 3000, 40, TRUE, 'https://ejemplo.com/agua-burger.jpg'),
(3, 5, 'Pie de manzana', 'Postre de manzana', 9000, 8, TRUE, 'https://ejemplo.com/pie-manzana.jpg');

-- Tienda 4: Healthy Salads
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(4, 6, 'Ensalada César', 'Ensalada con pollo y aderezo César', 13000, 15, TRUE, 'https://ejemplo.com/cesar-healthy.jpg'),
(4, 6, 'Ensalada Griega', 'Ensalada con queso feta y aceitunas', 14000, 12, TRUE, 'https://ejemplo.com/griega.jpg'),
(4, 6, 'Ensalada de Quinoa', 'Ensalada con quinoa y vegetales', 15000, 10, TRUE, 'https://ejemplo.com/quinoa.jpg'),
(4, 6, 'Ensalada de atún', 'Ensalada con atún y vegetales', 13500, 11, TRUE, 'https://ejemplo.com/atun.jpg'),
(4, 6, 'Ensalada de pollo', 'Ensalada con pollo a la plancha', 14500, 13, TRUE, 'https://ejemplo.com/pollo.jpg'),
(4, 6, 'Ensalada mixta', 'Ensalada de vegetales frescos', 12000, 14, TRUE, 'https://ejemplo.com/mixta-healthy.jpg'),
(4, 6, 'Ensalada de frutas', 'Ensalada de frutas frescas', 11000, 10, TRUE, 'https://ejemplo.com/frutas.jpg'),
(4, 6, 'Wrap de pollo', 'Wrap con pollo y vegetales', 12500, 10, TRUE, 'https://ejemplo.com/wrap-pollo.jpg'),
(4, 6, 'Wrap vegetariano', 'Wrap con vegetales', 12000, 8, TRUE, 'https://ejemplo.com/wrap-veg.jpg'),
(4, 6, 'Bowl de salmón', 'Bowl con salmón y arroz', 16000, 7, TRUE, 'https://ejemplo.com/bowl-salmon.jpg'),
(4, 2, 'Jugo verde', 'Jugo detox', 7000, 20, TRUE, 'https://ejemplo.com/jugo-verde.jpg'),
(4, 2, 'Agua de coco', 'Bebida natural', 8000, 15, TRUE, 'https://ejemplo.com/agua-coco.jpg'),
(4, 5, 'Yogur con frutas', 'Yogur natural con frutas', 9000, 12, TRUE, 'https://ejemplo.com/yogur.jpg'),
(4, 5, 'Barra de cereal', 'Barra energética', 5000, 20, TRUE, 'https://ejemplo.com/barra-cereal.jpg'),
(4, 5, 'Muffin integral', 'Muffin saludable', 6000, 10, TRUE, 'https://ejemplo.com/muffin.jpg'),
(4, 2, 'Té frío', 'Té frío sin azúcar', 6000, 18, TRUE, 'https://ejemplo.com/te-frio.jpg'),
(4, 2, 'Smoothie de mango', 'Bebida de mango', 9000, 10, TRUE, 'https://ejemplo.com/smoothie-mango.jpg'),
(4, 2, 'Smoothie de frutos rojos', 'Bebida de frutos rojos', 9500, 8, TRUE, 'https://ejemplo.com/smoothie-rojos.jpg'),
(4, 5, 'Galleta integral', 'Galleta saludable', 4000, 15, TRUE, 'https://ejemplo.com/galleta-integral.jpg'),
(4, 5, 'Brownie vegano', 'Brownie sin ingredientes animales', 7000, 10, TRUE, 'https://ejemplo.com/brownie-vegano.jpg');

-- Tienda 5: Postres y Café
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(5, 5, 'Cheesecake', 'Tarta de queso', 8500, 20, TRUE, 'https://ejemplo.com/cheesecake-cafe.jpg'),
(5, 5, 'Brownie', 'Brownie de chocolate', 6000, 25, TRUE, 'https://ejemplo.com/brownie-cafe.jpg'),
(5, 5, 'Pie de limón', 'Tarta de limón', 9000, 15, TRUE, 'https://ejemplo.com/pie-limon.jpg'),
(5, 5, 'Tiramisú', 'Postre italiano', 9500, 12, TRUE, 'https://ejemplo.com/tiramisu-cafe.jpg'),
(5, 5, 'Muffin de arándanos', 'Muffin con arándanos', 7000, 18, TRUE, 'https://ejemplo.com/muffin-arandanos.jpg'),
(5, 5, 'Galleta de avena', 'Galleta saludable', 4000, 30, TRUE, 'https://ejemplo.com/galleta-avena.jpg'),
(5, 5, 'Helado', 'Helado artesanal', 7000, 20, TRUE, 'https://ejemplo.com/helado-cafe.jpg'),
(5, 2, 'Café americano', 'Café negro', 5000, 40, TRUE, 'https://ejemplo.com/cafe-americano.jpg'),
(5, 2, 'Café latte', 'Café con leche', 6000, 35, TRUE, 'https://ejemplo.com/cafe-latte.jpg'),
(5, 2, 'Capuchino', 'Café espumoso', 6500, 30, TRUE, 'https://ejemplo.com/capuchino.jpg'),
(5, 2, 'Té chai', 'Té con especias', 7000, 25, TRUE, 'https://ejemplo.com/te-chai.jpg'),
(5, 2, 'Chocolate caliente', 'Bebida de chocolate', 6000, 20, TRUE, 'https://ejemplo.com/chocolate-caliente.jpg'),
(5, 5, 'Torta de zanahoria', 'Torta con zanahoria y nueces', 8500, 15, TRUE, 'https://ejemplo.com/zanahoria.jpg'),
(5, 5, 'Torta de chocolate', 'Torta húmeda de chocolate', 9000, 12, TRUE, 'https://ejemplo.com/torta-chocolate.jpg'),
(5, 5, 'Croissant', 'Croissant de mantequilla', 5000, 18, TRUE, 'https://ejemplo.com/croissant.jpg'),
(5, 5, 'Palmerita', 'Hojaldre dulce', 4000, 20, TRUE, 'https://ejemplo.com/palmerita.jpg'),
(5, 5, 'Donut', 'Rosquilla glaseada', 5500, 22, TRUE, 'https://ejemplo.com/donut.jpg'),
(5, 5, 'Macaron', 'Galleta francesa', 7000, 15, TRUE, 'https://ejemplo.com/macaron.jpg'),
(5, 5, 'Eclair', 'Pastelito relleno', 7500, 10, TRUE, 'https://ejemplo.com/eclair.jpg'),
(5, 5, 'Pavlova', 'Postre de merengue', 9500, 8, TRUE, 'https://ejemplo.com/pavlova.jpg');

-- Tienda 6: Bebidas y Snacks
INSERT INTO products (store_id, category_id, name, description, price, stock, available, image_url) VALUES
(6, 2, 'Gaseosa 350ml', 'Bebida gaseosa', 4000, 60, TRUE, 'https://ejemplo.com/gaseosa-snack.jpg'),
(6, 2, 'Agua sin gas', 'Botella de agua 500ml', 3000, 55, TRUE, 'https://ejemplo.com/agua-snack.jpg'),
(6, 2, 'Jugo de naranja', 'Jugo natural', 6000, 40, TRUE, 'https://ejemplo.com/jugo-naranja-snack.jpg'),
(6, 2, 'Cerveza', 'Cerveza nacional', 7000, 35, TRUE, 'https://ejemplo.com/cerveza-snack.jpg'),
(6, 2, 'Té frío', 'Té frío sin azúcar', 6000, 30, TRUE, 'https://ejemplo.com/te-frio-snack.jpg'),
(6, 2, 'Smoothie de mango', 'Bebida de mango', 9000, 25, TRUE, 'https://ejemplo.com/smoothie-mango-snack.jpg'),
(6, 2, 'Smoothie de frutos rojos', 'Bebida de frutos rojos', 9500, 20, TRUE, 'https://ejemplo.com/smoothie-rojos-snack.jpg'),
(6, 5, 'Brownie', 'Brownie de chocolate', 6000, 30, TRUE, 'https://ejemplo.com/brownie-snack.jpg'),
(6, 5, 'Galleta', 'Galleta de chocolate', 4000, 40, TRUE, 'https://ejemplo.com/galleta-snack.jpg'),
(6, 5, 'Donut', 'Rosquilla glaseada', 5500, 35, TRUE, 'https://ejemplo.com/donut-snack.jpg'),
(6, 5, 'Helado', 'Helado artesanal', 7000, 25, TRUE, 'https://ejemplo.com/helado-snack.jpg'),
(6, 5, 'Croissant', 'Croissant de mantequilla', 5000, 20, TRUE, 'https://ejemplo.com/croissant-snack.jpg'),
(6, 5, 'Palmerita', 'Hojaldre dulce', 4000, 22, TRUE, 'https://ejemplo.com/palmerita-snack.jpg'),
(6, 5, 'Torta de zanahoria', 'Torta con zanahoria y nueces', 8500, 18, TRUE, 'https://ejemplo.com/zanahoria-snack.jpg'),
(6, 5, 'Torta de chocolate', 'Torta húmeda de chocolate', 9000, 15, TRUE, 'https://ejemplo.com/torta-chocolate-snack.jpg'),
(6, 5, 'Pie de manzana', 'Postre de manzana', 9000, 12, TRUE, 'https://ejemplo.com/pie-manzana-snack.jpg'),
(6, 5, 'Cheesecake', 'Tarta de queso', 8500, 20, TRUE, 'https://ejemplo.com/cheesecake-snack.jpg'),
(6, 5, 'Eclair', 'Pastelito relleno', 7500, 10, TRUE, 'https://ejemplo.com/eclair-snack.jpg'),
(6, 5, 'Macaron', 'Galleta francesa', 7000, 15, TRUE, 'https://ejemplo.com/macaron-snack.jpg'),
(6, 5, 'Pavlova', 'Postre de merengue', 9500, 8, TRUE, 'https://ejemplo.com/pavlova-snack.jpg');