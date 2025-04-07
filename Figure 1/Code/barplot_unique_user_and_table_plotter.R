library(data.table)
library(ggplot2)
library(ggpubr)
library(latex2exp)
library(xtable)
library(latex2exp)
library(dplyr)
library(ggpattern)
library(cowplot)
library(viridis)
library(igraph)
library(dplyr)
color_values <- c("#282828","#8F100B","#DB4742","#CFDB00","#4495DB","#082E4F")

table_data_for_plot_2016 <- read.csv(file.choose()) #"data/generated/table_data_unique_users_2016.csv"
table_data_for_plot_2020 <- read.csv(file.choose()) #"data/generated/table_data_unique_users_2020.csv"

n_2020_unique_tw=72738094 # this data can be obtained by loading all classified tweets and count the rows, but it would require much more time
n_2020_unique_usr=sum(table_data_for_plot_2020$N_u)
n_2016_unique_tw=30756752 # this data can be obtained by loading all classified tweets  and count the rows, but it would require much more time
n_2016_unique_usr=sum(table_data_for_plot_2016$N_u)

data_old_all=table_data_for_plot_2016

data_old_all_plot <- data_old_all %>%
  group_by(bias) %>%
  summarize(n_tweet = sum(N_t), n_user = sum(N_u))

data_old_all_plot$bias=factor(data_old_all_plot$bias, 
                              levels=rev(c("Fake & extreme bias",
                                       "Right news",
                                       "Right leaning news",
                                       "Center news",
                                       "Left leaning news",
                                       "Left news")),
                              labels = rev(c("Fake news & \nextreme bias",
                                         "Right",
                                         "Right \nleaning",
                                         "Center",
                                         "Left \nleaning",
                                         "Left")))
data_old_all_plot$year="2016"

#### NEW DATA ####
data_new_all=table_data_for_plot_2020
data_new_all$bias=as.character(data_new_all$bias)
data_new_all$bias[data_new_all$bias=="Fake news"]="Fake news & \nextreme bias"
data_new_all$bias[data_new_all$bias=="Extreme bias right"]="Fake news & \nextreme bias"
data_new_all$bias[data_new_all$bias=="Extreme bias left"]="Fake news & \nextreme bias"

data_new_all_plot <- data_new_all %>%
  group_by(bias) %>%
  summarize(n_tweet = sum(N_t), n_user = sum(N_u))
data_new_all_plot$bias=factor(data_new_all_plot$bias, 
                              levels=rev(c("Fake news & \nextreme bias",
                                       "Right news",
                                       "Right leaning news",
                                       "Center news",
                                       "Left leaning news",
                                       "Left news")),
                              labels = rev(c("Fake news & \nextreme bias",
                                         "Right",
                                         "Right \nleaning",
                                         "Center",
                                         "Left \nleaning",
                                         "Left")))
data_new_all_plot$year="2020"

data_new_all_plot$n_tweet=data_new_all_plot$n_tweet/n_2020_unique_tw
data_new_all_plot$n_user=data_new_all_plot$n_user/n_2020_unique_usr
data_old_all_plot$n_tweet=data_old_all_plot$n_tweet/n_2016_unique_tw
data_old_all_plot$n_user=data_old_all_plot$n_user/n_2016_unique_usr

barplot_stat=rbind(data_new_all_plot,data_old_all_plot)

barplot_stat <- as.data.table(barplot_stat)
data_all_together <- rbind(barplot_stat[,.(bias,count=n_tweet,year,type="Proportion of tweets")],
                        barplot_stat[,.(bias,count=n_user,year,type="Proportion of users")])

