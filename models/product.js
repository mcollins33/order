module.exports = (sequelize, DataTypes) => {
    var Product = sequelize.define('Product', {
        product:   {
            type: DataTypes.STRING,
            allowNull: false,
        },
        inventory: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        price: {
            type: DataTypes.DECIMAL(10, 2),
            allowNull: false,
        },
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