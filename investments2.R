#investments2--trying to simplify the code
rm(list=ls())
abs_path <- '/users/claytonblythe/Desktop/Mega/Statistics_Machine_Learning/'
setwd(abs_path)
#libraries that will be used
x <- c("ggplot2", "dplyr", "animation", "RColorBrewer", "reshape2", "ggthemes", "gganimate", "nnet")
lapply(x, require, character.only=TRUE)

#get the data in the appropriate format
import <- read.csv('sp_data.csv')
data <- select(import, 1:9)
#create new variables
data <- mutate(data, appreciation_multiplier = NA, real_account_value = NA, real_cash_multiplier = NA, years_passed = (seq(from=0, to=nrow(data)-1)/12)) %>% slice(1:1746)
#set initial values appropriately prior to loop
data$appreciation_multiplier[1] = 1
data$real_account_value[1] = data$Real.Price[1]
data$real_cash_multiplier[1] = 1

#calculate the consecutive values for the account, this could probably be sped up using sapply but this works quickly for now
for (i in 2:nrow(data)){
  data$appreciation_multiplier[i] = data$Real.Price[i] / data$Real.Price[i-1]
  data$real_account_value[i] = (data$real_account_value[i-1] * data$appreciation_multiplier[i]) + (data$Real.Dividend[i-1]/data$Real.Price[i-1])*(data$real_account_value[i-1]/12) 
  data$real_cash_multiplier[i] = data$real_account_value[i] / data$real_account_value[1]
}

#create a dummy function for finding the relevant cash multipliers for various dates and time horizons 
dummy <- function(x,y) data$real_account_value[x+y-1]/data$real_account_value[x]
#this part takes about a minute or so to run, here we go through all 1746 months of observations, grabbing values up to  481 months (which is 40 years) ahead
performance <- sapply(1:481, function(j) sapply(1:1746, function(i) dummy(i,j)))
#each column of the matrix is a different time horizon, starting at 0 months going to 481 months
performance <- data.frame(performance)
names(performance) <- formatC(round(seq(from=0, to=480)/12,2),2, format="f")
performance$date <- as.Date(data$Date)
#use the reshape package to "melt" the performance data into three columns for date, time horizon of investment, and cash multiplier
performance_melted <- na.omit(melt(performance,id.vars = c("date"), preserve.na=FALSE, variable.name="time_horizon", value.name = "cash_multiplier"))
performance_melted$time_horizon <- as.numeric(as.character(performance_melted$time_horizon))

# 
# ##### To save a GIF ###########
saveGIF((
  for (i in seq(from=1, to=481, by=1)){
    d <- density(performance[,i], na.rm = TRUE)
    avg <- mean(performance[,i], na.rm=TRUE)
    mode <- d$x[which.is.max(d$y)]
    sd <- sd(performance[,i], na.rm=TRUE)
    plot(d, main="S&P 500 Cash Multipliers Over Various Time Horizons by /u/EtherealOptimist", col="brown2", border="brown2", xlim = c(0,25), ylim = c(0,.5), xlab = "Cash Multiplier", ylab = "Density", xaxs = "i", yaxs = "i", cex.lab=1.4, cex.main=1.7)
    polygon(d, col="indianred1")
    text(x=16.5, y=.47, labels=paste("Time Horizon (Years): ", format(names(performance[i])), sep=""), col='gray3', cex =1.5)
    text(x=16.5, y=.45, labels=paste("Mode: ", format(round(mode, 2),nsmall=2),  sep=""), col='gray3', cex =1.5)
    text(x=16.5, y=.43, labels=paste("Mean: ", format(round(avg, 2),nsmall=2),  sep=""), col='gray3', cex =1.5)
    text(x=16.5, y=.41, labels=paste("SD:     ", format(round(sd, 2),nsmall=2),  sep=""), col='gray3', cex =1.5)
    text(x=16.5, y=.39, labels=paste("COV:  ", format(round(sd/avg, 2),nsmall=2),  sep=""), col='gray3', cex =1.5)
    abline(v=avg, col="chartreuse3", lwd=3, lty=2)
    abline(v=mode, col="black", lwd=3, lty=2)
  }
), movie.name = "investments_final.gif", interval = 0.08, nmax = ifelse(interactive(), 30, 2), ani.width = 1066, ani.height = 600, clean=TRUE)

##HEAT MAP
# m <- ggplot(data=performance_melted,aes(x=time_horizon, y=date))
# m + scale_y_date(date_breaks = "4 year",  date_labels = "%Y", expand = c(0,0)) + scale_x_continuous(breaks = round(seq(min(performance_melted$time_horizon), max(performance_melted$time_horizon), by = 2),1), expand=c(0,0)) + scale_fill_distiller(palette = "Spectral", direction=-1, guide=guide_colorbar(title="Cash Multiplier")) + theme_classic() +xlab("Time Horizon")+ylab("Date") +geom_tile(aes(fill=cash_multiplier)) + ggtitle("S&P 500 Investment Outcomes by /u/etherealoptimist") 
# ggsave("cashmultipliers_Spectral_10years_withname.pdf", plot=last_plot())

# 
# #Overlapping Density Plots with ggplot2
# relevant_years <- filter(performance_melted, time_horizon %% 10 == 0 & time_horizon > 0 & time_horizon <=40)
# ggplot(relevant_years, aes(x = cash_multiplier, fill = as.factor(time_horizon))) +
#   geom_density(position = "identity", alpha = 0.8) +
#   scale_x_continuous(name = "Cash Multiplier",
#                      breaks = seq(0,20,2),
#                      limits=c(0, 19)) +
#   scale_y_continuous(name = "Density") + ylim(0,.5) +
#   ggtitle("S&P 500 Investment Outcomes (1871-Present)") +
#   theme_economist() +
#   theme(plot.title = element_text(size = 19, family = "Tahoma", face = "bold"),
#         text = element_text(size = 17, family = "Tahoma")) +
#   scale_fill_brewer("Time Horizon", palette="Accent") + ylab("Density") +annotate("text", label="/u/etherealoptimist", x = 17, y=.22)
# ggsave("40years_10yrinc.png", plot=last_plot(), dpi=300)
