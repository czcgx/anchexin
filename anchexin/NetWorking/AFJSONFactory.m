//
//  AFJSONFactory.m
//  PrivateTao
//
//  Created by cgx on 14-5-17.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "AFJSONFactory.h"


static NSString * const AFBaseURLString = @"http://apiv200.anchexin.com/";

@implementation AFJSONFactory
@synthesize delegate;


//特殊字符编码转换
-(NSString *)encodeURL:(NSString *)unescapedString
{
    NSString *escapedUrlString= (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)unescapedString, NULL,(CFStringRef)@"!*'();:@+$,/?%#[]",kCFStringEncodingUTF8));//!*'();:@&=+$,/?%#[]
    
    return escapedUrlString;
}

//类
-(void)getJSONDataByParam:(NSDictionary *)params action:(NSString *)action
{
    //NSLog(@"jsonParam::%@",params);

    //1.管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.0 设置请求格式
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //2.1 设置返回数据类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //先实例化一下
    
    //3.发起请求
    [manager POST:[NSString stringWithFormat:@"%@%@",AFBaseURLString,action]
             parameters:params
             success: ^(AFHTTPRequestOperation *operation, id responseObject)
            {
               //NSLog(@"success=>%@", responseObject);
                if ([delegate respondsToSelector:@selector(JSONSuccess:)])
                {
                    [delegate JSONSuccess:responseObject];
                }
            }
            failure: ^(AFHTTPRequestOperation *operation, NSError *error)
            {
                //NSLog(@"error=>%@", error);
                if ([delegate respondsToSelector:@selector(JSONError:)])
                {
                    [delegate JSONError:error];
                    
                }
            }];
    
}


//获取违章支持的省份
-(void)getProvinceList:(NSString *)action
{
    [self getJSONDataByParam:nil action:action];
}
//根据省份获取城市列表
-(void)getCityList:(NSString *)province action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:province forKey:@"province"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//查询违章接口//{"city":"SH","hphm":"沪A520F9","hpzl":"02","engineno":"093470251","classno":""}
///api/weizhang/query
-(void)query:(NSString *)city hphm:(NSString *)hphm hpzl:(NSString *)hpzl engineno:(NSString *)engineno classno:(NSString *)classno action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:hphm forKey:@"hphm"];
    [bodyDic setObject:hpzl forKey:@"hpzl"];
    [bodyDic setObject:engineno forKey:@"engineno"];
    [bodyDic setObject:classno forKey:@"classno"];
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

#pragma -
#pragma -维修站列表
//根据区域获取相关地区维修店列表
-(void)get_getRepairStationList:(NSString *)currentpage city:(NSString *)city area:(NSString *)area type:(NSString *)type lng:(NSString *)lng lat:(NSString *)lat action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:currentpage forKey:@"currentpage"];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:area forKey:@"area"];
    [bodyDic setObject:type forKey:@"type"];
    [bodyDic setObject:lng forKey:@"lng"];
    [bodyDic setObject:lat forKey:@"lat"];
    
    [self getJSONDataByParam:bodyDic action:action];
}

//获取城市列表
-(void)getCityList:(NSString *)action
{
    [self getJSONDataByParam:nil action:action];
    
}

//获取区域列表
-(void)getAreaList:(NSString *)city action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:city forKey:@"city"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//根据排序获取相关地区维修店列表
-(void)get_getRepairStationOrderList:(NSString *)currentpage city:(NSString *)city area:(NSString *)area order:(NSString *)order lng:(NSString *)lng lat:(NSString *)lat action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:currentpage forKey:@"currentpage"];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:area forKey:@"area"];
    [bodyDic setObject:order forKey:@"order"];
    [bodyDic setObject:lng forKey:@"lng"];
    [bodyDic setObject:lat forKey:@"lat"];
    
    [self getJSONDataByParam:bodyDic action:action];
}

//搜索维修站
-(void)getRepairStationListBySearch:(NSString *)currentpage name:(NSString *)name lat:(NSString *)lat lng:(NSString *)lng action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:currentpage forKey:@"currentpage"];
    [bodyDic setObject:name forKey:@"name"];
    [bodyDic setObject:lat forKey:@"lat"];
    [bodyDic setObject:lng forKey:@"lng"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//首页天气
-(void)weather:(NSString *)lat lng:(NSString *)lng action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:lat forKey:@"lat"];
    [bodyDic setObject:lng forKey:@"lng"];
    
    [self getJSONDataByParam:bodyDic action:action];
}

