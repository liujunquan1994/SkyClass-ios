//
//  calculateLearnProgress.h
//  skyclass
//
//  Created by yunhuihuang on 16/3/17.
//
//

#import <Foundation/Foundation.h>

@interface calculateLearnProgress : NSObject

-(NSString *) reminderLearnProgressWithTotalCreditHour:(NSInteger *)totalCreditHor withSumCreditHour:(NSInteger *)sumCrediHour  withGradutelowlimDays: (NSInteger *)graduatelowlimDays withGraduatehighlimDays:(NSInteger *)graduatehighlimDays withStudyDays:(NSInteger *)studyDays;
@end
