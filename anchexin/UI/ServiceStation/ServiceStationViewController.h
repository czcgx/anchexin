//
//  ServiceStationViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "ServiceCell.h"
#import "New_StationInfoViewController.h"

#import "ACNavBarDrawer.h"//弹出视图

@interface ServiceStationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ACNavBarDrawerDelegate>
{
    UITableView *serviceTableView;
    
    UIView *tabView;
    UIView *tabLine;
    
    int pageIndex;//页码
    
    NSString *r_city;//城市
    NSString *r_area;//区域
    NSString *r_order;//选择方式
    
    ACNavBarDrawer *_drawerView;
    
    int requestTimes;
    
    NSMutableArray *addArray;
    NSString *order;
    
    
    
    UIView *upSubView;
    
    UITextField *searchText;
    UIImageView *searchIconImageView;
    UIView *searchView;
    BOOL searchBool;
    
    int pt;
    
}

@property(nonatomic,retain)NSString *lat;
@property(nonatomic,retain)NSString *lng;
@property(nonatomic,retain)NSArray *orderArray;
@property(nonatomic,assign)int state;

@end
