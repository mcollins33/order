$(document).ready(function() {

    let states = ["AZ", "AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"];
    let countries = ["United States", "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Anguilla", "Antigua &amp; Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia &amp; Herzegovina", "Botswana", "Brazil", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Cape Verde", "Cayman Islands", "Chad", "Chile", "China", "Colombia", "Congo", "Cook Islands", "Costa Rica", "Cote D Ivoire", "Croatia", "Cruise Ship", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia", "French West Indies", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kuwait", "Kyrgyz Republic", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Mauritania", "Mauritius", "Mexico", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Namibia", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russia", "Rwanda", "Saint Pierre &amp; Miquelon", "Samoa", "San Marino", "Satellite", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "South Africa", "South Korea", "Spain", "Sri Lanka", "St Kitts &amp; Nevis", "St Lucia", "St Vincent", "St. Lucia", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor L'Este", "Togo", "Tonga", "Trinidad &amp; Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks &amp; Caicos", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Venezuela", "Vietnam", "Virgin Islands (US)", "Yemen", "Zambia", "Zimbabwe"];
    let location = ["Business", "Residence", "Other"];

    for (let i = 0; i < location.length; i++) {
        let locationList = $("<option>");
        locationList.attr("id", location[i]);
        locationList.text(location[i]);
        $("#location-list").append(locationList);
    }
    for (let i = 0; i < states.length; i++) {
        let statesList = $("<option>");
        statesList.attr("id", states[i]);
        statesList.text(states[i]);
        $("#states-list").append(statesList);
    }
    for (let i = 0; i < countries.length; i++) {
        let countriesList = $("<option>");
        countriesList.attr("id", countries[i]);
        countriesList.text(countries[i]);
        $("#countries-list").append(countriesList);
    }


    $("#customer-search-button").on("click", function(event) {
        event.preventDefault();
        $("#customer-list").empty();
        let customerSearch = $("#customer-search").val().trim();
        console.log(customerSearch);

        const customerQuery = (search) => {
            $.get("/api/customer/" + search, function(result) {

                for (let i = 0; i < result.length; i++) {
                    let customerOptions = $("<button type='button'>");
                    customerOptions.addClass("customer");
                    customerOptions.attr("id", result[i].id);
                    customerOptions.append(result[i].customer_name);
                    customerOptions.append(result[i].contact_name);
                    customerOptions.append(result[i].phone_number);
                    $("#customer-list").append(customerOptions);
                }
            })
        };

        customerQuery(customerSearch);
    });

    $(document).on("click", ".customer", function(event) {
        event.preventDefault();
        let id = $(this).attr('id');
        $.get("/api/customer/id/" + id, function(result) {
            console.log(result);
            $("#account-name").attr("placeholder", result.customer_name);
            $("#account-id").attr("placeholder", result.id);
            $("#contact-name").attr("placeholder", result.contact_name);
            $("#contact-email").attr("placeholder", result.email);
            $("#location-list").val(result.location_type);
            $("#billing-street-1").attr("placeholder", result.billing_street_1);
            $("#billing-street-2").attr("placeholder", result.billing_street_2);
            $("#billing-city").attr("placeholder", result.billing_city);
            $("#states-list").val(result.billing_state);
            $("#billing-postal-code").attr("placeholder", result.billing_postal_code);
            $("#countries-list").val(result.billing_country);
        }) 
    });


});