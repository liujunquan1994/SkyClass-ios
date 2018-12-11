//
//  NewsView.h
//  SkyClass
//
//  Created by skyclass on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewsView : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *title_str;
@property (weak, nonatomic) IBOutlet UIWebView *content;
-(void)getdata;
@end
