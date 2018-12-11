//
//  BasicSettingViewController.h
//  skyclass
//
//  Created by skyclass_JQLIU on 2018/1/6.
//

#import <UIKit/UIKit.h>
#import "getJsonData.h"
#import "ZXCoreData.h"
#import "MBProgressHUD.h"
@interface BasicSettingViewController : UIViewController<UIAlertViewDelegate>
{
    ZXCoreData *helper;
    getJsonData *getData;
    NSString *WANIp;
    NSString *LANIp;
    MBProgressHUD *HUD;
    NSString *newsVersionUrl;
}

@property (weak, nonatomic) IBOutlet UILabel *LBAllGrade;
@property (nonatomic,copy)getJsonData *myGetData;
@property (weak, nonatomic) IBOutlet UILabel *LBGetGrade;
@property (weak, nonatomic) IBOutlet UILabel *LBPercent;
@property (weak, nonatomic) IBOutlet UIProgressView *PVPercent;
- (IBAction)tongbu:(id)sender;
- (IBAction)zhuxiao:(id)sender;
- (IBAction)about:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)shanchu:(id)sender;

@property (nonatomic,retain) NSData *receive;
@end

