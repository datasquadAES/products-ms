const { Sequelize } = require('sequelize');
require('dotenv').config();

// Configuración de la conexión a PostgreSQL
const sequelize = new Sequelize({
  dialect: 'postgres',
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  host: process.env.DATABASE_HOST,
  port: process.env.DATABASE_PORT,
  database: process.env.DATABASE_NAME,
  dialectOptions: {
    ssl: {
      require: true,
      rejectUnauthorized: false, // Necesario para conexiones SSL en Heroku
    },
  },
  logging: false, // Desactiva los logs de Sequelize (opcional)
});

/**
 * Función para probar la conexión a la base de datos PostgreSQL
 */
async function probarConexion() {
  try {
    await sequelize.authenticate();
    console.log('Conexión a la base de datos PostgreSQL ha sido establecida exitosamente.');
  } catch (error) {
    console.error(`No se puede conectar a la base de datos PostgreSQL ${process.env.DATABASE_NAME}:`, error);
    throw error;
  }
}

module.exports = { sequelize, probarConexion };