#### PATTERN ####
color_stripes_values=c("#6F6F6F","#D00E0E","#FF6B66","#A3AC00","#3572A7","#1362A6")
all_bar <- ggplot(data_all_together, aes(x=bias,y=count, fill=bias, group=year, color=bias))+
  geom_col_pattern(position = position_dodge(width=0.9), width = 0.8,
                   pattern =c("stripe","stripe","stripe","stripe","stripe","stripe","none","none","none","none","none","none",
                              "stripe","stripe","stripe","stripe","stripe","stripe","none","none","none","none","none","none"),
                   pattern_angle = 45,
                   pattern_density = .1,
                   pattern_spacing = .04,
                   pattern_fill = rep(color_stripes_values,4),
                   pattern_colour=rep(color_stripes_values,4)
                   )+
  scale_fill_manual(values =rev(color_values))+
  scale_color_manual(values =rev(color_values))+
  theme_minimal()+
  theme(legend.position = "bottom",
        text=element_text(size=30),
        axis.text.x=element_text(angle=60, hjust=1, size=26),
        axis.title.x=element_blank())+
  facet_grid(.~type, switch = 'y')+
  theme(axis.title.y = element_blank(),
        strip.placement = "outside",
        panel.spacing = unit(2, "lines"),
        plot.margin = unit(c(1,1,1,1), "lines"))+
  guides(group = guide_legend(override.aes = 
                                list(
                                  pattern = c("none", "stripe"),
                                  pattern_spacing = .01,
                                  pattern_angle = c(0, 0, 0, 45)
                                )),
                              colour =  FALSE,
                              fill = FALSE,
                              pattern=T
  )+
  coord_fixed(ratio = 8/1)

all_bar
similarity_data_2016 <- read.csv(file.choose()) #anon_data/generated/similarity_users_cat_2016_eb_fake_merged.csv 
similarity_data <- read.csv() #anon_data/generated/similarity_users_cat_2020_eb_fake_merged.csv

similarity_data$row=factor(similarity_data$row, levels = rev(c("Fake news & extreme bias", "Right news", "Right leaning news",
                                                                 "Center news", "Left leaning news", "Left news")),
                              labels= rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                        "Center news", "Left leaning\nnews", "Left news")))
similarity_data$col=factor(similarity_data$col, levels = rev(c("Fake news & extreme bias", "Right news", "Right leaning news",
                                                               "Center news", "Left leaning news", "Left news")),
                           labels= rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                         "Center news", "Left leaning\nnews", "Left news")))

similarity_data_2016$row=factor(similarity_data_2016$row, levels =  rev(c("Fake & extreme bias", "right", "lean_right",
                                                                      "center", "lean_left", "left")),
                           labels= rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                     "Center news", "Left leaning\nnews", "Left news")))
similarity_data_2016$col=factor(similarity_data_2016$col, levels =  rev(c("Fake & extreme bias", "right", "lean_right",
                                                                          "center", "lean_left", "left")),
                                labels= rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                              "Center news", "Left leaning\nnews", "Left news")))

all_similarity_data <- rbind(data.frame(similarity_data_2016[, c("row", "col", "val", "count")], year = "2016"),
                             data.frame(similarity_data[, c("row", "col", "val", "count")], year = "2020"))

### shortneded labels ###
all_similarity_data$row=factor(all_similarity_data$row, levels = rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                                                   "Center news", "Left leaning\nnews", "Left news")),
                                                        labels=rev(c("Fake news &\nExtreme bias", "Right", "Right leaning",
                                                                 "Center", "Left leaning", "Left")))
all_similarity_data$col=factor(all_similarity_data$col, levels = rev(c("Fake news &\nExtreme bias", "Right news", "Right leaning\nnews",
                                                                       "Center news", "Left leaning\nnews", "Left news")),
                               labels=rev(c("Fake news &\nExtreme bias", "Right", "Right leaning",
                                            "Center", "Left leaning", "Left")))

all_tile=ggplot(all_similarity_data, aes(x=col, y=row,fill=val))+
            geom_tile()+
            scale_fill_viridis(limits=c(0,0.7),#breaks = c(0, 0.2, 0.4, 0.6),
                               guide = guide_colourbar(draw.ulim = T, draw.llim = T,
                                                       barwidth = 1, barheight =24))+
            theme_classic()+
            theme(text=element_text(size=30),
                  #axis.title = element_blank(),
                  axis.line = element_blank(),
                  axis.text = element_text(size=28),
                  axis.text.x = element_text(angle=90, hjust=1, vjust=0.5),
                  panel.spacing = unit(2, "lines"),
                  strip.background = element_rect(colour="white", fill="white"),
                  strip.text.x=element_text(size=30),
                  plot.margin = unit(c(1,1,1,1), "lines"))+
            labs(x="Links category ", y="User main category", fill="Proportion\nof links")+
            coord_fixed()+
            facet_grid(.~year)

all_tile

figure=ggarrange(all_bar,all_tile, nrow=2)
ggsave("figure_1.pdf", figure, device = "pdf", path = ".", width = 20.00, height = 20.00, units = "in")


all_data_in_one_table=rbind(table_data_for_plot_2016,table_data_for_plot_2020)
print(xtable(all_data_in_one_table, type = "latex"))
