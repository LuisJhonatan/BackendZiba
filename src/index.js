import express from "express";

const app = express();
const port = 3000;

app.use(express.json());

app.get("/users", (req, res) => {
  const users = [
    { id: 1, name: "John Doe", email: "john@example.com" },
    { id: 2, name: "Jane Smith", email: "jane@example.com" },
    { id: 3, name: "Alice Johnson", email: "alice@example.com" },
  ];
  res.json(users);
});

app.listen(port);
