/* Prototype for alle view-modeller. */
myapp.model.viewmodel = {

    /*
     * Kompiler en view-modell for å bruke den i et template.
     * Returnerer alle variabler som skal kunne brukes i template-filen.
     */ 
    compile: function() {},

    /*
     * Kalles etter template-filen har blitt renderet. 
     * Her legges hver view-modells DOM-mainpulasjon. 
     */ 
    apply: function() {}
    
};
