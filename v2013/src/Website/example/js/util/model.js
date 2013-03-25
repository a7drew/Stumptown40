/* Metode for å instansiere en modell. */
myapp.model.create = function(prototype, properties) {
    return myapp.model.merge(Object.create(prototype), properties);
};

/* Metode for å lage mange instanser. */
myapp.model.createAll = function(prototype, propertiesList) {
    return propertiesList.map(function(properties) {
        return myapp.model.create(prototype, properties);
    });
};

/* Kompiler en liste av view-modeller. */
myapp.model.compileAll = function(models) {
    var compiled = {};
    models.forEach(function(model) {
        compiled = myapp.model.merge(compiled, model);
    });
    return compiled;
};
    
/* Kjør apply-metodene til en liste av view-modeller. */
myapp.model.applyAll = function(models) {
    models.forEach(function(model) {
        model.apply();
    });
};

/* Kombiner to objekter. */
myapp.model.merge = function(o1, o2) {
    for(var key in o2) {
        if(o2.hasOwnProperty(key)) {
            o1[key] = o2[key];
        }
    }

    return o1;
};
