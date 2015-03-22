//
//  New_ActivityViewController.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import "BaseViewController.h"
#import "ActivitiyCell.h"

#import "UIImageView+WebCache.h"
#import "BussinessCell.h"

@interface New_ActivityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
     UITableView *activityTableView;
     UITextField *txt;
    
     int pageIndex;
     NSMutableArray *requestArray;
    
     NSArray *scrollArray;//滚动推荐
    
    NSArray *countArray;
    NSMutableArray *countFlagArray;
    
    
}

@end
