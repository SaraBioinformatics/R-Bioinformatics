#####creating colormaps for two-variable data #######

####create a basic heatmap
library(heatmap3)

###remove the dendrogram
heatmap(WorldPhones)
heatmap(WorldPhones, Rowv = NA, Colv = NA)
####add a color scale to the groups 
rc <- rainbow(nrow(WorldPhones), start = 0, end = .3)
cc <- rainbow(ncol(WorldPhones), start = 0, end = .3)

heatmap(WorldPhones, ColSideColors = cc)
###change the palette
library(RColorBrewer)
heatmap(WorldPhones, ColSideColors = cc, 
        col = colorRampPalette(brewer.pal(8, "PiYG"))(25))

## rescale the data
heatmap(WorldPhones, ColSideColors = cc, scale = "column")


##See also
library(gplots)
heatmap.2(WorldPhones, ColSideColors = cc, 
          col = colorRampPalette(brewer.pal(8, "PiYG"))(25))
