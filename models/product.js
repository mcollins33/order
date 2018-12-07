module.exports = (sequelize, DataTypes) => {
    var Product = sequelize.define('Product', {
        product: DataTypes.STRING,
        inventory: DataTypes.INTEGER,
        price: DataTypes.DECIMAL(10, 2),
        createdAt: {
            type: DataTypes.DATE,
            defaultValue: DataTypes.NOW
        },
        updatedAt: {
            type: DataTypes.DATE,
            defaultValue: DataTypes.NOW
        }
        }, {
        classMethods: {
            associate: function(models) {
                // associations can be defined here
                Product.belongsTo(models.Order, {
                    foreignKey: {
                        allowNull: false
                    }
                });
            }
        }
    });
    return Product;
};