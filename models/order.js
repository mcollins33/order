module.exports = (sequelize, DataTypes) => {
    var Order = sequelize.define('Order', {
        shipping_street_1: {
            type: DataTypes.STRING,
            allowNull: false
        },
        shipping_street_2: {
            type: DataTypes.STRING,
            allowNull: true
        },
        shipping_city: {
            type: DataTypes.STRING,
            allowNull: false
        },
        shipping_state: {
            type: DataTypes.STRING,
            defaultValue: "AZ",
            allowNull: false
        },
        shipping_postal_code: {
            type: DataTypes.INTEGER(5).ZEROFILL,
            allowNull: false
        },
        shipping_country: {
            type: DataTypes.STRING,
            defaultValue: "United States",
            allowNull: false
        }
    }, {
        timestamps: false
    }, {
        classMethods: {
            associate: function(models) {
                // associations can be defined here
                Detail.belongsTo(models.Customer, {
                    foreignKey: {
                        allowNull: false
                    }
                }).hasMany(models.Detail)
            }
        }
    });

    return Order;
};