//
//  Station2Cell.h
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import <UIKit/UIKit.h>

@interface Station2Cell : UITableViewCell
{
    IBOutlet UIButton *zhibaoBtn;
    IBOutlet UILabel *shopDesLabel;
    IBOutlet UILabel *shopDesLabel1;
    IBOutlet UILabel *shopDesLabel2;
    
    IBOutlet UIView *scoreView;
    IBOutlet UIView *layerView;
    
    IBOutlet UIImageView *jishuImg;
    IBOutlet UILabel *jishuLabel;
    IBOutlet UIImageView *yingjianImg;
    IBOutlet UILabel *yingjianLabel;
    IBOutlet UIImageView *mendianImg;
    IBOutlet UILabel *mendianLabel;
    IBOutlet UIImageView *fuwuImg;
    IBOutlet UILabel *fuwuLabel;
  
}
@property(nonatomic,retain)UIView *layerView;

@property(nonatomic,retain)UIButton *zhibaoBtn;
@property(nonatomic,retain)UILabel *shopDesLabel;
@property(nonatomic,retain)UILabel *shopDesLabel1;
@property(nonatomic,retain)UILabel *shopDesLabel2;
@property(nonatomic,retain)UIView *scoreView;
@property(nonatomic,retain)UIImageView *jishuImg;
@property(nonatomic,retain)UILabel *jishuLabel;
@property(nonatomic,retain)UIImageView *yingjianImg;
@property(nonatomic,retain)UILabel *yingjianLabel;
@property(nonatomic,retain)UIImageView *mendianImg;
@property(nonatomic,retain)UILabel *mendianLabel;
@property(nonatomic,retain)UIImageView *fuwuImg;
@property(nonatomic,retain)UILabel *fuwuLabel;

@end
