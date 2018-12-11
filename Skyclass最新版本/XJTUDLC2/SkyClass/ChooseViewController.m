
//
//  ChooseViewController.m
//  skyclass
//
//  Created by skyclass on 15/10/28.
//
//

#import "ChooseViewController.h"
#import "collectionTableViewController.h"
#import "setViewController.h"
@interface ChooseViewController ()
{
    setViewController * test;
    collectionTableViewController * videoController;
    
}
@property (weak, nonatomic) IBOutlet UIView *tableView;

@end

@implementation ChooseViewController
- (IBAction)dataButton:(id)sender {
    if (test == nil) {
        test = [[setViewController alloc]init];
        [self.tableView insertSubview:test.view atIndex:0];
    }else{
        [self.tableView bringSubviewToFront:test.view];

        
    }
    
}
- (IBAction)videoButton:(id)sender {
    if (videoController ==nil) {
        videoController = [[collectionTableViewController alloc]init];
        videoController.courseCode=self.courseCode;
        videoController.courseID=self.courseID;
        videoController.courseName=self.courseName;
        videoController.courseIDToSend=self.courseIDToSend;
        [self.tableView insertSubview:videoController.view atIndex:0];
    }else{
    
        [self.tableView bringSubviewToFront:videoController];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
