import { pool } from "../db.js";

export const createUser = async (userData) => {
  try {
    const { name, email, password } = userData;
    console.log(name, email, password);
    
    const [result] = await pool.query(
      'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
      [name, email, password]
    );
    console.log(result);
    
    return result.insertId;
  } catch (error) {
    console.error('Error creating user:', error.message);
    throw new Error('Error al crear el usuario');
  }
};

export const findUserByEmail = async (email) => {
  try {
    const [rows] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
    return rows[0];
  } catch (error) {
    console.error('Error finding user by email:', error.message);
    throw new Error('Error al buscar el usuario por email');
  }
};

export const findUserById = async (id) => {
  try {
    console.log("Hola 2");
    
    const [rows] = await pool.query('SELECT * FROM users WHERE id_user = ?', [id]);
    return rows[0];
  } catch (error) {
    console.error('Error finding user by ID:', error.message);
    throw new Error('Error al buscar el usuario por ID');
  }
};
