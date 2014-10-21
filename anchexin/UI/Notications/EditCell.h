//
//  EditCell.h
//  anchexin
//
//  Created by cgx on 14-8-21.
//
//

#import <UIKit/UIKit.h>

@interface EditCell : UITableViewCell
{
    IBOutlet UIButton *editButton;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *valueLabel;
    
}

@property(nonatomic,retain)UIButton *editButton;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *valueLabel;

@end
