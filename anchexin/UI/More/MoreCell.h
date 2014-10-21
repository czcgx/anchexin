//
//  MoreCell.h
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import <UIKit/UIKit.h>

@interface MoreCell : UITableViewCell
{
    IBOutlet UIImageView *iconImageView;
    IBOutlet UILabel *contentLabel;
    
}

@property(nonatomic,retain)UIImageView *iconImageView;
@property(nonatomic,retain)UILabel *contentLabel;

@end
