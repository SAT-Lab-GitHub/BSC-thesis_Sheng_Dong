# 模型分析
library(readr)
library(MuMIn)
library(tsDyn)
library(lme4)
library(lmerTest)
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
# A1 nursing回归分析
declare('A1 nursing回归分析', 1)
dat_select <- data.frame(model_data[c('nursing', 'treat', 'temperature_out', 'day_night', 'stage', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare('A1.0 整体', 2)
fit <- lm(nursing~treat+temperature_out+day_night, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare('A1.1 阶段I', 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(nursing~treat+temperature_out+day_night, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare('A1.2 阶段II', 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(nursing~treat+temperature_out+day_night, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare('A1.3 阶段III', 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(nursing~treat+temperature_out+day_night, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A2 foraging_suc回归分析
declare('A2 oraging_suc回归分析', 1)
dat_select <- data.frame(model_data[c('foraging_suc', 'treat', 'temperature_out', 'stage', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare('A2.0 整体', 2)
fit <- lm(foraging_suc~treat+temperature_out, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare('A2.1 阶段I', 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(foraging_suc~treat+temperature_out, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare('A2.2 阶段II', 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(foraging_suc~treat+temperature_out, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare('A2.3 阶段III', 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(foraging_suc~treat+temperature_out, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A3 foraging_pol回归分析
declare('A3 foraging_pol回归分析', 1)
dat_select <- data.frame(model_data[c('foraging_pol', 'treat', 'temperature_out', 'stage')])
dat_select <- na.omit(dat_select)
## 整体
declare("A3.0 整体", 2)
fit <- lm(foraging_pol~treat+temperature_out, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A3.1 阶段I", 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(foraging_pol~treat+temperature_out, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A3.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(foraging_pol~treat+temperature_out, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A3.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(foraging_pol~treat+temperature_out, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A4 out回归分析
declare("A4 out回归分析", 1)
dat_select <- data.frame(model_data[c('out', 'treat', 'temperature_out', 'stage')])
dat_select <- na.omit(dat_select)
## 整体
declare("A4.0 整体", 2)
fit <- lm(out~treat+temperature_out, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A4.1 阶段I", 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(out~treat+temperature_out, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A4.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(out~treat+temperature_out, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A4.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(out~treat+temperature_out, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A5 activity_nest回归分析
declare('activity_nest回归分析', 1)
dat_select <- data.frame(model_data[c('activity_nest', 'treat', 'temperature_out', 'day_night', 'stage')])
dat_select <- na.omit(dat_select)
## 整体
declare('A5.0 整体', 2)
fit <- lm(activity_nest~treat+temperature_out+day_night, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare('A5.1 阶段I', 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(activity_nest~treat+temperature_out+day_night, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare('A5.2 阶段II', 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(activity_nest~treat+temperature_out+day_night, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare('A5.3 阶段III', 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(activity_nest~treat+temperature_out+day_night, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A6 activity_forage回归分析
declare("A6 activity_forage回归分析", 1)
dat_select <- data.frame(model_data[c('activity_forage', 'treat', 'temperature_out', 'stage')])
dat_select <- na.omit(dat_select)
## 整体
declare("A6.0 整体", 2)
fit <- lm(activity_forage~treat+temperature_out, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A6.1 阶段I", 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(activity_forage~treat+temperature_out, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A6.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(activity_forage~treat+temperature_out, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A6.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(activity_forage~treat+temperature_out, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A7 nursing回归分析-昼夜周期
declare('A7 nursing回归分析-昼夜周期', 1)
dat_select <- data.frame(model_data[c('nursing', 'treat', 'temperature_out', 'day_night', 'stage', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare('A7.0 整体', 2)
fit <- lmer(nursing~temperature_out+day_night+treat*day_night+(1|box), dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare('A7.1 阶段I', 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lmer(nursing~temperature_out+day_night+treat*day_night+(1|box), dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare('A7.2 阶段II', 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lmer(nursing~temperature_out+day_night+treat*day_night+(1|box), dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare('A7.3 阶段III', 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lmer(nursing~temperature_out+day_night+treat*day_night+(1|box), dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A8 activity_nest回归分析-昼夜周期
declare('A8 activity_nest回归分析-昼夜周期', 1)
dat_select <- data.frame(model_data[c('activity_nest', 'treat', 'temperature_out', 'day_night', 'stage', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare('A8.0 整体', 2)
fit <- lmer(activity_nest~temperature_out+day_night+treat*day_night+(1|box), dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare('A8.1 阶段I', 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lmer(activity_nest~temperature_out+day_night+treat*day_night+(1|box), dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare('A8.2 阶段II', 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lmer(activity_nest~temperature_out+day_night+treat*day_night+(1|box), dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare('A8.3 阶段III', 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lmer(activity_nest~temperature_out+day_night+treat*day_night+(1|box), dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A9 brood_area回归分析
declare("A9 brood_area回归分析", 1)
dat_select <- data.frame(model_data[c('brood_area', 'time_sec', 'treat', 'temperature_out', 'stage', 'box', 'daily_consumption')])
dat_select <- na.omit(dat_select)
## 整体
fit <- lmer(brood_area~temperature_out+time_sec+treat*time_sec+(1|box), dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# temperature_in-temperature_out回归分析
declare("A10 temperature_in回归分析", 1)
dat_select <- data.frame(model_data[c('temperature_in', 'treat', 'temperature_out', 'stage', 'day_night')])
dat_select <- na.omit(dat_select)
## 整体
declare("A10.0 整体", 2)
fit <- lm(temperature_in-temperature_out~treat+temperature_out+day_night, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A10.1 阶段I", 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(temperature_in-temperature_out~treat+temperature_out+day_night, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A10.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(temperature_in-temperature_out~treat+temperature_out+day_night, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A10.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(temperature_in-temperature_out~treat+temperature_out+day_night, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# temperature_in-昼夜周期
declare("A11 temperature_in昼夜周期", 1)
dat_select <- data.frame(model_data[c('temperature_in', 'treat', 'temperature_out', 'stage', 'day_night', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare("A11.0 整体", 2)
fit <- lmer(temperature_in-temperature_out~temperature_out+day_night+treat*day_night+(1|box), dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A11.1 阶段I", 2)
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lmer(temperature_in-temperature_out~temperature_out+day_night+treat*day_night+(1|box), dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A11.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lmer(temperature_in-temperature_out~temperature_out+day_night+treat*day_night+(1|box), dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A11.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lmer(temperature_in-temperature_out~temperature_out+day_night+treat*day_night+(1|box), dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])

################################################################################
# A12 daily_consumption回归分析
declare("A12 daily_consumption回归分析", 1)
dat_select <- data.frame(model_data[c('daily_consumption', 'treat', 'temperature_out', 'stage', 'box')])
dat_select <- na.omit(dat_select)
## 整体
declare("A12.0 整体", 2)
fit <- lm(daily_consumption~treat+temperature_out, dat_select, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段I
declare("A12.1 阶段I", 2) 
dat_stage_I <- data.frame(dat_select[dat_select$stage=='I',])
fit <- lm(daily_consumption~treat+temperature_out, dat_stage_I, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段II
declare("A12.2 阶段II", 2)
dat_stage_II <- data.frame(dat_select[dat_select$stage=='II',])
fit <- lm(daily_consumption~treat+temperature_out, dat_stage_II, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])
## 阶段III
declare("A12.3 阶段III", 2)
dat_stage_III <- data.frame(dat_select[dat_select$stage=='III',])
fit <- lm(daily_consumption~treat+temperature_out, dat_stage_III, na.action=na.fail)
fit_select <- dredge(fit)
summary(get.models(fit_select, 1)[[1]])


sink()

