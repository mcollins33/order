module.exports = (sequelize, DataTypes) => {
    var User = sequelize.define('User', {
        first_name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        last_name: {
            type: DataTypes.STRING,
            allowNull: false,
        }
    }, {
        timestamps: false
    }, {
        classMethods: {
            associate: function(models) {
                // associations can be defined here
                User.hasMany(models.Order)
            }
        }
    });
    return User;
};