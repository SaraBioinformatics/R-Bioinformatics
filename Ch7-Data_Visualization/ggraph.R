#############representing relational  data as networks ################

####load the packages and prepare the dataframe
library(ggraph)
library(magrittr)
getwd()
setwd("Downloads")
df <- readr::read_delim(file.path(getwd(), "R_cook", "Ch7", "bio-DM-LC.edges"), delim = " ", col_names = c("nodeA", "nodeB", "weight")) %>% dplyr::mutate(edge_type = sample(LETTERS[1:2], length(weight), replace = TRUE))

#####create an igraph object and use it in a basic plot
graph <- igraph::graph_from_data_frame(df)

ggraph(graph, layout = "kk") + 
  geom_edge_link() + 
  geom_node_point() + 
  theme_void()

######color the edges according to their value or type
ggraph(graph, layout = "fr") + 
  geom_edge_link(aes(colour = edge_type)) + 
  geom_node_point() + 
  theme_void()

##add node attributes straight to graph object

igraph::V(graph)$category <- sample(c("Nucleus", "Mitochondrion", "Cytoplasm"), length(igraph::V(graph)), replace = TRUE )

igraph::V(graph)$degree <- igraph::degree(graph)

ggraph(graph, layout = "fr") + 
  geom_edge_link(aes(colour = edge_type)) + 
  geom_node_point(aes(size = degree, colour = category)) + 
  theme_void()

