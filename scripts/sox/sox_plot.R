library(ggplot2)
library(ggthemes)
library(extrafont)

getdata <- read.csv("sox_counts.csv", sep=',', colClasses=c('character', 'numeric'));

bar = ggplot(getdata, 
           aes(x=reorder(Sox, -count, sum),
           #aes(x=Sox,
               y=count,
               fill=reorder(Sox, -count, sum))) + 
    geom_bar(width = 1, stat = "identity", color="black") + 
    geom_text(stat="identity", aes(label = count, vjust=-.25), size=2.5, check_overlap=TRUE) +
    scale_fill_manual(name = "Legend",
                    values = c("#C60C30", "white", "#172A76", "#195434", "black", "#F1B014", "#C60C30", "gold", "#C2C5CA", "black", "#AB1B32", 
                               "#04BAE4", "#F27C37", "#118553","#FBBD14","#C60C30","#002F6C","white","gray","#C60C30","purple", "#002244","#99BEE4")) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + labs(x="Sox Type", y="Count" ) + ggtitle("Too Many Sox")

bar
