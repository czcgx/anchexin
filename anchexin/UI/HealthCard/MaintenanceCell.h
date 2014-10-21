//
//  MaintenanceCell.h
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import <UIKit/UIKit.h>

@interface MaintenanceCell : UITableViewCell
{
    IBOutlet UILabel *maintenanceTitle;
    IBOutlet UILabel *maintenanceMonth;
    
    IBOutlet UIView *upView;
    IBOutlet UIImageView *upImageView;
    IBOutlet UIButton *upButton;
    
    IBOutlet UIView *downView;
    
}
@property(nonatomic,retain)UIView *upView;
@property(nonatomic,retain)UIImageView *upImageView;
@property(nonatomic,retain)UIButton *upButton;

@property(nonatomic,retain)UIView *downView;

@property(nonatomic,retain)UILabel *maintenanceTitle;
@property(nonatomic,retain)UILabel *maintenanceMonth;

@end
