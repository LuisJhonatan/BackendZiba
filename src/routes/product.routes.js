import express from "express";
import {
  getAllProducts,
  getProductById,
  addProduct,
  updateProduct,
  deleteProduct,
} from "../controllers/product.controller.js";

const router = express.Router();

// Ruta para obtener todos los usuarios
router.get("/", getAllProducts);

// Ruta para obtener un usuario por ID
router.get("/:id", getProductById);

// Ruta para agregar un nuevo usuario
router.post("/", addProduct);

// Ruta para actualizar un usuario
router.put("/:id", updateProduct);

// Ruta para eliminar un usuario
router.delete("/:id", deleteProduct);

export default router;
