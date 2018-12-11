//
//  calculateLearnProgress.h
//  skyclass
//
//  Created by yunhuihuang on 16/3/17.
//
//

#import <Foundation/Foundation.h>

@interface calculateLearnProgress : NSObject

-(NSString *)reminderLearnProgressWithTotalCreditHour:(long )totalCreditHor withSumCreditHour:(long )sumCrediHour withGradutelowlimDays:(long )graduatelowlimDays withGraduatehighlimDays:(long )graduatehighlimDays withStudyDays:(long)studyDays;
@end
