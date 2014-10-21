//
//  ManageCell.h
//  anchexin
//
//  Created by cgx on 14-9-13.
//
//

#import <UIKit/UIKit.h>

@interface ManageCell : UITableViewCell
{
    IBOutlet UILabel *carNameLabel1;
    IBOutlet UILabel *carNameLabel2;
    IBOutlet UILabel *carNumberLabel;
    IBOutlet UILabel *carSnLabel;
    IBOutlet UIButton *editButton;
    
}

@property(nonatomic,retain)UILabel *carNameLabel1;
@property(nonatomic,retain)UILabel *carNameLabel2;
@property(nonatomic,retain)UILabel *carNumberLabel;
@property(nonatomic,retain)UILabel *carSnLabel;
@property(nonatomic,retain)UIButton *editButton;

@end
