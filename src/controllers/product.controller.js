import * as productModel from "../models/product.model.js";

// Obtener todos los productos
export const getAllProducts = async (req, res) => {
  try {
    const products = await productModel.getAllProducts();
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const getProductById = async (req, res) => {
  const { id } = req.params;

  try {
    const product = await productModel.getProductById(id);
    if (!product.length) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json(product[0]); // Asumiendo que `product` es un array con un solo elemento
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Agregar un nuevo producto
export const addProduct = async (req, res) => {
  const { id_category, name_product, price, stock, color, description, image } =
    req.body;

  const missingFields = [];
  if (!id_category) missingFields.push("id_category");
  if (!name_product) missingFields.push("name_product");
  if (price === undefined) missingFields.push("price"); // Asegúrate de verificar también el valor `undefined` para price
  if (stock === undefined) missingFields.push("stock"); // Lo mismo para stock
  if (!color) missingFields.push("color");
  if (!description) missingFields.push("description");

  if (missingFields.length > 0) {
    return res.status(400).json({
      error: `Faltan los siguientes campos requeridos: ${missingFields.join(
        ", "
      )}`,
    });
  }

  try {
    const newProduct = await productModel.addProduct({
      id_category,
      name_product,
      price,
      stock,
      color,
      description,
      image: image || null,
    });

    res
      .status(201)
      .json({ message: "Producto agregado con éxito", product: newProduct });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar un producto
export const updateProduct = async (req, res) => {
  const { id } = req.params;
  const { id_category, name_product, price, stock, color, description } =
    req.body;

  try {
    const updatedProduct = await productModel.updateProduct(id, {
      id_category,
      name_product,
      price,
      stock,
      color,
      description,
    });

    if (updatedProduct.error) {
      // Si el producto no existe
      return res.status(404).json({ error: updatedProduct.error });
    }

    // Si la actualización fue exitosa, devolver el producto actualizado
    res.json({
      message: "Producto actualizado con éxito",
      product: updatedProduct,
    });
  } catch (error) {
    // Si ocurre un error en la base de datos
    res.status(500).json({ error: error.message });
  }
};

// Eliminar un producto
export const deleteProduct = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await productModel.deleteProduct(id);

    if (result.error) {
      // Si el producto no existe
      return res.status(404).json({ error: result.error });
    }

    res.json({ message: "Producto eliminado con éxito" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