//首页机油
-(void)oil:(NSString *)lat lng:(NSString *)lng action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:lat forKey:@"lat"];
    [bodyDic setObject:lng forKey:@"lng"];
    
    [self getJSONDataByParam:bodyDic action:action];
}


#pragma -
#pragma -车型
//获取车型品牌列表
-(void)get_getCarBrandList:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}

//获取某个品牌列表
-(void)get_getCarSeriesListByBrand:(NSString *)brandid action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:brandid forKey:@"brandid"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}

//获取车辆年份列表
-(void)get_getYearListBySeries:(NSString *)seriesid action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:seriesid forKey:@"seriesid"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}

//获取根据车系和车辆年份列表
-(void)get_getCarModelListBySeriesAndYear:(NSString *)seriesid year:(NSString *)year action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:seriesid forKey:@"seriesid"];
    [bodyDic setObject:year forKey:@"year"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}

//设置车型信息
-(void)setCarType:(NSString *)brandname carId:(NSString *)carId brandId:(NSString *)brandId carmodelid:(NSString *)carmodelid series:(NSString *)series action:(NSString *)action
{
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:brandname forKey:@"carname"];
    [bodyDic setObject:carId forKey:@"car"];
    [bodyDic setObject:brandId forKey:@"brandId"];
    [bodyDic setObject:carmodelid forKey:@"carmodelid"];
    [bodyDic setObject:series forKey:@"series"];
    
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userId"];//获取userid
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    
    
    [self getJSONDataByParam:bodyDic action:action];
}


//创建健康卡
-(void)set_addHealthCard:(NSString *)car currentMileage:(NSString *)currentMileage buyTime:(NSString *)buyTime lastMaintainTime:(NSString *)lastMaintainTime lastCurrentMileage:(NSString *)lastCurrentMileage checkItemList:(NSString *)checkItemList licenseNumber:(NSString *)licenseNumber action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:currentMileage forKey:@"currentMileage"];
    [bodyDic setObject:buyTime forKey:@"buyTime"];
    [bodyDic setObject:lastMaintainTime forKey:@"lastMaintainTime"];
    [bodyDic setObject:lastCurrentMileage forKey:@"lastCurrentMileage"];
    [bodyDic setObject:checkItemList forKey:@"checkItemList"];
    [bodyDic setObject:licenseNumber forKey:@"licenseNumber"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}


#pragma -
#pragma -账户
//登录接口
-(void)get_login:(NSString *)loginname loginpwd:(NSString *)loginpwd action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:loginname forKey:@"username"];
    [bodyDic setObject:loginpwd forKey:@"userpwd"];
    [bodyDic setObject:@"" forKey:@"city"];

    [self getJSONDataByParam:bodyDic action:action];
    
}

//测试账户
-(void)test:(NSString *)param1 action:(NSString *)action
{
    
    [self getJSONDataByParam:nil action:action];
}


#pragma -
#pragma -保养卡接口

//获取待办服务信息
-(void)get_getServiceToDo:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}


//获取保养卡信息
-(void)get_getMaintainInfo:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取维修记录信息
-(void)get_getRepairOrder:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    //[bodyDic setObject:@"1" forKey:@"isVip"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//更新保养卡记录
-(void)get_updateMaintainInfo:(NSString *)car checkItem:(NSString *)checkItem mileage:(NSString *)mileage period:(NSString *)period op:(NSString *)op action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:checkItem forKey:@"checkItem"];
    [bodyDic setObject:mileage forKey:@"mileage"];
    [bodyDic setObject:period forKey:@"period"];
    [bodyDic setObject:op forKey:@"op"];
    
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}


//修改车辆里程
-(void)setCarCurrentMileage:(NSString *)car currentMileage:(NSString *)currentMileage action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:currentMileage forKey:@"currentMileage"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
    
}

//获取验证码
-(void)getSecret:(NSString *)mobile action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];
    
    [self getJSONDataByParam:bodyDic action:action];
}


//获取提醒列表
-(void)getNoticeList:(NSString *)car type:(NSString *)type action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:type forKey:@"type"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取车辆列表
-(void)getCarList:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//查询预约工单
-(void)getRequestList:(NSString *)user statusList:(NSString *)statusList token:(NSString *)token action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:statusList forKey:@"statusList"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//已经领取到优惠券列表
-(void)getActivity:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}


