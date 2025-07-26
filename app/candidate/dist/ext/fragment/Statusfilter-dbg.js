sap.ui.define(["sap/ui/model/Filter", "sap/ui/model/FilterOperator"], function(Filter, FilterOperator) {
    "use strict";
    return {
        filterItems: function(sValue) {
            if (!sValue) return null;
            return new Filter({
                path: "status",  
                operator: FilterOperator.EQ,
                value1: sValue
            });
        }
    };
});
