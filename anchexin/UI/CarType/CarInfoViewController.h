//
//  CarInfoViewController.h
//  anchexin
//
//  Created by cgx on 14-12-23.
//
//

#import "BaseViewController.h"
#import "ChangeStateServiceViewController.h"

@interface CarInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *carTableView;
    NSArray *carInfoArray;
    NSArray *carNumArray;
    
    NSMutableArray *carInfoContentArray;
    UIView *orderView;
    
    NSString *carId;//车辆的id
}

@property(nonatomic,assign)BOOL flag;

@property(nonatomic,retain)NSDictionary *carInfo;

@end
