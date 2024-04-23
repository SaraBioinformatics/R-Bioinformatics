###create a constructor functions
SimpleGenome <- function( nchr=NA, lengths = NA){
  
  genome <- list(
    chromosome_count = nchr,
    chromosome_lengths = lengths
  )
  class(genome) <- append(class(genome), "SimpleGenome")
  return(genome)
}

###call the constructor to make new object
ecoli <- SimpleGenome(nchr = 1, lengths = c(4600000) )
bakers_yeast <- SimpleGenome(nchr = 1, lengths=c(12100000))
ecoli
bakers_yeast