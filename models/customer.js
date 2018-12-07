module.exports = (sequelize, DataTypes) => {
    var Customer = sequelize.define('Customer', {
        customer_name: {
            type: DataTypes.STRING,
            allowNull: false
        },
        contact_name: {
            type: DataTypes.STRING,
            allowNull: false
        },
        billing_street_1: {
            type: DataTypes.STRING,
            allowNull: false
        },
        billing_street_2: {
            type: DataTypes.STRING,
            allowNull: true
        },
        billing_city: {
            type: DataTypes.STRING,
            allowNull: false
        },
        billing_state: {
            type: DataTypes.STRING,
            defaultValue: "AZ",
            allowNull: false
        },
        billing_postal_code: {
            type: DataTypes.INTEGER(5).ZEROFILL,
            allowNull: false
        },
        billing_country: {
            type: DataTypes.STRING,
            defaultValue: "United States",
            allowNull: false
        },
        location_type: {
            type: DataTypes.STRING,
            allowNull: false
        },
        email: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                isEmail: true
            }
        },
        phone_number: {
            type: DataTypes.STRING,
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
                Customer.hasMany(models.Order)
            }
        }
    });

    return Customer;
};