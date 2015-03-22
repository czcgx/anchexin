//
//  Station4Cell.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import <UIKit/UIKit.h>

@interface Station4Cell : UITableViewCell
{
    IBOutlet UIButton *activityBtn;
    IBOutlet UIImageView *activityIcon;
    IBOutlet UILabel *activityNameLabel;
    IBOutlet UILabel *activityDesLabel;
    IBOutlet UILabel *activityZheLabel;
    
    IBOutlet UIButton *activitySingleBtn;
    IBOutlet UIView *activityView;
    
    IBOutlet UIImageView *arrowImg;
    
}
@property(nonatomic,retain)UIButton *activityBtn;
@property(nonatomic,retain)UIImageView *activityIcon;
@property(nonatomic,retain)UILabel *activityNameLabel;
@property(nonatomic,retain)UILabel *activityDesLabel;
@property(nonatomic,retain)UILabel *activityZheLabel;

@property(nonatomic,retain)UIButton *activitySingleBtn;

@property(nonatomic,retain)UIView *activityView;
@property(nonatomic,retain)UIImageView *arrowImg;
@end
