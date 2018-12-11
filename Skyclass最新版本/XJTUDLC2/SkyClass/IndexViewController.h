//
//  IndexViewController.h
//  skyclass
//
//  Created by skyclass on 15/6/1.
//
//

#import "ViewController.h"
#import "Cell.h"
#import "MBProgressHUD.h"
#import "AdvertisingColumn.h"
#import "CollectionViewCell.h"
#import "KRVideoPlayerController.h"

@interface IndexViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    AdvertisingColumn *_headerView;

}
@property (nonatomic, strong) KRVideoPlayerController *videoController;
@property (nonatomic,strong)UICollectionView *collectionView;

//@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
//@property (weak, nonatomic) IBOutlet UIPageControl *PageController;
//@property (weak, nonatomic) IBOutlet UILabel *CourseName;
@property (strong,nonatomic)NSMutableArray *imagesName;
//@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@property(nonatomic, strong) NSString *responseJson;
@property (nonatomic, readwrite) NSUInteger index;

@property(nonatomic, strong)  MBProgressHUD *loadingHUD;
@property(nonatomic,strong) UIRefreshControl * RefreshControl;
@end
