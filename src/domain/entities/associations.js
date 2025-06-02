const Product = require('./product');
const Category = require('./category');

// Un producto pertenece a una categoría
Product.belongsTo(Category, {
  foreignKey: 'category_id',
  as: 'category'
});

// Una categoría tiene muchos productos
Category.hasMany(Product, {
  foreignKey: 'category_id',
  as: 'products'
});

module.exports = {
  Product,
  Category
};