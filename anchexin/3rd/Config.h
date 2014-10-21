//
//  Config.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#ifndef anchexin_Config_h
#define anchexin_Config_h

//判断是否iphon5的屏
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是ios7以上的系统
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define IMAGE(imagePath) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(imagePath) ofType:@"png"]]

//使用说明table.backgroundColor = kUIColorFromRGB(0xCCFFFF);
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WIDTH 320

#define BGCOLOR 0xF7F6F2
#define DARKCOLOR 0x494543

#define NavigationBar 64
#define TabBar 48

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width


#define Commonbg 0xF1F1F1       //通用背景色
#define CommonLinebg 0xd8d8d8   //通用横线的颜色


#endif