//获取优惠券列表
-(void)searchActivity:(NSString *)city item:(NSString *)item action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:item forKey:@"item"];
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];
  
    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取优惠活动详细页面
-(void)getActivityDetail:(NSString *)activity action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];
    [bodyDic setObject:activity forKey:@"activity"];
    
    [self getJSONDataByParam:bodyDic action:action];
}

//修改绑定手机
-(void)set_setMobileNumber:(NSString *)mobilenumber action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];

    [bodyDic setObject:mobilenumber forKey:@"mobilenumber"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];

    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取手机号验证码
-(void)get_checksecret:(NSString *)mobilenumber secret:(NSString *)secret action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobilenumber forKey:@"mobilenumber"];
    [bodyDic setObject:secret forKey:@"secret"];
    
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
}

//修改密码
-(void)set_setPassword:(NSString *)oldpassword newpassword:(NSString *)newpassword action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];

    [bodyDic setObject:oldpassword forKey:@"oldpassword"];
    [bodyDic setObject:newpassword forKey:@"newpassword"];
    
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];
   
    [self getJSONDataByParam:bodyDic action:action];
}

//新注册接口
-(void)newRegister:(NSString *)loginPassword mobile:(NSString *)mobile secret:(NSString *)secret action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setObject:loginPassword forKey:@"loginPassword"];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:secret forKey:@"secret"];
   
    
    [self getJSONDataByParam:bodyDic action:action];

}

//忘记密码接口
-(void)forgetPassword:(NSString *)mobile secret:(NSString *)secret action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:secret forKey:@"secret"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//维修站详细信息
-(void)getNewServiceListByStation:(NSString *)station action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:station forKey:@"station"];
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取维修店评论列表
-(void)get_getRepairStationCommentList:(NSString *)stationid currentpage:(NSString *)currentpage action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:stationid forKey:@"stationid"];
    [bodyDic setObject:currentpage forKey:@"currentpage"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//获取服务预约列表
-(void)getServiceList:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//首页的健康检查
-(void)get_healthCheck:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid

    [self getJSONDataByParam:bodyDic action:action];
    
}


//提交预约
-(void)addRequest:(NSString *)contact mobile:(NSString *)mobile  startTime:(NSString *)startTime serviceIds:(NSString *)serviceIds station:(NSString *)station car:(NSString *)car description:(NSString *)description token:(NSString *)token action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:contact forKey:@"contact"];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:startTime forKey:@"startTime"];
    [bodyDic setObject:serviceIds forKey:@"serviceIds"];
    [bodyDic setObject:station forKey:@"station"];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:description forKey:@"description"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    
    [self getJSONDataByParam:bodyDic action:action];
    
}


//获取维修站图片列表
-(void)get_getRepairStationImage:(NSString *)stationid action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:stationid forKey:@"stationid"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"userid"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}




//发表评论内容
-(void)set_setRepairStationComment:(NSString *)stationid userid:(NSString *)userid content:(NSString *)content satisfaction:(NSString *)satisfaction action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:stationid forKey:@"stationid"];
    [bodyDic setObject:userid forKey:@"userid"];
    [bodyDic setObject:content forKey:@"content"];
    [bodyDic setObject:satisfaction forKey:@"satisfaction"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//修改车牌号
-(void)setLicenseNumberByCar:(NSString *)car licenseNumber:(NSString *)licenseNumber action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:car forKey:@"car"];
    [bodyDic setObject:licenseNumber forKey:@"licenseNumber"];
    
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    
    [self getJSONDataByParam:bodyDic action:action];
}

//切换车辆
-(void)changeCarToValid:(NSString *)carid action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:carid forKey:@"car"];
    [bodyDic setObject:[AppDelegate setGlobal].token forKey:@"token"];//获取token
    [bodyDic setObject:[AppDelegate setGlobal].uid forKey:@"user"];//获取userid
    
    [self getJSONDataByParam:bodyDic action:action];
    
}

//年检
-(void)changeInspectDate:(NSString *)inspectDate car:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:inspectDate forKey:@"inspectDate"];
    [bodyDic setObject:car forKey:@"car"];
   
    [self getJSONDataByParam:bodyDic action:action];
}

//保险
-(void)changeInsuranceDate:(NSString *)insuranceDate car:(NSString *)car action:(NSString *)action
{
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:insuranceDate forKey:@"insuranceDate"];
    [bodyDic setObject:car forKey:@"car"];
  
    [self getJSONDataByParam:bodyDic action:action];
}
@end
