  //
//  IndexViewController.m
//  skyclass
//
//  Created by skyclass on 15/6/1.
//
//

#import "IndexViewController.h"
#import "Cell.h"
#import "OMDataService.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "VideoPlayerVC.h"
#import "calculateLearnProgress.h"
#import "SCPlayerViewController.h"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define StatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define fNavBarHeigth (IOS7==YES ? 64 : 44)

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)

@interface IndexViewController ()
{
    
    UIView *loginView;
    NSMutableArray *videoArray;
    UIPageControl *pageControl;
    UIView *headView;
    NSTimer *timer;
    int currentPage;
    UIScrollView *slideScrollView;
    NSMutableArray *headVideoArray;
    int pageSize;
    int pageIndex;
    UILabel *nameLable;
    UIButton *playBtn;
    BOOL isLoading;
    int totalCount;
    OMDataService * OMDataService;
    MBProgressHUD *HUD;
    NSString * resp;
    SCPlayerViewController *movieplayer;
    NSMutableArray *slideImages;
    NSMutableArray * slideTexts;
    NSMutableArray * slideUrl;
    NSTimer *timerPlayer;
   // MPMoviePlayerViewController *movieplayer;
    NSUserDefaults * userDefaults;


}

@end

@implementation IndexViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    float AD_height = 150;//广告栏高度
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+30);//头部
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
    userDefaults = [NSUserDefaults standardUserDefaults];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
    
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    
    /*
     ***广告栏
     */
    _headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(0, 5, fDeviceWidth, AD_height+20)];
    _headerView.backgroundColor = [UIColor blackColor];
    
    headVideoArray =[[NSMutableArray alloc] init];
    videoArray=[[NSMutableArray alloc] init];
    pageIndex = 0;
    slideImages = [[NSMutableArray alloc] init];
    slideTexts = [[NSMutableArray alloc]init];
    slideUrl = [[NSMutableArray alloc]init];
  
    [self getOpenCourseVideoData];
 
}

-(void)getOpenCourseVideoData{
    //[self showLoadingProgressWithView:self.view];
    pageIndex ++;
    NSLog(@"pageIndex:%d",pageIndex);
    if(pageIndex>1){
        pageSize =+10;
    }else{
        pageSize = 10;
    }
    //pageIndex = 2;
    [OMDataService getOpenCourseVideoListWithBlock:@"" withPageNumber:[NSString stringWithFormat:@"%d",pageIndex] withPageSize:[NSString stringWithFormat:@"%d",pageSize] withDelegate:nil withUserinfo:nil withComBlock:^(NSString * response) {
        [self handleRequestResponseData:response];
        
        NSInteger iTotalCreditHour = [[userDefaults valueForKey:@"TOTALCREDITHOUR"] integerValue];
        NSInteger iSumCreditHour = [[userDefaults valueForKey:@"SUMCREDITHOUR"] integerValue];
        NSInteger iGraduatelowlimDays = [[userDefaults valueForKey:@"GRADUATELOWLIM"] integerValue];
        NSInteger iGraduatehighlimDays = [[userDefaults valueForKey:@"GRADUATEHIGHLIM"] integerValue];
        NSInteger iStudyDays = [[userDefaults valueForKey:@"STUDYDAYS"] integerValue];
        calculateLearnProgress * remiderCalculate = [[calculateLearnProgress alloc]init];
        NSString * reminderStr = [remiderCalculate reminderLearnProgressWithTotalCreditHour:iTotalCreditHour withSumCreditHour:iSumCreditHour withGradutelowlimDays:iGraduatelowlimDays withGraduatehighlimDays:iGraduatehighlimDays withStudyDays:iStudyDays];
        
        UIAlertView *alert_success= [[UIAlertView alloc] initWithTitle:reminderStr message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert_success show];

        resp = response;
    } withFailBlock:^(void){

        [self dismissLoadingProgress];
    }];
    //NSLog(@"response:%@",response);
    isLoading = YES;
   // timer
   // [NSThread sleepForTimeInterval:5.0];
}
-(void)addPVEvetnt{
    
    NSMutableDictionary * eventargvs = [[NSMutableDictionary alloc] init];
    [eventargvs setObject:@"10100" forKey:@"titleid#2"];
   
}


