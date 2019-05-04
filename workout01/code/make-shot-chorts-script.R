#title : Charts R code
#description : R code for making the charts
#inputs :
#outputs :

library(jpeg)
library(grid)
library(ggplot2)
setwd("/Users/junghun/desktop/stat133/workout01/images")
court_file<-"../images/nba-court.jpg"
court_image <- rasterGrob(
    readJPEG(court_file),
    width = unit(1,"npc"),
    height = unit(1,"npc"))
andre_iguodala_shot_chart <- ggplot(data=iguodala)+
  annotation_custom(court_image, -250,250,-50,420)+
  ylim(-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ggtitle('Shot Chart: Andre Iguodala (2016 season)')+
  theme_minimal()
dreymond_green_shot_chart <- ggplot(data=green)+
  annotation_custom(court_image, -250,250,-50,430)+
  ylim(-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ggtitle('Shot Chart: Dreymond Green (2016 season)')+
  theme_minimal()
kevin_durant_shot_chart <- ggplot(data=durant)+
  annotation_custom(court_image, -250,250,-50,420)+
  ylim(-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ggtitle('Shot Chart: Kevin Durant (2016 season)')+
  theme_minimal()
klay_thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Klay Thompson (2016 season)')+
  theme_minimal()
stephen_curry_shot_chart <- ggplot(data=curry)+
  annotation_custom(court_image,-250,250,-50,420)+
  ylim(-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ggtitle('Shot Chart: Stephen Curry 92016 season)')+
  theme_minimal()

gsw_shot_charts<- ggplot(data=assembled_table)+
  annotation_custom(court_image, -250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Charts: GSW (2016 season)')+
  facet_wrap(~name)+
  theme_minimal()
