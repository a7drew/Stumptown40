/* Prototype for person-instanser. */
myapp.model.person = myapp.model.create(myapp.model.datamodel, {

    name: function() {
        return this.firstname + " " + this.lastname;
    }

});
