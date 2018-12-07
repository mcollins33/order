module.exports = (sequelize, DataTypes) => {
    var Order = sequelize.define('Order', {
        product:   {
            type: DataTypes.STRING,
            allowNull: false,
        },
        quantity: {
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
                Order.belongsTo(models.Customer, {
                    foreignKey: {
                        allowNull: false
                    }
                })
                .belongsTo(models.User, {
                    foreignKey: {
                        allowNull: false
                    }
                }).hasMany(models.Product)
            }
        }
    });
    return Order;
};