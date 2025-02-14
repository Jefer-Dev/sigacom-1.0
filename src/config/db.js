const mysql = require('mysql2');
const dotenv = require('dotenv');

dotenv.config();

/**
 * Esta funcion me permite conectarme a mi base de datos api-caso que esta en el motor MYSQL
 * Los parametros que se usan son el host o la ip de la base de datos, el usuario, la contraseña y el nombre de la base de datos
 * @host {String} - Es el servidor de base datos, esta en la variable de entorno .env
 * @user {String} - El usuario se almacena en la variable de entorno .env
 * @password {String} - Es la contrasena del usuario de base de datos, se almacena en la variable de entorno .env
 * @database {String} - Es el nombre de la base de datos.
 */
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Se creo esta validación para saber si la conexión es exitosa o no en mi base de datos
pool.getConnection((err, connection) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err.message);
  } else {
    console.log('Conexión a la base de datos exitosa');
    connection.release();
  }
});

module.exports = pool.promise();
