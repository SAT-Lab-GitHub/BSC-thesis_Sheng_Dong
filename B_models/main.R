# 模型分析
library(readr)
library(MuMIn)
library(tsDyn)
rm(list=ls())


sink('results.txt')

model_data <- read_csv("model_data.csv")

# 定义日志输出声明函数
declare = function(txt, level){
  if (level==1){
    s = paste("\n==================================================================\n     =====", txt, '=====', collapse='')
  }else if (level==2){
    s = paste("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n     ~~~~~", txt, "~~~~~", collapse='')
  }
  else{
    s = paste('\n', txt, '\n', collapse='')
  }
  writeLines(s)
}


# 数值类型的变量归一化
for (i in 1:ncol(model_data)){
  col_name = colnames(model_data)[i]
  if(typeof(model_data[[col_name]])=='double'){
    model_data[[col_name]] <- scale(model_data[[col_name]])
  }
}

################################################################################
# B1 nursing回归分析
declare('B1 nursing回归分析', 1)
dat_select <- data.frame(model_data[c('nursing', 'treat', 'temperature_out')])
dat_select <- na.omit(dat_select)
## 整体
fit <- lm(nursing~temperature_out+treat*temperature_out+treat, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# B2 activity_nest回归分析
declare('B2 activity_nest回归分析', 1)
dat_select <- data.frame(model_data[c('activity_nest', 'treat', 'temperature_out')])
dat_select <- na.omit(dat_select)
## 整体
fit <- lm(activity_nest~temperature_out+treat*temperature_out+treat, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# B3 temperature_in回归分析
declare("temperature_in回归分析", 1)
dat_select <- data.frame(model_data[c('temperature_in', 'treat', 'temperature_out')])
dat_select <- na.omit(dat_select)
## 整体
fit <- lm(temperature_in-temperature_out~temperature_out+treat*temperature_out++treat, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])


sink()

