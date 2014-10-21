//
//  RepairRecordCell.h
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import <UIKit/UIKit.h>

@interface RepairRecordCell : UITableViewCell
{
    IBOutlet UILabel *stationName;
    IBOutlet UILabel *stationItem;
    IBOutlet UILabel *stationTime;
    IBOutlet UILabel *stationPrice;
    
}

@property(nonatomic,retain)UILabel *stationName;
@property(nonatomic,retain)UILabel *stationItem;
@property(nonatomic,retain)UILabel *stationTime;
@property(nonatomic,retain)UILabel *stationPrice;

@end
