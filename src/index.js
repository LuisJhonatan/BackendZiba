import express from "express";
import cors from "cors";
import productRoutes from "./routes/product.routes.js"
import authRoutes from "./routes/auth.routes.js";
import userRoutes from './routes/user.routes.js';

const app = express();
const port = 5000;

app.use(cors({
  origin: 'http://localhost:3000', // Permite solicitudes desde tu frontend
  credentials: true, // Permite el envío de cookies con solicitudes
}));

app.use(express.json());

app.use('/api/products', productRoutes);
app.use('/api/auth', authRoutes); 
app.use('/api/users', userRoutes);
// app.use('/api/users', userRoutes);
  
app.get('/', (req, res) => {
  res.send('Bienvenido a la API de E-commerce');
});

app.listen(port);
// 