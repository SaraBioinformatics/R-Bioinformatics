####write the class definition
S4genome <- setClass("S4genome", slots = list(chromosome_count = "numeric", chromosome_lengths = "numeric" ))

ecoli <- S4genome(chromosome_count = 1, chromosome_lengths = c(4600000) )
###craete a generic function
setGeneric( "chromosome_count", 
            function(x){ standardGeneric("chromosome_count") }
)
###create the  method
setMethod( "chromosome_count", "S4genome", function(x){ slot(x, "chromosome_count")} )

chromosome_count(ecoli)

