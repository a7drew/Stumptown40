myapp.route.person = function(app) {

    /* Definer en route. */
    app.get("", function(context) {

        /* Gjør et kall mot serveren. */
        myapp.api.person.all(function(people) {

            /* Definer hvilken template-filer som trengs. */
            var template = "template/person-list.hb";
            var partials = { searchbox: "template/shared/searchbox.hb" };

            /* Instansierer view-modellene */
            var searchview = myapp.model.create(myapp.view.shared.searchbox);
            var peopleview = myapp.model.create(myapp.view.people, { people: people });
            
            /* Bytt ut innholdet i "#page" med ny HTML. */
            context.renderAll(template, partials, [peopleview, searchview]);

        });

    });

};
