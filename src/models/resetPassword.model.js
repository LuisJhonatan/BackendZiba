// passwordResetModel.js
export const createPasswordResetToken = async (userId, token) => {
  await pool.query('INSERT INTO password_resets (user_id, token) VALUES (?, ?)', [userId, token]);
};

export const findPasswordResetToken = async (token) => {
  const [rows] = await pool.query('SELECT * FROM password_resets WHERE token = ?', [token]);
  return rows[0];
};
