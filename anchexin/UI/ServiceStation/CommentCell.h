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
    IBOutlet UIImageView *img;
    IBOutlet UILabel *commentLabel;
    
}

@property(nonatomic,retain)UIImageView *img;
@property(nonatomic,retain)UILabel *commentLabel;

@end
