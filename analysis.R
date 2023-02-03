install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)  

data <- read.csv("tech_layoffs.csv")

head(data)

str(data)

cols <- colnames(data)

company_names <- unique(data$company)
company_nums <- length(company_names)

print(data$total_layoffs)

no_unclear_data <- subset(data, data$total_layoffs != "Unclear")
head(no_unclear_data)

str(no_unclear_data)

plot(no_unclear_data$total_layoffs)

fdate <- as.factor(no_unclear_data$reported_date)
fdate <- strptime(fdate, format="%m/%d/%Y")
no_unclear_data$reported_date <- as.Date(fdate, "%Y-%m-$d")
print(length(no_unclear_data$reported_date))


plot(no_unclear_data$reported_date, no_unclear_data$total_layoffs)
axis(1, data$reported_date, format(data$reported_date, "%b %d"), cex.axis = .7)


date_range <- unique(no_unclear_data$reported_date)
no_unclear_data$total_layoffs = as.integer(no_unclear_data$total_layoffs)
summarised <- no_unclear_data %>%
  group_by(reported_date) %>%
  summarise(total = sum(total_layoffs))

hist(summarised$reported_date, summarised$total, breaks=10, xaxt="n")
axis(1, summarised$reported_date, labels=format(summarised$reported_date, "%Y-%m"))
plot(summarised$reported_date, summarised$total)
