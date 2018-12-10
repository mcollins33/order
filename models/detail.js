module.exports = (sequelize, DataTypes) => {
    var Order = sequelize.define('Order', {
        quantity: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        price: {
            type: DataTypes.DECIMAL(10, 2),
            allowNull: false,
        }
    }, {
        timestamps: false
    }, {
        classMethods: {
            associate: function(models) {
                // associations can be defined here
                Detail.belongsTo(models.Order, {
                        foreignKey: {
                            allowNull: false
                        }
                    })
                    .belongsTo(models.Product, {
                        foreignKey: {
                            allowNull: false
                        }
                    }).hasMany(models.Product)
            }
        }
    });
    return Order;
};