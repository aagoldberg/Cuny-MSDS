theUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"
mushrooms <- read.table (file = theUrl, header = FALSE, sep = ",")
head(mushrooms)
summary(mushrooms)

require(car)
edibility <- as.vector(recode(mushrooms[,1], "'e' = 'edible'; 'p' = 'poisonous'"))
cap_color <- as.vector(recode(mushrooms[,4], "'n' = 'brown'; 'b' = 'buff'; 'c' = 'cinnamon'; 'g' = 'gray'; 'r' = 'green'; 'p' = 'pink'; 'u' = 'purple'; 'e' = 'red'; 'w' = 'white'; 'y' = 'yellow'"))
veil_color <- as.vector(recode(mushrooms[,18], "'n' = 'brown'; 'o' = 'orange'; 'w' = 'white'; 'y' = 'yellow'"))
spore_color <- as.vector(recode(mushrooms[,21], "'k' = 'black'; 'n' = 'brown'; 'b' = 'buff'; 'h' = 'chocolate'; 'r' = 'green'; 'o' = 'orange'; 'u' = 'purple'; 'w' = 'white'; 'y' = 'yellow'"))
mushroom_colors <- cbind(edibility, cap_color, veil_color, spore_color)

summary(mushroom_colors)


