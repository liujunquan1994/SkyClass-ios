//
//  TableViewCell.h
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TableViewCell : UITableViewCell

- (void)configUI:(NSIndexPath *)indexPath data: (NSDictionary *)data;
@property(nonatomic,readwrite) NSMutableArray * WeekLearnTime;
@property(nonatomic,readwrite) NSMutableArray * DayCourseLearnTime;
@property(nonatomic,readwrite) NSString *  DayLearnTimeRank;
@property(nonatomic,readwrite) NSString *  AllLearnTimeRank;

@end
