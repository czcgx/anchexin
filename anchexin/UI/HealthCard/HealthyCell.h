//
//  HealthyCell.h
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import <UIKit/UIKit.h>

@interface HealthyCell : UITableViewCell
{
    IBOutlet UIImageView *flagImageView;//状态标志
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *stateLabel;
    IBOutlet UIImageView *checkImageView;
    IBOutlet UIButton *chooseButton;
    
}

@property(nonatomic,retain)UIImageView *flagImageView;//状态标志
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *stateLabel;
@property(nonatomic,retain)UIImageView *checkImageView;
@property(nonatomic,retain)UIButton *chooseButton;

@end
