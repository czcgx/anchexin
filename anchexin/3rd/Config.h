//
//  Config.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#ifndef anchexin_Config_h
#define anchexin_Config_h

//请求地址
#define AFBaseURLString @"http://apiv240.anchexin.com/"

//1:代表上架appsotre 0:代表安车信官网下载
#define isAppStore 1

#define anchexinVersion @"v2.4.0"

//appstore
//1：c8f69a570ddef86c86f409ea    Publish channel   回调地址：anchexinstore

//安车信－－企业版
//0:b7c34b017ccabca7fc648346  anchexin     回调地址：

#define AppScheme @"anchexinPay"

//新浪微博
#define sinaId @"1721119675"
#define sinaKey @"4424abd3ae2ec1402a3794618d2614a9"

//qq空间  http://open.qq.com
#define qqId @"100586726"
#define qqKey @"961bb15add472fc2d2e0016b31c052d4"

//微信朋友圈
#define weixinId @"wxdb5c2f69b97549c4"
#define weixinKey @"8e971b5fce8445da02eb5c5b7e4bec5d"

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




//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088611006599733"
//收款支付宝账号
#define SellerID  @"support@anchexin.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"s4msveruqexvtady1zklurid5koij9oo"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAOTU+iA4Rpygzl6jGKpw3FTgc61DCW5yIe+WIr3cKMDJLlaHrv5jYSwMBP5HzmpI6J5N0Dxm52L27megSLo6gA5GQ8h7z+Q6lrx5svaQOpeayvwwN+GwFh6UY0OmznY4PHFtU/P0Ug3KVZKiEaVpN1yz5tvBQe3LTAlIygmhc2qtAgMBAAECgYBJdCgaIZZg/qlf7YCkbXf8ctQPAN7NKivEiW/7e+lFAQ8zzXgZxnLRvcX4jbovmdm5vwah7PJHbTZX4zaVOOQTlYpNqasdbvmlnmYA93UizOLFukFJt1ZtnXJDIRClqS4jka3xPdQ3O5kJz45of6bxRfZz/WADJ4pa4p5Y1wUPQQJBAPUwRQ5mpPZTYTmlvQL7IfEa2YxJx/MeKSn2Evu88l3jGkBPD+CjT6mPMWm52Oxw0W112hxyKQ1PuOUPckyhAX0CQQDu7BIx4gYI2le1XaIjlTlN3Z2ey2gvL3ZS57/n7bFXxxV9VzclP8XCochSMxJsD+Zfq9HoIXPrvCdX/r6MNFTxAkAj3BBtf8OmpyE0HjJbqkEXkza4Ft5gh0u78FpsaQEFjD59o1KOJzRydxfh/6VjR0jJ+o+Q031/jeZb0fuEi5O9AkBwD/P8x6nS7y5iV/ebvvswxXiPqZJFR3q1KhP94aPjqvIuZwDrjLziLGW8AE5stwxz5TBAM6iechL2F/sh4c3RAkAhn7PbT9Qjo6sb8e6/qSSEQW6/EscEv77K7ymJjbwP5wFgsCVDtfTLtHyGUdeNZXs/hTShwiA9fGBxOIZ/NV8V"

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


//商户公钥




//定义通用背景颜色
#define common_bg_color 0xefeff4
#define common_line_color 0xc8c7cc
#define common_blue  0x1e93f7

#define Font_120pt 45.0
#define Font_96pt 30.0
#define Font_60pt 22.0
#define Font_48pt 15.0
#define Font_42pt 13.0
#define Font_30pt 11.0




#endif
