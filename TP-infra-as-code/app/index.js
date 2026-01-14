const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("WebSolutions Inc. - Application OK");
});

app.get("/health", (req, res) => {
  res.json({ status: "ok", uptime: process.uptime() });
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
