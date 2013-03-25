/* Jobb på HTML-elementet “#page”. */
$.sammy("#page", function() {

    /* Bruk Handlebars-plugin. */
    this.use('Handlebars', 'hb');

    /* Start routes. */
    myapp.route.person(this);

    this.helpers({

        /* En hjelpefunksjon for å rendre sider med mange view-modeller. */
        renderAll: function(template, partials, models) {
            var context = this;
            context.render(template, myapp.model.compileAll(models), function(html) {
                context.swap(html);
                myapp.model.applyAll(models);
            }, partials);
        }

    });

}).run();
