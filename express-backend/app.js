import express from "express";

const app = express();

// Middleware to parse JSON bodies
app.use(express.json());
// Example route
app.get("/", (req, res) => {
  res.send("Hello, World!");
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});