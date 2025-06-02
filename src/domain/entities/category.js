const { DataTypes } = require('sequelize');
const sequelize = require('../../infrastructure/database/db').sequelize;

const Category = sequelize.define('Category', {
  id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
  name: { type: DataTypes.STRING(50), allowNull: false },
  description: { type: DataTypes.TEXT }
}, {
  tableName: 'categories',
  timestamps: false
});

module.exports = Category;