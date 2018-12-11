//
//  calculateLearnProgress.m
//  skyclass
//
//  Created by yunhuihuang on 16/3/17.
//
//

#import "calculateLearnProgress.h"

@implementation calculateLearnProgress
-(NSString *)reminderLearnProgressWithTotalCreditHour:(long )totalCreditHor withSumCreditHour:(long )sumCrediHour withGradutelowlimDays:(long )graduatelowlimDays withGraduatehighlimDays:(long )graduatehighlimDays withStudyDays:(long)studyDays
{
    NSInteger  progress = 1;
    NSInteger studySpeed = 0;
    NSInteger totalSpeed;
    NSInteger overSpeed;
    NSString * reminder = [[NSString alloc]init];
    if (totalCreditHor >= sumCrediHour) {
        progress = 100;
        reminder = @"你已完成教学计划规定总学分";
    }else{
    
        if (graduatehighlimDays < studyDays) {
            reminder = @"你的学习已经结束!";
            if (totalCreditHor > sumCrediHour) {
                progress = 100;
            }else{
            
                if (sumCrediHour != 0) {
                    progress = totalCreditHor/sumCrediHour;
                }else{
                
                    progress = 1;
                }
            }
        }else if (graduatelowlimDays < studyDays){
            
            reminder = @"学习进度已落后，请加油!";
            if (totalCreditHor > sumCrediHour) {
                progress = 100;
            }else{
            
                if (sumCrediHour != 0) {
                    progress = totalCreditHor * 100 / sumCrediHour;
                }else{
                
                    progress = 1;
                }
                
            }
            
        }else{
        
            if (totalCreditHor == 0) {
                reminder = @"欢迎选课学习！";
            }else{
            
                if (totalCreditHor > sumCrediHour) {
                    progress = 100;
                }else{
                
                    if (sumCrediHour != 0) {
                        progress = totalCreditHor *100 / sumCrediHour;
                    }else{
                    
                        progress = 1;
                    }
                }
                if (graduatelowlimDays != 0) {
                    studySpeed = totalCreditHor *1000 /graduatelowlimDays;
                }else{
                
                    studyDays = 0;
                }
                if (graduatelowlimDays != 0) {
                    totalSpeed = sumCrediHour *1000 / studyDays;
                }else{
                
                    totalSpeed = 1;
                }
                overSpeed = (studySpeed - totalSpeed) * 100 / totalSpeed;
                if (overSpeed == 0) {
                    reminder = @"学习进度不错，继续保持！";
                }else if(overSpeed <50){
                
                    reminder = @"学习进度很好，继续保持";
                }else if (overSpeed >= 50){
                
                    reminder = @"学习进度非常好，继续保持！";
                }else if(overSpeed > -50 && overSpeed < 0){
                    
                    reminder = @"学习进度已落后，请加油！";
                }else if(overSpeed >-100 && overSpeed <=-50){
                
                    reminder = @"学习进度落后很多，请抓紧时间学习！";
                }else if(totalSpeed == 0 || studySpeed == 0){
                
                    reminder = @"欢迎选课学习！";
                }
                
            }
            
        }
    }
    return  reminder;
}
@end
