//
//  loginViewController.h
//  Login
//
//  Created by menuz on 14-2-23.
//  Copyright (c) 2014年 menuz's lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMD5.h"
#import "getJsonData.h"
#import "ZXCoreData.h"
@interface loginViewController : UIViewController{
    ZXCoreData *helper;
}
@property (nonatomic,copy)getJsonData *myGetData;
@property (nonatomic,retain) NSData *receive;
   
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIImageView *image;

- (IBAction)Login:(id)sender;
//未公开课添加的

@property(nonatomic, strong) NSString *responseJson;

@end
