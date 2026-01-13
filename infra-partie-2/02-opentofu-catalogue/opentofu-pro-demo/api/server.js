const express = require("express");
const { Client } = require("pg");
const redis = require("redis");


const app = express();

// Connexion PostgreSQL
const pgClient = new Client({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});


pgClient.connect();

// Connexion Redis
const redisClient = redis.createClient({
    socket: { host: process.env.REDIS_HOST, port: 6379 }
});


redisClient.connect();

app.get("/health", async (req, res) => {
    try {
        await pgClient.query("SELECT 1");
        await redisClient.ping();
        res.json({ status: "OK", postgres: "UP", redis: "UP" });
    } catch (err) {
        res.status(500).json({ status: "ERROR", error: err.message });
    }
});

// Endpoint produits (démo)
app.get("/products", async (req, res) => {
    res.json([
        { id: 1, name: "PC" },
        { id: 2, name: "Souris" },
        { id: 3, name: "Clavier" }
    ]);
});


app.listen(3000, () => {
    console.log("API running on port 3000");
});