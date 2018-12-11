//
//  NewsList.h
//  SkyClass
//
//  Created by skyclass on 13-1-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewsList : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * des;
@property (nonatomic, retain) NSString * sid;


@end
