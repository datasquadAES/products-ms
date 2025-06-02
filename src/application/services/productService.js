const logger = require('../../utils/Logger');

class ProductService {
  constructor(productRepository) {
    this.productRepository = productRepository;
  }

  async createProduct(data) {
    try {
      logger.info(`Creando producto: ${JSON.stringify(data)}`);
      const result = await this.productRepository.create(data);
      logger.info(`Producto creado con ID: ${result.id}`);
      return result;
    } catch (error) {
      logger.error(`Error al crear producto: ${error.message}`);
      throw error;
    }
  }

  async getProductById(id) {
    try {
      logger.info(`Buscando producto por ID: ${id}`);
      const product = await this.productRepository.findById(id);
      if (!product) {
        logger.warn(`Producto no encontrado con ID: ${id}`);
      }
      return product;
    } catch (error) {
      logger.error(`Error al buscar producto por ID: ${error.message}`);
      throw error;
    }
  }

  async getProducts(filters) {
    try {
      logger.info(`Obteniendo productos con filtros: ${JSON.stringify(filters)}`);
      const cleanFilters = {};
      if (filters.store_id) cleanFilters.store_id = Number(filters.store_id);
      if (filters.category_id) cleanFilters.category_id = Number(filters.category_id);
      if (filters.name) cleanFilters.name = filters.name;
      if (filters.available !== undefined) cleanFilters.available = filters.available === 'true' || filters.available === true;
      if (filters.price) cleanFilters.price = Number(filters.price);
      if (filters.stock) cleanFilters.stock = Number(filters.stock);

      const products = await this.productRepository.findAll(cleanFilters);
      logger.info(`Productos encontrados: ${products.length}`);
      return products;
    } catch (error) {
      logger.error(`Error al obtener productos: ${error.message}`);
      throw error;
    }
  }

  async updateProduct(id, data) {
    try {
      logger.info(`Actualizando producto ID: ${id} con datos: ${JSON.stringify(data)}`);
      const result = await this.productRepository.update(id, data);
      logger.info(`Producto actualizado ID: ${id}`);
      return result;
    } catch (error) {
      logger.error(`Error al actualizar producto ID ${id}: ${error.message}`);
      throw error;
    }
  }

  async deleteProduct(id) {
    try {
      logger.info(`Eliminando producto ID: ${id}`);
      const result = await this.productRepository.delete(id);
      logger.info(`Producto eliminado ID: ${id}`);
      return result;
    } catch (error) {
      logger.error(`Error al eliminar producto ID ${id}: ${error.message}`);
      throw error;
    }
  }

  async reserveStock(productId, quantity) {
    try {
      logger.info(`Reservando ${quantity} unidades del producto ${productId}`);
      const product = await this.productRepository.findById(productId);
      if (!product) {
        logger.warn(`Producto ${productId} no encontrado para reserva`);
        throw new Error('Producto no encontrado');
      }
      if (product.stock < quantity) {
        logger.warn(`Stock insuficiente para producto ${productId}`);
        throw new Error('Stock insuficiente');
      }
      await this.productRepository.update(productId, { stock: product.stock - quantity });
      logger.info(`Reserva exitosa para producto ${productId}`);
      return { message: 'Stock reservado', product_id: productId, reserved: quantity };
    } catch (error) {
      logger.error(`Error al reservar stock para producto ${productId}: ${error.message}`);
      throw error;
    }
  }

  async releaseStock(productId, quantity) {
    try {
      logger.info(`Liberando ${quantity} unidades del producto ${productId}`);
      const product = await this.productRepository.findById(productId);
      if (!product) {
        logger.warn(`Producto ${productId} no encontrado para liberar stock`);
        throw new Error('Producto no encontrado');
      }
      await this.productRepository.update(productId, { stock: product.stock + quantity });
      logger.info(`Stock liberado para producto ${productId}`);
      return { message: 'Stock liberado', product_id: productId, released: quantity };
    } catch (error) {
      logger.error(`Error al liberar stock para producto ${productId}: ${error.message}`);
      throw error;
    }
  }

  async getAvailableStock(productId) {
    try {
      logger.info(`Consultando stock disponible para producto ${productId}`);
      const product = await this.productRepository.findById(productId);
      if (!product) {
        logger.warn(`Producto ${productId} no encontrado para consulta de stock`);
        throw new Error('Producto no encontrado');
      }
      logger.info(`Stock disponible para producto ${productId}: ${product.stock}`);
      return { product_id: productId, available: product.stock };
    } catch (error) {
      logger.error(`Error al consultar stock disponible para producto ${productId}: ${error.message}`);
      throw error;
    }
  }
}

module.exports = ProductService;