-(void)handleRequestResponseData:(NSString*) response{
    
    
    [self dismissLoadingProgress];
    
    NSDictionary *dic  = [self parseSoapXmlData:response];
    
    totalCount = [[dic objectForKey:@"totalRecords"] intValue];
    isLoading = NO;
    NSArray *array = (NSArray*)[dic objectForKey:@"Data"];
    NSLog(@"array :%@",array);

    if(pageIndex == 1){
        for (int i = 0; i<[array count]; i++) {
            if(i<4){
               
                 NSLog(@"array[i] :%@",array[i]);
                [headVideoArray addObject:array[i]];
                 NSLog(@"headVideoArray :%@",headVideoArray);
                 NSLog(@"headVideoArray :%lu",(unsigned long)[headVideoArray count]);
            }else{
                [videoArray addObject:array[i]];
            }
        }
        [self initHeadView];
    }else{
        [videoArray addObjectsFromArray:array];
    }
     [self.collectionView reloadData];
}



// 解析Soap 协议 Block返回结果数据为 JSON
-(NSDictionary*)parseSoapXmlData:(NSString* )response{
    self.responseJson=@"";
    NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:responseData];
    xmlParser.delegate = self;
    BOOL parseResult = [xmlParser parse];
    if (parseResult) {
        //返回的json字符串不标准，替换其中的单引号，否则解析失败。
        //NSLog(@"=====单引号 替换前的==============%@", self.responseJson);
        self.responseJson = [self.responseJson stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        //        self.responseJson = [self.responseJson stringByReplacingOccurrencesOfString:@"\\" withString:@"\\/"];
        
        return [self processJsonStr:self.responseJson];
    }
    return nil;
}


// 解析Soap 协议 Block返回结果数据为 JSON
-(NSDictionary*)parseJsonData:(NSString* )response{
    
    return [self processJsonStr:response];
    
}


-(id)processJsonStr: (NSString *)jsonStr
{
    //是iOS 5 以后的自身的类库。
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        //NSLog(@"string 2 json error=======%@>>>>>>>>>>>jsonStr====%@", error, jsonStr);
        return nil;
    }else{
        return result;
    }
    
    //    return [[[SBJsonParser alloc] init] objectWithString:jsonStr];
}

#pragma NSXMLParserDelegate
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.responseJson = [self.responseJson stringByAppendingString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

-(void)initHeadView{
    
    
    NSLog(@"headVideoArray :%lu",(unsigned long)[headVideoArray count]);
    NSLog(@"videoArray :%lu",(unsigned long)[videoArray count]);
    for (int i =0; i<[headVideoArray count]; i++) {
        NSDictionary *dicc =headVideoArray[i];
        UIImageView *imageView = [[UIImageView alloc] init];
       CGRect rect = CGRectMake(fDeviceWidth*i,0, fDeviceWidth, 150);
       [imageView setFrame:rect];
        NSURL *url = [NSURL URLWithString:[dicc objectForKey:@"VideoPicUrl"]];
        NSLog(@"url:%@",url);
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        [imageView setImage:img];
       // [_headerView addSubview:imageView];
        NSString * text = [dicc objectForKey:@"VideoName"];
        [slideImages addObject:img];
        [slideTexts addObject:text];
        NSLog(@"-slideImages:%@",slideImages);
        NSString * urlString = [dicc objectForKey:@"VideoUrl"];
        [slideUrl addObject:urlString];
        [_headerView.scrollView addSubview:imageView];
        [imageView setTag:i];
        UITapGestureRecognizer*tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickEventOnImage:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tapRecognizer];
        

        
    }
    
    [_headerView setArray:slideImages textArray: slideTexts urlArray:slideUrl];



    
}



//-------------------------------------------------------------------------------------------
#pragma mark 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated{//显示窗口
    [super viewDidAppear:animated];
    //    [NSThread sleepForTimeInterval:3.0f];//睡眠，所有操作都不起作用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_headerView openTimer];//开启定时器
    });
}
-(void)viewWillDisappear:(BOOL)animated{//将要隐藏窗口  setModalTransitionStyle=UIModalTransitionStyleCrossDissolve时是不隐藏的，故不执行
    [super viewWillDisappear:animated];
    if (_headerView.totalNum>1) {
        [_headerView closeTimer];//关闭定时器
    }
}
#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[self getOpenCourseVideoData];
    [_headerView closeTimer];//关闭定时器
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (_headerView.totalNum>1) {
        [_headerView openTimer];//开启定时器
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"jsadglk");
    

    if(slideScrollView == scrollView){
        //     [timer setFireDate:[NSDate distantFuture]];
        int count =[headVideoArray count];
        for (int i = 0; i<count; i++) {
            //            NSLog(@"%f-------------%f",scrollView.contentOffset.x,
            //             scrollView.contentOffset.y);
            if(scrollView.contentOffset.x == 320*i){
                nameLable.text =[headVideoArray[i] objectForKey:@"VideoName"];
                pageControl.currentPage = i;
            }
        }
    }else if(scrollView == self.collectionView){
        
        //        NSLog(@"%f-------------%f",scrollView.contentOffset.x,
        //              scrollView.contentOffset.y);
        
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
         NSLog(@"y:%f,h :%f",y,h);
        float reload_distance = 10;
        if(y > h + reload_distance) {
            //NSLog(@"load more rows");
            if(!isLoading)
                if(pageIndex*10<totalCount){
                    [self getOpenCourseVideoData];
                }
        }
    }
}

