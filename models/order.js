module.exports = (sequelize, DataTypes) => {
    var Order = sequelize.define('Order', {
        product: DataTypes.STRING,
        quantity: DataTypes.INTEGER,
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
                Order.belongsTo(models.Customer, {
                    foreignKey: {
                        allowNull: false
                    }
                }).hasMany(models.Product)
            }
        }
    });
    return Order;
};