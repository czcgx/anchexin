//
//  ServiceCell.h
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell
{
    IBOutlet UIImageView *stationImageView;
    IBOutlet UILabel *stationNameLabel;
    IBOutlet UILabel *stationDistanceLabel;
    IBOutlet UIImageView *stationFlag;
    
    IBOutlet UILabel *orderLabel;
    
}

@property(nonatomic,retain)UIImageView *stationImageView;
@property(nonatomic,retain)UILabel *stationNameLabel;
@property(nonatomic,retain)UILabel *stationDistanceLabel;
@property(nonatomic,retain)UIImageView *stationFlag;
@property(nonatomic,retain)UILabel *orderLabel;

@end
