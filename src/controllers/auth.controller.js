import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { createUser, findUserByEmail, findUserById } from '../models/user.model.js';
import { createPasswordResetToken, findPasswordResetToken } from '../models/resetPassword.model.js';
import {generateToken} from '../utils/generateToken.js';

export const registerUser = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    console.log("hola");
    
    const userId = await createUser({ name, email, password: hashedPassword });
    console.log(userId);
    
    const user = await findUserById(userId);
    
    const token = generateToken(user);
    console.log(user, token);

    res.cookie('userToken', token, {
      httpOnly: false, // en true cuando se lanze a produccion
      secure: true, // La cookie solo se enviará a través de HTTPS en producción
      sameSite: 'strict', // Previene que la cookie sea enviada junto con solicitudes entre sitios cruzados
      maxAge: 24 * 60 * 60 * 1000, // 1 día en milisegundos
    });
    
    res.status(201).send("Usuario creado");
  } catch (error) {
    res.status(500).json({ message: 'Error registrando el usuario' });
  }
};

export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log("asdasd");
    
    const user = await findUserByEmail(email);
    if (!user) {
      return res.status(400).json({ message: 'Usuario no encontrado' });
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Contraseña incorrecta' });
    }
    const token = generateToken(user);

    res.cookie('userToken', token, {
      httpOnly: false, // en true cuando se lanze a produccion
      secure: true, // La cookie solo se enviará a través de HTTPS en producción
      sameSite: 'strict', // Previene que la cookie sea enviada junto con solicitudes entre sitios cruzados
      maxAge: 24 * 60 * 60 * 1000, // 1 día en milisegundos
    });

    res.status(200).send("asdasd")
  } catch (error) {
    res.status(500).json({ message: 'Error iniciando sesión' });
  }
};
