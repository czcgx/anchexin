//
//  ActivityViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "ActivitiyCell.h"
#import "ActivitiyInfoViewController.h"

@interface ActivityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ACNavBarDrawerDelegate>
{
    UITextField *txt1;
    UITextField *txt2;
    
    UITableView *activityTableView;
    
    NSArray *requestArray;
    
    int requestTimes;
    
    ACNavBarDrawer *_drawerView;
    
}

@end
