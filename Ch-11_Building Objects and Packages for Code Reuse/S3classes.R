####create a generic function in the plot() method

plot.SimpleGenome <- function(x){
  barplot(x$chromosome_lengths, main = "Chromosome Lengths")
}
###create an object and use it in plot()
athal <- SimpleGenome(nchr = 5, lengths = c(34964571, 22037565, 25499034, 20862711, 31270811 ) )
plot(athal)

####craete a new method first
genomeLength <- function(x){
  UseMethod("genomeLength", x)
}

genomeLength.SimpleGenome <- function(x){
  return(sum(x$chromosome_lengths))
}

genomeLength(athal)
#####modify an existing objects class
some_data <- iris
summary(some_data)

class(some_data) <- c("my_new_class", class(some_data) )
class(some_data)
####creating a generic function for the new class
summary.my_new_class <- function(x){
  col_types <- sapply(x, class)
  return(paste0("object contains ", length(col_types), " columns of classes:", paste (col_types, sep =",", collapse = "," )))
}

summary(some_data)

