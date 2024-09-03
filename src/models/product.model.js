import { pool } from "../db.js";

// Obtener todos los productos
export const getAllProducts = async () => {
  try {
    const [rows] = await pool.query(`
      SELECT 
        p.id_product, 
        p.name_product, 
        p.price, 
        p.stock, 
        p.color, 
        p.description, 
        c.type AS category, 
        pi.image_url AS image
      FROM 
        product p
      LEFT JOIN 
        category c ON p.id_category = c.id_category
      LEFT JOIN 
        product_image pi ON p.id_product = pi.id_product
    `);
    return rows;
  } catch (error) {
    console.error("Error al obtener todos los productos:", error);
    throw new Error("Error en la base de datos");
  }
};


// Obtener un producto por ID
export const getProductById = async (id) => {
  try {
    const [rows] = await pool.query(
      `
        SELECT p.id_product, p.name_product, p.price, p.stock, p.color, p.description, p.image, c.type AS category 
        FROM product p
        LEFT JOIN category c ON p.id_category = c.id_category
        WHERE p.id_product = ?
      `,
      [id]
    );

    return rows;
  } catch (error) {
    console.error("Error al obtener el producto por ID:", error);
    throw new Error("Error en la base de datos");
  }
};

// Agregar un nuevo producto
export const addProduct = async (product) => {
  try {
    // Inserta el producto y obtiene el ID del producto insertado
    const [result] = await pool.query(
      `
          INSERT INTO product (id_category, name_product, price, stock, color, description, image) 
          VALUES (?, ?, ?, ?, ?, ?, COALESCE(?, DEFAULT(image)))
        `,
      [
        product.id_category,
        product.name_product,
        product.price,
        product.stock,
        product.color,
        product.description,
        product.image,
      ]
    );

    // Recupera el producto recién agregado usando el ID insertado
    const [rows] = await pool.query(
      `
          SELECT p.id_product, p.id_category, p.name_product, p.price, p.stock, p.color, p.description, p.image, c.type AS category
          FROM product p
          LEFT JOIN category c ON p.id_category = c.id_category
          WHERE p.id_product = ?
        `,
      [result.insertId]
    );

    // Devuelve el producto recién agregado
    return rows[0];
  } catch (error) {
    console.error("Error al agregar el producto:", error);
    throw new Error("Error en la base de datos al agregar el producto");
  }
};

// Actualizar un producto
export const updateProduct = async (id, product) => {
  try {
    const [result] = await pool.query(
      `
          UPDATE product 
          SET id_category = ?, name_product = ?, price = ?, stock = ?, color = ?, description = ?, image = ?, 
          WHERE id_product = ?
        `,
      [
        product.id_category,
        product.name_product,
        product.price,
        product.stock,
        product.color,
        product.description,
        product.image,
        id,
      ]
    );

    if (result.affectedRows === 0) {
      // No se encontró el producto con el ID especificado
      return { error: "Producto no encontrado" };
    }

    // Si la actualización fue exitosa, obtener el producto actualizado
    const [updatedProductRows] = await pool.query(
      `
          SELECT p.id_product, p.id_category, p.name_product, p.price, p.stock, p.color, p.description, p.image, c.type AS category
          FROM product p
          LEFT JOIN category c ON p.id_category = c.id_category
          WHERE p.id_product = ?
        `,
      [id]
    );

    // Devolver el producto actualizado
    return updatedProductRows[0];
  } catch (error) {
    console.error("Error al actualizar el producto:", error);
    throw new Error("Error en la base de datos al actualizar el producto");
  }
};

// Eliminar un producto
export const deleteProduct = async (id) => {
    try {
      const [result] = await pool.query("DELETE FROM product WHERE id_product = ?", [id]);
  
      if (result.affectedRows === 0) {
        // No se encontró el producto con el ID especificado
        return { error: "Producto no encontrado" };
      }
  
      return { success: true };
    } catch (error) {
      console.error("Error al eliminar el producto:", error);
      throw new Error("Error en la base de datos al eliminar el producto");
    }
  };
  