//===========================================================================================

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return 30;
    return videoArray.count;

}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }

    //if (videoArray.count !=0) {
    NSDictionary * dic =videoArray[indexPath.row];
    NSLog(@"%@",[dic objectForKey:@"VideoName"]);
    // UIImage *defaultImage = [UIImage imageNamed:@"placeholder.png"];
    //  [cell.videoImageView setImage:defaultImage];
    UIImage *defaultImage = [UIImage imageNamed:@"placeholder.png"];
    [cell.imgView setImage:defaultImage];

    if(![[dic objectForKey:@"VideoPicUrl"] isEqualToString:@""]){
       
        
        [cell.imgView  setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"VideoPicUrl"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(UIImage *image) {
            [cell.imgView setImage:image];
        } failure:^(NSError *error) {
            
        }];
        cell.text.text = [dic objectForKey:@"VideoName"];

    }
        //cell.imgView.image = img;
    //cell.text.text = [NSString stringWithFormat:@"Cell %ld",(long)indexPath.row];
    
    return cell;
}

//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:_headerView];//头部广告栏
    return headerView;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2);
    //return CGSizeMake(147.0f, 100.0f);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
/*
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    NSLog(@"选择%ld",indexPath.row);
}
 */
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"collectionView");
    NSDictionary * dic =videoArray[indexPath.row];
    NSString * urlString =[dic objectForKey:@"VideoUrl"];
    //[collectionController playOnline: urlString];

    NSURL * movieUrl = [NSURL URLWithString:urlString];
    NSLog(@"movieUrl:%@",movieUrl);
   // [self playVideoWithURL: movieUrl];
   /*
    //加载播放器
    UIStoryboard * VideoPlayerStoryboard = [UIStoryboard storyboardWithName:@"VideoPlayer" bundle:nil];
    VideoPlayerVC  *videoPlayerVC = [VideoPlayerStoryboard instantiateViewControllerWithIdentifier:@"VideoPlayer"];
    videoPlayerVC.url = movieUrl;
    videoPlayerVC.isOnline = NO;
    [self presentViewController:videoPlayerVC animated:YES completion:^{
        
    }];

    */ 
    movieplayer = [ [ SCPlayerViewController alloc]initWithContentURL:movieUrl];
    movieplayer.view.transform = CGAffineTransformConcat(movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    [self presentMoviePlayerViewControllerAnimated:movieplayer];
  
    
}

-(void)ClickEventOnImage:(id)sender{
    
    int tag = [[sender view] tag];
    NSMutableDictionary  *dic = headVideoArray[tag];
    NSString * urlString =[dic objectForKey:@"VideoUrl"];
    NSURL * movieUrl = [NSURL URLWithString:urlString];
    NSLog(@"movieUrl:%@",movieUrl);
  //  [self playVideoWithURL:movieUrl];
    /*
    //加载播放器
    UIStoryboard * VideoPlayerStoryboard = [UIStoryboard storyboardWithName:@"VideoPlayer" bundle:nil];
    VideoPlayerVC  *videoPlayerVC = [VideoPlayerStoryboard instantiateViewControllerWithIdentifier:@"VideoPlayer"];
    videoPlayerVC.url = movieUrl;
    videoPlayerVC.isOnline = NO;
    [self presentViewController:videoPlayerVC animated:YES completion:^{
        
    }];
*/
    
   
    
    movieplayer = [ [ SCPlayerViewController alloc]initWithContentURL:movieUrl];
    movieplayer.view.transform = CGAffineTransformConcat(movieplayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    [self presentMoviePlayerViewControllerAnimated:movieplayer];

    
}


-(void) dismissLoadingProgress {
    
    [self.loadingHUD hide:YES afterDelay:0.1];
    self.loadingHUD = nil;
    //    NSLog(@"dismiss show loding>>>>>>>>>>>>>>>>base view");
}

-(void) showLoadingProgressWithView:(UIView *)view
{
    self.loadingHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.loadingHUD.dimBackground = NO;
    self.loadingHUD.removeFromSuperViewOnHide = YES;
}

-(void)playVideoWithURL:(NSURL *)url{
    
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}


@end


