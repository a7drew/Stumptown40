/* Prototype for en view-modell som inneholder søke muligheter. */

myapp.view.shared.searchbox = myapp.model.create(myapp.model.viewmodel, {
   
    compile: function() {
        return {};
    },

    apply: function() {
        var that = this;
        $("#search-input").on("keyup", function (event) {
            that.search(); 
        });
    },

    search: function() {
        var searchString = $('#search-input').val();

        if (searchString === "") {
            $("li").show();
        } else {
            var list = $("ul");
            list.find("li:not(:contains(" + searchString + "))").hide();
            list.find("li:contains(" + searchString + ")").show();    
        }
    }
    
});
