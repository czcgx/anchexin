//
//  DisscussListViewController.h
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import "BaseViewController.h"
#import "CommentCell.h"
#import "DisscussViewController.h"
@interface DisscussListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dissTableView;
    int page;
    
    NSMutableArray *dissListArray;
    
}

@property(nonatomic,retain)NSDictionary *stationInfo;

@end
