const express = require('express');
const bcrypt = require('bcrypt');
const sqlite3 = require('sqlite3').verbose();
const session = require('express-session');
const bodyParser = require('body-parser');

const app = express();
const db = new sqlite3.Database(':memory:');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true,
}));

// Create users table
db.serialize(() => {
    db.run("CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT, password TEXT)");
});

app.use(express.static('public')); // Serve static files from 'public' directory

// Register endpoint
app.post('/register', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    const saltRounds = 10;
    bcrypt.hash(password, saltRounds, (err, hash) => {
        if (err) throw err;
        db.run("INSERT INTO users (email, password) VALUES (?, ?)", [email, hash], (err) => {
            if (err) {
                res.status(500).send("Error registering new user.");
            } else {
                res.redirect('/login.html');
            }
        });
    });
});

// Login endpoint
app.post('/login', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    db.get("SELECT * FROM users WHERE email = ?", [email], (err, row) => {
        if (err) throw err;
        if (row) {
            bcrypt.compare(password, row.password, (err, result) => {
                if (result) {
                    req.session.userId = row.id;
                    res.redirect('/#perfil');
                } else {
                    res.status(401).send("Invalid credentials");
                }
            });
        } else {
            res.status(401).send("Invalid credentials");
        }
    });
});

// Profile endpoint
app.get('/profile', (req, res) => {
    if (!req.session.userId) {
        return res.status(403).send("You are not logged in.");
    }

    db.get("SELECT email FROM users WHERE id = ?", [req.session.userId], (err, row) => {
        if (err) throw err;
        if (row) {
            res.send(`<p>Email: ${row.email}</p><p>Contraseña: *********</p>`);
        } else {
            res.status(404).send("User not found");
        }
    });
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});
