//
//  ToolLen.h
//  SuiXingPay
//
//  Created by wei peng on 12-9-13.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"//用来判断是否有网络的类

@interface ToolLen : NSObject

+(void)ShowWaitingView:(BOOL)isShow;  //加载框

+(BOOL)adujestNetwork;//判断网络

@end
