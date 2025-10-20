library(readxl)
Bike_sharing <- read_excel("C:/Users/User/Documents/SDA/Asg2/Dataset_A2_97444_98439_98485_101224.xlsx")
pairs(Bike_sharing[,c(16,13,12,11,10,9,8,7,6,5,4,3)], lower.panel=NULL)

#check collinearity between the two predictors
cor(Bike_sharing$atemp, Bike_sharing$temp)

#check variables
str(Bike_sharing)

#convert to categorical variables
Bike_sharing$season <- factor(Bike_sharing$season, levels=c(1,2,3,4), 
                              labels=c("Winter", "Spring", "Summer", "Fall"))
Bike_sharing$yr <- factor(Bike_sharing$yr, levels=c(0, 1), 
                          labels=c("2011", "2012"))
Bike_sharing$holiday <- factor(Bike_sharing$holiday, levels=c(0,1), 
                               labels=c("No holiday", "Holiday"))
Bike_sharing$weekday <- factor(Bike_sharing$weekday, levels=c(0,1), 
                               labels=c("Weekday", "Weekend"))
Bike_sharing$weathersit <- factor(Bike_sharing$weathersit, levels=c(1,2,3), 
                                  labels=c("Clear or Partly Cloudy", "Misty or Overcast", "Light Snow or Rain"))

levels(Bike_sharing$season)
levels(Bike_sharing$yr)
levels(Bike_sharing$holiday)
levels(Bike_sharing$weekday)
levels(Bike_sharing$weathersit)

str(Bike_sharing)

#check reference level and dummy variables
contrasts(Bike_sharing$season)
contrasts(Bike_sharing$yr)
contrasts(Bike_sharing$holiday)
contrasts(Bike_sharing$weekday)
contrasts(Bike_sharing$weathersit)


#baseline model: remove mnth, workingday, temp
#because working day overlaps info with weekday, will make it redundant 
Bike_sharing.lm <- lm(cnt ~ season + yr + holiday + weekday + weathersit + atemp + hum 
                      + windspeed, data= Bike_sharing)
summary(Bike_sharing.lm)

#Diagnostic plot
plot(Bike_sharing.lm, which=1, col="blue")
plot(Bike_sharing.lm, which=2, col="blue")
plot(Bike_sharing.lm, which=3, col="blue")



#model including interaction term
Bike_sharing_itr.lm <- lm(cnt ~ season*atemp + yr + holiday + weekday + weathersit + hum 
                          + windspeed, data= Bike_sharing)
summary(Bike_sharing_itr.lm)

#Diagnostic plot
plot(Bike_sharing_itr.lm, which =1, col="blue")
plot(Bike_sharing_itr.lm, which =2, col="blue")
plot(Bike_sharing_itr.lm, which =3, col="blue")



#square root transformation on total daily bike rental (y)
Bike_sharing_tr1.lm <- lm(sqrt(cnt) ~ season*atemp + yr + holiday + weekday + weathersit + hum
                          + windspeed, data= Bike_sharing)
summary(Bike_sharing_tr1.lm)

plot(Bike_sharing_tr1.lm, which = 1, col="blue")
plot(Bike_sharing_tr1.lm, which = 2, col="blue")
plot(Bike_sharing_tr1.lm, which = 3, col="blue")

#Choosing model using AIC score
AIC(Bike_sharing.lm, Bike_sharing_itr.lm, Bike_sharing_tr1.lm)

#convert from sqrt(cnt) to cnt for prediction (but not on unseen data)
predicted_cnt <- predict(Bike_sharing_tr1.lm)
predicted_cnt_original <- predicted_cnt^2

#to get the min,max estimated total daily bike rentals
summary(predicted_cnt_original)






#full_model.lm <- lm(cnt ~., data= Bike_sharing)
#summary(full_model.lm)

# backward elimination 
#backward_model <- step(full_model.lm, scope=formula(~.), direction="backward")


#remove mnth & temp
#Bike_sharing_1.lm <- lm(cnt ~ season + yr + holiday + weekday + workingday + weathersit + atemp + hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_1.lm)

#remove workingday
#Bike_sharing_2.lm <- lm(cnt ~ season + yr + holiday + weekday + weathersit + atemp + hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_2.lm)



#after square root transformation on bike rental (y) : scatterplot matrix
#Bike_sharing$sqrt_cnt <- sqrt(Bike_sharing$cnt)
#pairs(Bike_sharing[, c("sqrt_cnt", "windspeed", "hum", "atemp", "weathersit", "weekday", "holiday", "yr", "season")], lower.panel=NULL)

#trial and error
#transformation: log transformation on y
#Bike_sharing_tr2.lm <- lm(log10(cnt) ~ season*atemp + yr + holiday + weekday + weathersit + hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_tr2.lm)

#plot(Bike_sharing_tr2.lm, which = 1)
#plot(Bike_sharing_tr2.lm, which = 2)
#plot(Bike_sharing_tr2.lm, which = 3)


#transformation: natural log transformation on y
#Bike_sharing_tr3.lm <- lm(log(cnt) ~ season*atemp + yr + holiday + weekday + weathersit + hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_tr3.lm)

#plot(Bike_sharing_tr3.lm, which = 1)
#plot(Bike_sharing_tr3.lm, which = 2)
#plot(Bike_sharing_tr3.lm, which = 3)


#interaction term
#weathersit * hum : not so significant
#Bike_sharing_itr1.lm <- lm(cnt ~ season + atemp + yr + holiday + weekday + weathersit*hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_itr1.lm)

#holiday*weekday
#Bike_sharing_itr2.lm <- lm(cnt ~ season + atemp + yr + holiday*weekday + weathersit + hum + windspeed, data= Bike_sharing)
#summary(Bike_sharing_itr2.lm)

#windspeed*weathersit
#Bike_sharing_itr3.lm <- lm(cnt ~ season + atemp + yr + holiday + weekday + windspeed*weathersit + hum, data= Bike_sharing)
#summary(Bike_sharing_itr3.lm)

#yr*season
#Bike_sharing_itr4.lm <- lm(cnt ~ atemp + yr*season + holiday + weekday + windspeed + weathersit + hum, data= Bike_sharing)
#summary(Bike_sharing_itr4.lm)

#season*windspeed
#not significant
#Bike_sharing_itr5.lm <- lm(cnt ~ atemp + yr + holiday + weekday + weathersit + hum + season*windspeed, data= Bike_sharing)
#summary(Bike_sharing_itr5.lm)








