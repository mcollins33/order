// *********************************************************************************
// api-routes.js - this file offers a set of routes for displaying and saving data to the db
// *********************************************************************************

// Dependencies
// =============================================================

// Requiring our Todo model
var db = require("../models");

// Routes
// =============================================================
module.exports = function(app) {

    // Route for getting some data about our user to be used client side
    app.get("/api/customer/:search", function(req, res) {
        db.Customer.findAll({
                where: {
                    [db.sequelize.Op.or]: [{
                            customer_name: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            contact_name: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            billing_street_1: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            billing_street_2: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            billing_city: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            billing_state: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            billing_postal_code: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        },
                        {
                            phone_number: {
                                [db.sequelize.Op.like]: '%' + req.params.search + '%'
                            }
                        }
                    ]
                }


            })
            .then(function(dbCustomer) {
                res.json(dbCustomer);
            });
    });

    app.get("/api/customer/id/:id", function(req, res) {
        console.log(req.params.id);
        db.Customer.findById(req.params.id)
            .then(function(dbCustomer) {
                res.json(dbCustomer);
            });
    });
};