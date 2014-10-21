//
//  CityViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "CityCell.h"
#import "ChineseToPinyin.h"

@interface CityViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *cityTableView;
    
    NSMutableArray *sections;//区块
    NSMutableArray *dataSource;
    NSMutableArray *rows;//区块
    
    NSMutableArray *chooseArray;
    NSMutableArray *chooseDicArray;
    
    UILabel *requestLabel;
    
}

@end
