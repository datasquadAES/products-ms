const { Op } = require('sequelize');

class SequelizeProductRepository {
  constructor(ProductModel, CategoryModel) {
    this.Product = ProductModel;
    this.Category = CategoryModel;
  }

  async create(productData) {
    return await this.Product.create(productData);
  }

  async findById(productId) {
    return await this.Product.findByPk(productId, { include: [{ model: this.Category, as: 'category' }] });
  }

  async findAll(filters = {}) {
    const where = {};
    if (filters.store_id) where.store_id = filters.store_id;
    if (filters.category_id) where.category_id = filters.category_id;
    if (filters.name) where.name = { [Op.iLike]: `%${filters.name}%` };
    if (filters.available !== undefined) where.available = filters.available;
    if (filters.price) where.price = filters.price;
    if (filters.stock) where.stock = filters.stock;
    // Puedes agregar más filtros según tus atributos

    return await this.Product.findAll({
      where,
      include: [{ model: this.Category, as: 'category' }]
    });
  }

  async update(productId, updateData) {
    const product = await this.Product.findByPk(productId);
    if (!product) throw new Error('Producto no encontrado');
    await product.update(updateData);
    return product;
  }

  async delete(productId) {
    const product = await this.Product.findByPk(productId);
    if (!product) throw new Error('Producto no encontrado');
    await product.destroy();
    return { message: 'Producto eliminado' };
  }
}

module.exports = SequelizeProductRepository;