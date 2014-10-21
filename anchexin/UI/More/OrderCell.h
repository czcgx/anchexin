//
//  OrderCell.h
//  anchexin
//
//  Created by cgx on 14-8-29.
//
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
{
    IBOutlet UIImageView *iconImageView;
    IBOutlet UILabel *shopNameLabel;
    IBOutlet UILabel *timeLabel;
    
}
@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *shopNameLabel;
@property(nonatomic,retain)UILabel *timeLabel;


@end
