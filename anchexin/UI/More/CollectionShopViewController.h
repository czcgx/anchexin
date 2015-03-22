//
//  CollectionShopViewController.h
//  anchexin
//
//  Created by cgx on 14-10-22.
//
//

#import "BaseViewController.h"

@interface CollectionShopViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *collectTableView;
    int pageIndex;
    
    NSMutableArray *addArray;
    
}

@end
