//
//  AccountCell.h
//  anchexin
//
//  Created by cgx on 14-8-28.
//
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *valueLabel;
    IBOutlet UIImageView *iconImageView;
    
    IBOutlet UILabel *lineLabel;
    
}

@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *valueLabel;
@property(nonatomic,retain)UIImageView *iconImageView;

@property(nonatomic,retain)UILabel *lineLabel;
@end
