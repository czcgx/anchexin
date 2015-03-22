//
//  BaseViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import <UIKit/UIKit.h>
#import "AFJSONFactory.h"
#import "ToolLen.h"
#import "ReadWriteToDocument.h"
#import "MJRefresh.h" //上拉或者下提刷新

#import "UIKit+AFNetworking.h"//添加所有网络接口

@interface BaseViewController : UIViewController<JSONDataReturnDelegate,UITextFieldDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate>
{
    ReadWriteToDocument *document;
    NSDictionary *userDic;
    NSDictionary *carDic;
    NSDictionary *weatheOilDic;
    
    UIImageView *bg;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
}


//背景
-(void)skinOfBackground;
//用户自定义文本框
//alignment,－1:left,0:center,1:right
-(UILabel *)customLabel:(CGRect)frame color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font;

//用户自定义按钮
/*
 state  0:UIControlStateNormal 1:UIControlStateSelected
 
 */
-(UIButton *)customButton:(CGRect)frame tag:(int)tag title:(NSString *)title state:(int)state image:(UIImage *)image selectImage:(UIImage *)selectImage color:(UIColor *)color enable:(BOOL)enable;
//用户点击事件
-(void)customEvent:(UIButton *)sender;

//用户自定义图片视图
-(UIImageView *)customImageView:(CGRect)frame image:(UIImage *)image;

//用户自定义文本框
-(UITextField *)customTextField:(CGRect)frame placeholder:(NSString *)placeholder color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font;

-(UIView *)customView:(CGRect)frame labelTitle:(NSString *)labelTitle buttonTag:(int)buttonTag;

-(UILabel *)drawLine:(CGRect)frame drawColor:(UIColor *)drawColor;

//画横线
-(UILabel *)drawLinebg:(CGRect)frame lineColor:(UIColor *)lineColor;


-(AFJSONFactory *)JsonFactory;
-(void)JSONSuccess:(id)responseObject;


-(void)alertOnly:(NSString *)content;

-(UIBarButtonItem *)LeftBarButton;

-(void)alertNoValid;

-(void)refreshAccount;

@end
