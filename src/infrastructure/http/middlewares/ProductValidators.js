const { body, param, query } = require('express-validator');

const createProductValidator = [
  body('store_id').isInt().withMessage('store_id debe ser un número entero'),
  body('category_id').optional().isInt().withMessage('category_id debe ser un número entero'),
  body('name').isString().notEmpty().withMessage('name es requerido'),
  body('description').optional().isString(),
  body('price').isDecimal().withMessage('price debe ser decimal'),
  body('stock').optional().isInt({ min: 0 }).withMessage('stock debe ser un número entero mayor o igual a 0'),
  body('available').optional().isBoolean(),
  body('image_url').optional().isString()
];

const updateProductValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero'),
  body('store_id').optional().isInt(),
  body('category_id').optional().isInt(),
  body('name').optional().isString(),
  body('description').optional().isString(),
  body('price').optional().isDecimal(),
  body('stock').optional().isInt({ min: 0 }),
  body('available').optional().isBoolean(),
  body('image_url').optional().isString()
];

const getProductByIdValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero')
];

const deleteProductValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero')
];

const getProductsValidator = [
  query('store_id').optional().isInt().withMessage('store_id debe ser un número entero'),
  query('category_id').optional().isInt().withMessage('category_id debe ser un número entero'),
  query('name').optional().isString(),
  query('available').optional().isBoolean(),
  query('price').optional().isDecimal().withMessage('price debe ser decimal'),
  query('stock').optional().isInt().withMessage('stock debe ser un número entero')
];

const reserveStockValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero'),
  body('quantity').isInt({ min: 1 }).withMessage('quantity debe ser un número entero mayor a 0')
];

const releaseStockValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero'),
  body('quantity').isInt({ min: 1 }).withMessage('quantity debe ser un número entero mayor a 0')
];

const getAvailableStockValidator = [
  param('id').isInt().withMessage('El id debe ser un número entero')
];

module.exports = {
  createProductValidator,
  updateProductValidator,
  getProductByIdValidator,
  deleteProductValidator,
  getProductsValidator,
  reserveStockValidator,
  releaseStockValidator,
  getAvailableStockValidator
};