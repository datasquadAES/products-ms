class ProductController {
  constructor(productService) {
    this.productService = productService;
  }

  async create(req, res) {
    try {
      const product = await this.productService.createProduct(req.body);
      res.status(201).json(product);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async getById(req, res) {
    try {
      const product = await this.productService.getProductById(req.params.id);
      if (!product) return res.status(404).json({ error: 'Producto no encontrado' });
      res.json(product);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async getAll(req, res) {
    try {
      // Filtra por cualquier atributo recibido en query
      const filters = { ...req.query };
      const products = await this.productService.getProducts(filters);
      res.json(products);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async update(req, res) {
    try {
      const product = await this.productService.updateProduct(req.params.id, req.body);
      res.json(product);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async delete(req, res) {
    try {
      const result = await this.productService.deleteProduct(req.params.id);
      res.json(result);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  // Reservar cantidad de producto
  async reserveStock(req, res) {
    try {
      const { id } = req.params;
      const { quantity } = req.body;
      const result = await this.productService.reserveStock(id, quantity);
      res.json(result);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  // Liberar cantidad de producto (quitar reserva)
  async releaseStock(req, res) {
    try {
      const { id } = req.params;
      const { quantity } = req.body;
      const result = await this.productService.releaseStock(id, quantity);
      res.json(result);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }

  // Consultar cantidad disponible
  async getAvailableStock(req, res) {
    try {
      const { id } = req.params;
      const result = await this.productService.getAvailableStock(id);
      res.json(result);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  }
}

module.exports = ProductController;