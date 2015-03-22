//
//  AFJSONFactory.h
//  PrivateTao
//
//  Created by cgx on 14-5-17.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONKit.h"

//返回json格式的数据
@protocol JSONDataReturnDelegate <NSObject>

-(void)JSONSuccess:(id)responseObject;//返回成功json
-(void)JSONError:(NSError *)error;    //返回错误json


@end

@interface AFJSONFactory : NSObject
{
    
    id<JSONDataReturnDelegate> delegate;
    
}
@property(nonatomic,retain)id<JSONDataReturnDelegate> delegate;

//类
-(void)getJSONDataByParam:(NSDictionary *)params action:(NSString *)action;


//测试
-(void)test:(NSString *)param1 action:(NSString *)action;


//获取违章支持的省份
-(void)getProvinceList:(NSString *)action;

//根据省份获取城市列表
-(void)getCityList:(NSString *)province action:(NSString *)action;

-(void)query:(NSString *)city hphm:(NSString *)hphm hpzl:(NSString *)hpzl engineno:(NSString *)engineno classno:(NSString *)classno action:(NSString *)action;


//根据区域获取相关地区维修店列表
-(void)get_getRepairStationList:(NSString *)currentpage city:(NSString *)city area:(NSString *)area type:(NSString *)type lng:(NSString *)lng lat:(NSString *)lat action:(NSString *)action;


//获取省列表
-(void)getCityList:(NSString *)action;

//获取区域列表
-(void)getAreaList:(NSString *)city action:(NSString *)action;

//根据排序获取相关地区维修店列表
-(void)get_getRepairStationOrderList:(NSString *)currentpage city:(NSString *)city area:(NSString *)area order:(NSString *)order lng:(NSString *)lng lat:(NSString *)lat state:(int)state action:(NSString *)action;

//搜索维修站
-(void)getRepairStationListBySearch:(NSString *)currentpage name:(NSString *)name lat:(NSString *)lat lng:(NSString *)lng action:(NSString *)action;



#pragma-
#pragma-首页接口
//首页机油
-(void)oil:(NSString *)lat lng:(NSString *)lng action:(NSString *)action;

//首页天气
-(void)weather:(NSString *)lat lng:(NSString *)lng action:(NSString *)action;


#pragma -
#pragma -车型
//获取车型品牌列表
-(void)get_getCarBrandList:(NSString *)action;
//获取某个品牌列表
-(void)get_getCarSeriesListByBrand:(NSString *)brandid action:(NSString *)action;
//获取车辆年份列表
-(void)get_getYearListBySeries:(NSString *)seriesid action:(NSString *)action;
//获取根据车系和车辆年份列表
-(void)get_getCarModelListBySeriesAndYear:(NSString *)seriesid year:(NSString *)year action:(NSString *)action;

//设置车型信息
-(void)setCarType:(NSString *)brandname carId:(NSString *)carId brandId:(NSString *)brandId carmodelid:(NSString *)carmodelid series:(NSString *)series action:(NSString *)action;

//创建健康卡
-(void)set_addHealthCard:(NSString *)car currentMileage:(NSString *)currentMileage buyTime:(NSString *)buyTime lastMaintainTime:(NSString *)lastMaintainTime lastCurrentMileage:(NSString *)lastCurrentMileage checkItemList:(NSString *)checkItemList licenseNumber:(NSString *)licenseNumber action:(NSString *)action;

#pragma -
#pragma -账户
//登录接口
-(void)get_login:(NSString *)mobile secret:(NSString *)secret action:(NSString *)action;


//获取待办服务信息
-(void)get_getServiceToDo:(NSString *)car action:(NSString *)action;

//获取保养卡信息
-(void)get_getMaintainInfo:(NSString *)car action:(NSString *)action;

//获取维修记录信息
-(void)get_getRepairOrder:(NSString *)car action:(NSString *)action;

//更新保养卡记录
-(void)get_updateMaintainInfo:(NSString *)car checkItem:(NSString *)checkItem mileage:(NSString *)mileage period:(NSString *)period op:(NSString *)op action:(NSString *)action;


//修改车辆里程
-(void)setCarCurrentMileage:(NSString *)car currentMileage:(NSString *)currentMileage action:(NSString *)action;


//获取验证码
-(void)getSecret:(NSString *)mobile action:(NSString *)action;

//获取提醒列表
-(void)getNoticeList:(NSString *)car type:(NSString *)type action:(NSString *)action;


//获取车辆列表
-(void)getCarList:(NSString *)action;

