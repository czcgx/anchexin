//
//  ActivityListViewController.h
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import "BaseViewController.h"
#import "ActivitiyInfoViewController.h"

@interface ActivityListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *activityListTableView;
    NSMutableArray *activityArray;
    
    int pageIndex;
 
    NSArray *countArray;
    NSMutableArray *countFlagArray;
    
}

@property(nonatomic,assign)int type;
@property(nonatomic,retain)NSString *searchString;

@end
