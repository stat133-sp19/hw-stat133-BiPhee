
library(dplyr)
library(ggplot2)

check_prob = function(prob){
  if (prob < 0 | prob > 1) stop("invalid prob value") else TRUE
}

check_trials = function(trials){
  if (trials < 0 | trials%%1 != 0) stop("invalid trials value") else TRUE
}

check_success = function(success, trials){
  t = rep(trials, length(success))
  if (success < trials & success%%1 == 0) TRUE else if(success > trials & success %%1 ==0) stop("success cannot be greater than trials") else stop("invalid success value")
}

#1.2
aux_mean = function(trials, prob){
  trials * prob
}

aux_variance = function (trials, prob){
  trials * prob * (1- prob)
}

aux_mode = function(trials, prob){
  (trials*prob + prob) - (trials*prob + prob) %% 1
}

aux_skewness = function(trials, prob){
  (1 - 2*prob)/((trials * prob * (1- prob))^0.5)
}

aux_kurtosis = function(trials, prob){
  (1 - 6*prob*(1-prob))/(trials*prob*(1-prob))
}

#1.3
bin_choose = function(n, k){
  if (k > n) stop('k cannot be greater than n') else factorial(n)/(factorial(k)*factorial(n-k))
}

#1.4
bin_probability = function(success, trials, prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success = success,trials =trials)
  bin_choose(n = trials, k = success) * ((prob) ^ (success)) * ((1-prob)^(trials-success))
}

#1.5
bin_distribution = function(trials, prob){
  success = 0:trials
  probability = bin_probability(success = success, trials = trials, prob = prob)
  frame <- data.frame(cbind(success, probability))
  class(frame) <- c('bindis', 'data.frame')
  frame
}

plot.bindis = function(dis){
  barplot(dis$probability, names.arg = dis$success, xlab="success", ylab= "probability")
}

#1.6
bin_cumulative = function(trials, prob){
  cumulative = 0:(trials)
  dis <- bin_distribution(trials, prob)
  for(i in 1:trials+1){cumulative[i] = sum(filter(dis, success < i)$probability)}
  cumulative[1] = dis$probability[dis$success ==0]
  result <- data.frame(cbind(dis, cumulative))
  class(result) <- c('bincum', 'data.frame')
  result
}

plot.bincum = function(dis){
  ggplot(data = dis)+
    geom_line(aes(x = success, y = cumulative))+
    labs(x = "success", y = "probability")+
    geom_point(aes(x = success, y = cumulative))+
    theme_classic()
}

#1.7
bin_variable = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return <- c(trials,prob)
  class(return) <- c('binvar')
  return(return)
}

print.binvar  = function(bin_variable){
  a <- c("- number of trials :", bin_variable[1])
  b <- c("- prob of success :", bin_variable[2])
  print("Binomial variable")
  print("
        Parameter")
  print(a)
  print(b)
}

summary.binvar = function(bin_variable){
  trials <- bin_variable[1]
  prob <- bin_variable[2]
  mean <- aux_mean(trials, prob)
  variance <- aux_variance(trials, prob)
  mode <- aux_mode(trials, prob)
  skewness <- aux_skewness(trials, prob)
  kurtosis <- aux_kurtosis(trials, prob)
  return <- c(trials, prob, mean, variance, mode, skewness, kurtosis)
  class(return) <- c('summary.binvar')
  return
}

print.summary.binvar = function(summary.binvar){
  cat('"Summary Binomial"\n\n')
  cat('"Paramaters"\n')
  print(c("- number of trials :", summary.binvar[1]))
  print(c("- prob of success :", summary.binvar[2]))
  cat('\n"Measures"\n')
  print(c("- mean :", summary.binvar[3]))
  print(c("- variance :", summary.binvar[4]))
  print(c("- mode :", summary.binvar[5]))
  print(c("- skewness :", summary.binvar[6]))
  print(c("- kurtosis :", summary.binvar[7]))
}

bin_mean = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aus_mean(trials, prob))
}

bin_variance = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aus_variance(trials, prob))
}

bin_mode = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aus_mode(trials, prob))
}

bin_skewness = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aus_skewness(trials, prob))
}
bin_kurtosis = function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aus_kurtosis(trials, prob))
}

