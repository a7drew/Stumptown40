myapp.view.people = myapp.model.create(myapp.model.viewmodel, {
    
    compile: function() {
        return { people: this.people };
    },

    apply: function() {
        $("#people li").click(function(event) {
            alert($(this).text() + " clicked!");
        });
    }

});
