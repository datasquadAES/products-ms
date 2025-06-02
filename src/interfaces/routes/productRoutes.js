const express = require('express');
const router = express.Router();
const ProductController = require('../../infrastructure/http/controllers/ProductController');
const ProductService = require('../../application/services/productService');
const SequelizeProductRepository = require('../../infrastructure/database/sequelize/ProductRepository');
const { Product, Category} = require('../../domain/entities/associations');
const {
  createProductValidator,
  updateProductValidator,
  getProductByIdValidator,
  deleteProductValidator,
  getProductsValidator,
  reserveStockValidator,
  releaseStockValidator,
  getAvailableStockValidator
} = require('../../infrastructure/http/middlewares/ProductValidators');
const validate = require('../../infrastructure/http/middlewares/validate');

// Dependencias
const productRepository = new SequelizeProductRepository(Product, Category);
const productService = new ProductService(productRepository);
const productController = new ProductController(productService);

/**
 * @swagger
 * tags:
 *   name: Products
 *   description: Gestión de productos
 */

/**
 * @swagger
 * /products:
 *   post:
 *     summary: Crear un producto
 *     tags: [Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               store_id:
 *                 type: integer
 *               category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *                 format: float
 *               stock:
 *                 type: integer
 *               available:
 *                 type: boolean
 *               image_url:
 *                 type: string
 *     responses:
 *       201:
 *         description: Producto creado exitosamente
 *       500:
 *         description: Error interno del servidor
 */
router.post('/products', createProductValidator, validate, productController.create.bind(productController));

/**
 * @swagger
 * /products:
 *   get:
 *     summary: Obtener todos los productos (con filtros)
 *     tags: [Products]
 *     parameters:
 *       - in: query
 *         name: store_id
 *         schema:
 *           type: integer
 *         required: false
 *       - in: query
 *         name: category_id
 *         schema:
 *           type: integer
 *         required: false
 *       - in: query
 *         name: name
 *         schema:
 *           type: string
 *         required: false
 *       - in: query
 *         name: available
 *         schema:
 *           type: boolean
 *         required: false
 *       - in: query
 *         name: price
 *         schema:
 *           type: number
 *         required: false
 *       - in: query
 *         name: stock
 *         schema:
 *           type: integer
 *         required: false
 *     responses:
 *       200:
 *         description: Lista de productos
 *       500:
 *         description: Error interno del servidor
 */
router.get('/products', getProductsValidator, validate, productController.getAll.bind(productController));

/**
 * @swagger
 * /products/{id}:
 *   get:
 *     summary: Obtener un producto por ID
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Producto encontrado
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.get('/products/:id', getProductByIdValidator, validate, productController.getById.bind(productController));

/**
 * @swagger
 * /products/{id}:
 *   put:
 *     summary: Actualizar un producto
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               store_id:
 *                 type: integer
 *               category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *                 format: float
 *               stock:
 *                 type: integer
 *               available:
 *                 type: boolean
 *               image_url:
 *                 type: string
 *     responses:
 *       200:
 *         description: Producto actualizado exitosamente
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.put('/products/:id', updateProductValidator, validate, productController.update.bind(productController));

/**
 * @swagger
 * /products/{id}:
 *   delete:
 *     summary: Eliminar un producto
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Producto eliminado exitosamente
 *       404:
 *         description: Producto no encontrado
 *       500:
 *         description: Error interno del servidor
 */
router.delete('/products/:id', deleteProductValidator, validate, productController.delete.bind(productController));

/**
 * @swagger
 * /products/{id}/reserve:
 *   post:
 *     summary: Reservar cantidad de producto
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               quantity:
 *                 type: integer
 *                 description: Cantidad a reservar
 *     responses:
 *       200:
 *         description: Stock reservado
 *       400:
 *         description: Error
 */
router.post('/products/:id/reserve', reserveStockValidator, validate, productController.reserveStock.bind(productController));

/**
 * @swagger
 * /products/{id}/release:
 *   post:
 *     summary: Liberar cantidad de producto (quitar reserva)
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               quantity:
 *                 type: integer
 *                 description: Cantidad a liberar
 *     responses:
 *       200:
 *         description: Stock liberado
 *       400:
 *         description: Error
 */
router.post('/products/:id/release', releaseStockValidator, validate, productController.releaseStock.bind(productController));

/**
 * @swagger
 * /products/{id}/available:
 *   get:
 *     summary: Consultar cantidad disponible de producto
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Cantidad disponible
 *       400:
 *         description: Error
 */
router.get('/products/:id/available', getAvailableStockValidator, validate, productController.getAvailableStock.bind(productController));

module.exports = router;