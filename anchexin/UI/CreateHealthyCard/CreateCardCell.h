//
//  CreateCardCell.h
//  AnCheXin
//
//  Created by cgx on 13-11-11.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateCardCell : UITableViewCell
{
    IBOutlet UILabel *helloLabel;
    IBOutlet UIView *mainView;
    IBOutlet UITextField *textField;
    IBOutlet UIButton *okButton;
    
    IBOutlet UIImageView *cellBg;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *pLabel;
    IBOutlet UIImageView *inputTextFieldbg;
    
}

@property(nonatomic,retain)UILabel *helloLabel;
@property(nonatomic,retain)UIView *mainView;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UIButton *okButton;
@property(nonatomic,retain)UIImageView *cellBg;

@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *pLabel;
@property(nonatomic,retain)UIImageView *inputTextFieldbg;

@end
