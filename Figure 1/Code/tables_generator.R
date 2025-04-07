library(data.table)
library(dplyr)

### create 2016 table ###
all_data <- read.csv(file.choose()) #anon_classified_data_2016.csv
# Convert the data frame to data.table
setDT(all_data)

usr_stat <- all_data[, .(
  count = .N,
  type = ifelse("unofficial" %in% type, "unofficial", "official")
), by = .(user_id, bias)]

usr_stat=all_data[,.(count=.N,
                     type=ifelse("unofficial" %in% type, "unofficial","official")),
                  by=.(user_id, bias)]

usr_stat_unique=usr_stat[,.SD[which.max(rank(count, ties.method = "random"))],by=.(user_id)]
usr_stat_by_cat=merge(usr_stat_unique[,.(N_u=.N), by=bias],usr_stat_unique[type=="unofficial",.(Nu_no=.N), by=bias],by = "bias")
table_data=merge(all_data[,.(N_t=.N), by=bias],all_data[type=="unofficial", .(Nt_no=.N), by=bias], by.x="bias", by.y="bias")
table_data=merge(table_data,usr_stat_by_cat,by="bias")
table_data$bias=factor(table_data$bias, 
                       levels = c("Fake & extreme bias", "right", "lean_right", "center","lean_left","left"),
                       labels = c("Fake & extreme bias","Right news","Right leaning news",
                                  "Center news",
                                  "Left leaning news","Left news"))
table_data=table_data[order(bias)]
table_data$p_t=table_data$N_t/sum(table_data$N_t)
table_data$p_u=table_data$N_u/sum(table_data$N_u)
table_data$Nt_Nu=table_data$N_t/table_data$N_u
table_data$pt_no=table_data$Nt_no/table_data$N_t
table_data$pu_no=table_data$Nu_no/table_data$N_u
table_data$Ntno_Nuno=table_data$Nt_no/table_data$Nu_no

table_data_for_plot_2016=table_data[,.(bias,N_t,p_t,N_u,p_u,Nt_Nu,pt_no,pu_no,Ntno_Nuno)]
fwrite(table_data_for_plot_2016, file="\table_data_unique_users_2016_remade.csv") # specify your output directory here

rm(list=ls())
gc()

##### create 2020 table ###
classified_data_with_double_links <- read.csv(file.choose(), colClasses = "character") # anon_classified_data_with_doubles.csv.gz

unofficial_tweet_ids <- fread(file.choose(), header=F,colClasses = "character") #"data/anon_unofficial_tweet_ids.csv"

unofficial_tweet_ids=rename(unofficial_tweet_ids,tweet_id=V1)
unofficial_tweet_ids=distinct(unofficial_tweet_ids,tweet_id,.keep_all=T)
unofficial_tweet_ids$tweet_id=as.character(unofficial_tweet_ids$tweet_id)
unofficial_tweet_ids$type="unofficial"
classified=classified_data_with_double_links
classified$tweet_id=as.character(classified$tweet_id)
classified=merge(classified,unofficial_tweet_ids[,.(tweet_id,type)],
                 by.x="tweet_id",
                 by.y="tweet_id",
                 all.x=T)
setDT(classified)
classified$type[is.na(classified$type)]="official"

usr_stat=classified[,.(count=.N,
                       type=ifelse("unofficial" %in% type, "unofficial","official")),
                    by=.(user_id, bias)]

usr_stat_unique=usr_stat[,.SD[which.max(rank(count, ties.method = "random"))],by=.(user_id)]
usr_stat_by_cat=merge(usr_stat_unique[,.(N_u=.N), by=bias],usr_stat_unique[type=="unofficial",.(Nu_no=.N), by=bias],by = "bias")
table_data=merge(classified[,.(N_t=.N), by=bias],classified[type=="unofficial", .(Nt_no=.N), by=bias], by.x="bias", by.y="bias")
table_data=merge(table_data,usr_stat_by_cat,by="bias")

table_data$bias=factor(table_data$bias, 
                       levels = c("Fake news","Extreme bias right","Right news","Right leaning news",
                                  "Center news",
                                  "Left leaning news","Left news","Extreme bias left"))
table_data=table_data[order(bias)]
table_data$p_t=table_data$N_t/sum(table_data$N_t)
table_data$p_u=table_data$N_u/sum(table_data$N_u)
table_data$Nt_Nu=table_data$N_t/table_data$N_u
table_data$pt_no=table_data$Nt_no/table_data$N_t
table_data$pu_no=table_data$Nu_no/table_data$N_u
table_data$Ntno_Nuno=table_data$Nt_no/table_data$Nu_no

table_data_for_plot_2020=table_data[,.(bias,N_t,p_t,N_u,p_u,Nt_Nu,pt_no,pu_no,Ntno_Nuno)]
fwrite(table_data_for_plot_2020, file="table_data_unique_users_2020_remade.csv") # specify your output directory here
