//
//  ChatViewController.h
//  skyclass
//
//  Created by skyclass on 15/5/13.
//
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,readwrite) NSDictionary * data;
@end
