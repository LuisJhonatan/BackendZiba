import jwt from "jsonwebtoken";

export const generateToken = (user) => {
  const payload = {
    id: user.id,
    email: user.email,
    name: user.name,
  };

  const secretKey = process.env.JWT_SECRET || "your_secret_key";

  const options = {
    expiresIn: "1d",
  };

  return jwt.sign(payload, secretKey, options);
};
