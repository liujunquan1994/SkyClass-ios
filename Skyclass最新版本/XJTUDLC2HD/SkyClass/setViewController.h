//
//  setViewController.h
//  XJTUDLC
//
//  Created by skyclass on 14-3-29.
//
//

#import <UIKit/UIKit.h>
#import "getJsonData.h"
#import "ZXCoreData.h"
#import "MBProgressHUD.h"
@interface setViewController : UIViewController<UIAlertViewDelegate>
{
    ZXCoreData *helper;
    getJsonData *getData;
    NSString *WANIp;
    NSString *LANIp;
    MBProgressHUD *HUD;
    NSString *newsVersionUrl;
}

@property (weak, nonatomic) IBOutlet UILabel *LBAllGrade;

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
