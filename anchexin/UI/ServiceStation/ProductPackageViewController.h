//
//  ProductPackageViewController.h
//  anchexin
//
//  Created by cgx on 14-12-11.
//
//

#import "BaseViewController.h"
#import "ProductPackageCell.h"


@interface ProductPackageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *productTableView;
    NSArray *productMutableArray;
    NSMutableArray *selectedArray;
    
    UILabel *totalLabel;//总价
    
}

@property(nonatomic,retain)NSDictionary *stationInfo;
@property(nonatomic,retain)NSArray *chooseArray;

@property(nonatomic,retain)NSArray *serviceListArray;
@end
