module.exports = (sequelize, DataTypes) => {
    var Product = sequelize.define('Product', {
        part_number: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        product: {
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
        }
    }, {
        timestamps: false
    }, {
        classMethods: {
            associate: function(models) {
                // associations can be defined here
                Product.belongsTo(models.Detail, {
                    foreignKey: {
                        allowNull: false
                    }
                }).hasMany(models.Detail);
            }
        }
    });
    return Product;
};