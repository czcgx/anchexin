//
//  ModifyCell.h
//  anchexin
//
//  Created by cgx on 14-8-28.
//
//

#import <UIKit/UIKit.h>

@interface ModifyCell : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *editLabel;
    IBOutlet UILabel *lineLabel;
    
    IBOutlet UIView *sendView;
    IBOutlet UITextField *inputTextField;
    IBOutlet UIButton *sendButton;
}

@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *editLabel;
@property(nonatomic,retain)UILabel *lineLabel;
@property(nonatomic,retain)UIView *sendView;
@property(nonatomic,retain)UITextField *inputTextField;
@property(nonatomic,retain)UIButton *sendButton;

@end
