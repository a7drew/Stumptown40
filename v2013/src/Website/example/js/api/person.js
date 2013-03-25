/* Metoder for å gjøre kall mot person-API. */
myapp.api.person = {

    all: function(callback) {
        /* Eksempel på data fra serveren: en liste over alle personer. */
        /* Her ville man vanligvis gjort et Ajax-kall mot serveren. */
        callback(myapp.model.createAll(myapp.model.person, myapp.api.person.fakedata()));
    },

    fakedata: function() {
        var data = [];
        for (var i = 0; i < 100; i++) {
            data.push({
                firstname: Faker.Name.firstName(),
                lastname: Faker.Name.lastName()
            });
        }
        return data;
    }

};
