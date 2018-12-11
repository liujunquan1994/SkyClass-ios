
//
//  ChatViewController.m
//  skyclass
//
//  Created by skyclass on 15/5/13.
//
//

#import "ChatViewController.h"
#import "TableViewCell.h"
@interface ChatViewController ()
@end

@implementation ChatViewController
@synthesize data = _data;
NSString *  dlr;
NSString * alr;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //httppost地址设置
    NSURL *url = [NSURL URLWithString:@"http://202.117.16.98/log.php?type=day&id=001"];
    
    //httppost创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    //httppost设置参数
    
    
    //NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    //[request setHTTPBody:data];
    
    //httppost连接服务器
    NSData * receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//等待返回参数
    NSString *str1 = [[NSString alloc]initWithData:receive encoding:NSUTF8StringEncoding];
    NSLog(@"返回%@",str1);
    

    // Do any additional setup after loading the view.
    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    dlr = @"排名第4";
    alr = @"排名第5";
    _data = [NSDictionary dictionaryWithObjectsAndKeys:ary1,@"weeklearntime" ,ary,@"daycourselearntime",dlr,@"daylearntimerank",alr,@"alllearntimerank",nil];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return section?2:4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSInteger sectionNo = indexPath.section;
    if (sectionNo ==0 || sectionNo == 1) {
        static NSString *cellIdentifier = @"TableViewCell";
        
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] firstObject];
        }
        [cell configUI:indexPath data: _data ];
        return cell;
    }else if(sectionNo == 2){
        NSString * cellIdentifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
        UILabel * label = [(UILabel *) cell viewWithTag:1];
        label.text =dlr;
        return cell;
        
    }else{
    
        NSString * cellIdentifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath ];
        UILabel * label = [(UILabel *) cell viewWithTag:1];
        label.text =alr;
        return cell;

    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return 170;
    if (indexPath.section ==0) {
        return 170;
    }else if (indexPath.section == 1)
    {
        return 170;
    }else if(indexPath.section == 2)
    {
        return 50;
    }else if(indexPath.section == 3)
    {
        return 50;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 50);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    //label.text = section ? @"Bar":@"Line";
    if (section ==0) {
        label.text = @"所有课程学习进度";
    }else if (section == 1)
    {
        label.text = @"一周内每天学习时长";
    }else if(section == 2)
    {
        label.text = @"每天学习时长排名";
    }else if(section == 3)
    {
        label.text = @"总学习时长排名";
    }
    label.textColor = [UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