//查询预约工单
-(void)getRequestList:(NSString *)user statusList:(NSString *)statusList token:(NSString *)token action:(NSString *)action;

//已经领取到优惠券列表
-(void)getActivity:(NSString *)action;

//获取优惠券列表
//-(void)searchActivity:(NSString *)city item:(NSString *)item action:(NSString *)action;

//获取优惠活动详细页面
//-(void)getActivityDetail:(NSString *)activity action:(NSString *)action;

//修改绑定手机
-(void)set_setMobileNumber:(NSString *)mobilenumber action:(NSString *)action;

//获取手机号验证码
-(void)get_checksecret:(NSString *)mobilenumber secret:(NSString *)secret action:(NSString *)action;

//修改密码
-(void)set_setPassword:(NSString *)oldpassword newpassword:(NSString *)newpassword action:(NSString *)action;

//新注册接口
-(void)newRegister:(NSString *)loginPassword mobile:(NSString *)mobile secret:(NSString *)secret action:(NSString *)action;

//维修站详细信息
-(void)getNewServiceListByStation:(NSString *)station action:(NSString *)action;

//获取维修店评论列表
-(void)get_getRepairStationCommentList:(NSString *)stationid currentpage:(NSString *)currentpage action:(NSString *)action;

//获取服务预约列表
-(void)getServiceList:(NSString *)car action:(NSString *)action;

//首页的健康检查
-(void)get_healthCheck:(NSString *)car action:(NSString *)action;

//提交预约
-(void)addRequest:(NSString *)contact mobile:(NSString *)mobile  startTime:(NSString *)startTime serviceList:(NSString *)serviceList station:(NSString *)station car:(NSString *)car description:(NSString *)description token:(NSString *)token action:(NSString *)action;

//获取维修站图片列表
-(void)get_getRepairStationImage:(NSString *)stationid action:(NSString *)action;

//发表评论内容
-(void)set_setRepairStationComment:(NSString *)stationid userid:(NSString *)userid content:(NSString *)content satisfaction:(NSString *)satisfaction action:(NSString *)action;
//修改车牌号
-(void)setLicenseNumberByCar:(NSString *)car licenseNumber:(NSString *)licenseNumber action:(NSString *)action;

//切换车辆
-(void)changeCarToValid:(NSString *)carid action:(NSString *)action;

//年检
-(void)changeInspectDate:(NSString *)inspectDate car:(NSString *)car action:(NSString *)action;

//保险
-(void)changeInsuranceDate:(NSString *)insuranceDate car:(NSString *)car action:(NSString *)action;

//忘记密码接口
-(void)forgetPassword:(NSString *)mobile secret:(NSString *)secret action:(NSString *)action;

//意见反馈
-(void)addUserAdvice:(NSString *)content action:(NSString *)action;

//是否收藏店铺
-(void)collectStation:(NSString *)op station:(NSString *)station action:(NSString *)action;


//获取收藏的维修站列表
-(void)getUserCollectionList:(NSString *)page pageSize:(NSString *)pageSize action:(NSString *)action;

//获取所有活动接口（新增）
-(void)getActivityList:(NSString *)page pageSize:(NSString *)pageSize lng:(NSString *)lng lat:(NSString *)lat action:(NSString *)action;

-(void)searchActivityList:(NSString *)page pageSize:(NSString *)pageSize title:(NSString *)title action:(NSString *)action;


//查询所有认证点列表
-(void)getListByLocation:(NSString *)lat lng:(NSString *)lng action:(NSString *)action;

//获取用户领取的活动
-(void)getActivityListHaveReceived:(NSString *)page pageSize:(NSString *)pageSize action:(NSString *)action;

//根据标签搜索活动
-(void)getActivityListByTag:(NSString *)page pageSize:(NSString *)pageSize tag:(NSString *)tag lng:(NSString *)lng lat:(NSString *)lat action:(NSString *)action;

//确认支付订单
-(void)addOrder:(NSString *)station serviceList:(NSString *)serviceList paySource:(NSString *)paySource action:(NSString *)action;

//获取已支付列表
-(void)getOrderList:(NSString *)payStatusList page:(NSString *)page pageSize:(NSString *)pageSize action:(NSString *)action;

//获取维修站下的活动
-(void)getActivityListByStation:(NSString *)page pageSize:(NSString *)pageSize station:(NSString *)station action:(NSString *)action;

//违章查询历史接口
-(void)queryHistory:(NSString *)user action:(NSString *)action;

//从活动中下订单
-(void)addOrderByActivity:(NSString *)activity paySource:(NSString *)paySource action:(NSString *)action;

@end
