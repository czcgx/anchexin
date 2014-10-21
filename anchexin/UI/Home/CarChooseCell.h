//
//  CarChooseCell.h
//  anchexin
//
//  Created by cgx on 14-8-14.
//
//

#import <UIKit/UIKit.h>

@interface CarChooseCell : UITableViewCell
{
    IBOutlet UILabel *carNumberLabel;
    IBOutlet UIImageView *checkImageView;
    
}

@property(nonatomic,retain)UILabel *carNumberLabel;
@property(nonatomic,retain)UIImageView *checkImageView;

@end
