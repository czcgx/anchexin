//
//  CommentCell.h
//  anchexin
//
//  Created by cgx on 14-9-14.
//
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
{
    IBOutlet UIView *commentView;
    IBOutlet UILabel *commentNameLabel;
    IBOutlet UILabel *commentDateLabel;
    IBOutlet UILabel *commentContentLabel;
    
}
@property(nonatomic,retain)UIView *commentView;
@property(nonatomic,retain)UILabel *commentNameLabel;
@property(nonatomic,retain)UILabel *commentDateLabel;
@property(nonatomic,retain)UILabel *commentContentLabel;

@end
