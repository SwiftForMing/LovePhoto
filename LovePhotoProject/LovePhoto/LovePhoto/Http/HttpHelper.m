//
//  HttpHelper.m
//  LovePhoto
//
//  Created by 黎应明 on 2019/4/2.
//  Copyright © 2019年 黎应明. All rights reserved.
//

#import "HttpHelper.h"

#import "AFNetworking.h"
#import "SecurityUtil.h"
//#import "Tool.h"
#import "RSA.h"
//#import <AlipaySDK/AlipaySDK.h>
#import "RSAEncryptor.h"
//#import "DataSigner.h"
#define httprivateKey @""

@interface HttpHelper()


@end
@implementation HttpHelper

- (void)dealloc
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

+ (instancetype)helper
{
    HttpHelper *helper = [[HttpHelper alloc] init];
    return helper;
}
#pragma mark - 拼接:URL_Server+keyURL
/**
 * 拼接:URL_Server+keyURL
 */
+ (NSString *)getURL{
    
    NSString *str =  @"";
//
//    if ([ShareManager shareInstance].isInReview == YES) {
//        str =  URL_ServerTest;
//    }
    
    return str;
}
#pragma mark - 获取版本号
/**
 * 获取版本号
 * 本地版本号 >= 服务器版本号，表示新版本正在审核阶段
 */
+ (void)getVersion:(void (^)(NSDictionary *resultDic))success
              fail:(void (^)(NSString *description))fail
{
//    NSString *URLString = [NSMutableString stringWithFormat:@"%@%@", URL_Server, URL_GetVersion];
//    [self getHttpBaseQuestWithUrl:URLString success:success fail:fail];
}

#pragma mark - 注册、登录、获取验证码、找回密码
/**
 * 获取验证码
 * type:[1.注册,2.找回密码,3.修改电话号码和微信绑定]
 */
+ (void)getVerificationCodeByMobile:(NSString *)mobile
                               type:(NSString *)type
                            success:(void (^)(NSDictionary *resultDic))success
                               fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (mobile) {
        [parameters setObject:mobile forKey:@"app_login_id"];
    }
    
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

+ (void)getConfigure:(void (^)(NSDictionary *resultDic))success
                fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //拼接:URL_Server+keyURL
    NSString *URLString = [self getURLbyKey:@"appInterface/getConfiguration.jhtml"];
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 * 注册
 */
+ (void)registerByWithMobile:(NSString *)mobile
                    password:(NSString *)password
           recommend_user_id:(NSString *)recommend_user_id
                   auth_code:(NSString *)auth_code
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (mobile) {
        [parameters setObject:mobile forKey:@"app_login_id"];
    }
    if (password) {
        [parameters setObject:password forKey:@"password"];
    }
    if (recommend_user_id) {
        [parameters setObject:recommend_user_id forKey:@"recommend_user_id"];
    }else{
        [parameters setObject:@"" forKey:@"recommend_user_id"];
    }
    if (auth_code) {
        [parameters setObject:auth_code forKey:@"auth_code"];
    }
    
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 * 手机号登录
 */
+ (void)loginByWithMobile:(NSString *)mobile
                 password:(NSString *)password
                 jpush_id:(NSString *)jpush_id
                  success:(void (^)(NSDictionary *resultDic))success
                     fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (mobile) {
        
        [parameters setObject:mobile forKey:@"app_login_id"];
    }
    if (password) {
        
        [parameters setObject:password forKey:@"password"];
    }
    if (jpush_id) {
        
        [parameters setObject:jpush_id forKey:@"jpush_id"];
    }else{
        
        [parameters setObject:@"" forKey:@"jpush_id"];
    }
    
    
#if TARGET_IPHONE_SIMULATOR
    [parameters setObject:@"iOS test" forKey:@"jpush_id"];
#endif
   
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self loginWithAbsoluteURLString:URLString parameter:parameters success:success fail:fail];
}

/**
 * 第三方登录
 * jpush_id :极光推送id(registrationId)
 * type:登陆形式[weixin,qq]
 */
+ (void)thirdloginByWithLoginId:(NSString *)app_login_id
                      nick_name:(NSString *)nick_name
                    user_header:(NSString *)user_header
                           type:(NSString *)type
                       jpush_id:(NSString *)jpush_id
                        success:(void (^)(NSDictionary *resultDic))success
                           fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (app_login_id) {
        [parameters setObject:app_login_id forKey:@"app_login_id"];
    }
    if (nick_name) {
        
        [parameters setObject:nick_name forKey:@"nick_name"];
    }else{
        [parameters setObject:@"" forKey:@"nick_name"];
    }
    
    if (user_header) {
        
        [parameters setObject:user_header forKey:@"user_header"];
    }else{
        [parameters setObject:@"" forKey:@"user_header"];
    }
    
    if (type) {
        
        [parameters setObject:type forKey:@"type"];
    }else{
        [parameters setObject:@"" forKey:@"type"];
    }
    
    if (jpush_id) {
        
        [parameters setObject:jpush_id forKey:@"jpush_id"];
    }else{
        [parameters setObject:@"" forKey:@"jpush_id"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self loginWithAbsoluteURLString:URLString parameter:parameters success:success fail:fail];
}


// 登录接口统一增加uuid， 客户编号，token保存
+ (void)loginWithAbsoluteURLString:(NSString *)absoluteURL
                         parameter:(NSMutableDictionary *)parameters
                           success:(void (^)(NSDictionary *resultDic))success
                              fail:(void (^)(NSString *description))fail
{
//    NSString *uuid = [Tool getUUID];
    NSString *uuid = @"";
    NSString *clien_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *clien_type = @"iOS";
    
    if (uuid) {
        [parameters setObject:uuid forKey:@"mac_address"];
    }
    
    if (clien_version) {
        [parameters setObject:clien_version forKey:@"clien_version"];
    }
    if (clien_type) {
        [parameters setObject:clien_type forKey:@"clien_type"];
    }
    
    [self postHttpWithDic:parameters urlStr:absoluteURL success:^(NSDictionary *resultDic) {
        
        // 保存token
        NSDictionary *data = [resultDic objectForKey:@"data"];
        if (data) {
//            NSString *token = [data objectForKey:@"token"];
//            NSString *nowTime = [data objectForKey:@"nowTime"];
//            NSInteger timeDifference = [NSDate serverTimeDifference:[nowTime longLongValue]];
//
//            [[ShareManager shareInstance] setToken:token];
//            [[ShareManager shareInstance] setServerTimeDifference:timeDifference];
//
//            // 保存登录信息
//            UserInfo *userInfo = [data objectByClass:[UserInfo class]];
//            userInfo.islogin = YES;
//            userInfo.loginPassword = [ShareManager shareInstance].userinfo.loginPassword;
//            [ShareManager shareInstance].userinfo = userInfo;
//            [Tool saveUserInfoToDB:YES];
        }
        
        success(resultDic);
        
    } fail:^(NSString *description) {
        fail(description);
    }];
}


/**
 * 找回密码
 */
+ (void)findPwdByWithMobile:(NSString *)mobile
                   password:(NSString *)password
                  auth_code:(NSString *)auth_code
                    success:(void (^)(NSDictionary *resultDic))success
                       fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (mobile) {
        [parameters setObject:mobile forKey:@"app_login_id"];
    }
    if (password) {
        [parameters setObject:password forKey:@"password"];
    }
    if (auth_code) {
        [parameters setObject:auth_code forKey:@"auth_code"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 第三方绑定
 */
+ (void)bangDingByWithLoginId:(NSString *)app_login_id
                         type:(NSString *)type
                      url_tel:(NSString *)url_tel
                    auth_code:(NSString *)auth_code
            recommend_user_id:(NSString *)recommend_user_id
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (app_login_id) {
        [parameters setObject:app_login_id forKey:@"app_login_id"];
    }
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }
    if (url_tel) {
        [parameters setObject:url_tel forKey:@"user_tel"];
    }
    if (auth_code) {
        [parameters setObject:auth_code forKey:@"auth_code"];
    }
    if (recommend_user_id) {
        [parameters setObject:recommend_user_id forKey:@"recommend_user_id"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

#pragma mark - 拼接:URL_Server+keyURL
/**
 * 拼接:URL_Server+keyURL
 */
+ (NSString *)getURLbyKey:(NSString *)URLKey{
    
//    NSString *str = [NSMutableString stringWithFormat:@"%@%@", URL_Server, URLKey];
    NSString *str = @"";

    
    
    
   
    
    return str;
}


#pragma mark - 获取分类相关数据
+(void)getSearchIDDataWithID:(NSString *)goodID
                     pageNum:(NSString *)page
                    limitNum:(NSString *)limit
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (goodID) {
        [parameters setObject:goodID forKey:@"goodsTypeId"];
    }else{
//        MLog(@"缺少参赛goodID");
    }
    if (page) {
        [parameters setObject:page forKey:@"pageNum"];
    }else{
//        MLog(@"缺少参赛page");
    }
    if (limit) {
        [parameters setObject:limit forKey:@"limitNum"];
    }else{
//        MLog(@"缺少参赛page");
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = [self getURLbyKey:@""];
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 获取关键字搜索数据
 *
 */
+(void)getSearchKeyDataWithKeyWord:(NSString *)key success:(void (^)(NSDictionary *resultDic))success
                              fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (key) {
        [parameters setObject:key forKey:@"searchKey"];
    }else{
        [parameters setObject:@"" forKey:@"searchKey"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
    
}


#pragma mark - 获取基础数据
+ (void)getHttpWithUrlStr:(NSString *)urlStr
                  success:(void (^)(NSDictionary *resultDic))success
                     fail:(void (^)(NSString *description))fail
{
    NSString *URLString = [self getURLbyKey:urlStr];
    [self getHttpBaseQuestWithUrl:URLString success:success fail:fail];
}


+ (void)getHttpBaseQuestWithUrl:(NSString *)urlstr
                        success:(void (^)(NSDictionary *resultDic))success
                           fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self postHttpWithDic:parameters urlStr:urlstr success:success fail:fail];
}


#pragma mark -  获取充值记录
/**
 * 获取充值记录
 */
+ (void)getCZRecordWithUserId:(NSString *)user_id
                      pageNum:(NSString *)pageNum
                     limitNum:(NSString *)limitNum
                         type:(NSString *)type
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    if (pageNum) {
        [parameters setObject:pageNum forKey:@"pageNum"];
    }
    if (limitNum) {
        [parameters setObject:limitNum forKey:@"limitNum"];
    }
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

#pragma mark -  充值
/**
 * 获取支付宝支付参数
 *
 */
+ (void)getZFBInfoWithOrderNo:(NSString *)out_trade_no
                    total_fee:(NSString *)total_fee
             spbill_create_ip:(NSString *)spbill_create_ip
                         body:(NSString *)body
                       detail:(NSString *)detail
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (out_trade_no) {
        [parameters setObject:out_trade_no forKey:@"out_trade_no"];
    }
    
    if (total_fee) {
        [parameters setObject:total_fee forKey:@"total_fee"];
    }
    
    if (spbill_create_ip) {
        [parameters setObject:spbill_create_ip forKey:@"spbill_create_ip"];
    }else{
        [parameters setObject:@"" forKey:@"spbill_create_ip"];
    }
    
    if (body) {
        [parameters setObject:body forKey:@"body"];
    }else{
        [parameters setObject:@"" forKey:@"body"];
    }
    
    if (detail) {
        [parameters setObject:detail forKey:@"detail"];
    }else{
        [parameters setObject:@"" forKey:@"detail"];
    }
    
    NSString *user_id = @"";
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    //    MLog(@"httphelperuser_id%@",user_id);
    
    //拼接:URL_Server+keyURLPOST alipayUnifiedorder.jhtml
    NSString *URLString = [self getURLbyKey:@"appInterface/alipayUnifiedorder.jhtml"];
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 获取weix支付参数
 *
 */
+ (void)getWXInfoWithOrderNo:(NSString *)out_trade_no
                   total_fee:(NSString *)total_fee
            spbill_create_ip:(NSString *)spbill_create_ip
                        body:(NSString *)body
                      detail:(NSString *)detail
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (out_trade_no) {
        [parameters setObject:out_trade_no forKey:@"out_trade_no"];
    }
    
    if (total_fee) {
        [parameters setObject:total_fee forKey:@"total_fee"];
    }
    
    if (spbill_create_ip) {
        [parameters setObject:spbill_create_ip forKey:@"spbill_create_ip"];
    }else{
        [parameters setObject:@"" forKey:@"spbill_create_ip"];
    }
    
    if (body) {
        [parameters setObject:body forKey:@"body"];
    }else{
        [parameters setObject:@"" forKey:@"body"];
    }
    
    if (detail) {
        [parameters setObject:detail forKey:@"detail"];
    }else{
        [parameters setObject:@"" forKey:@"detail"];
    }
    
    NSString *user_id = @"";
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
   
    
    //拼接:URL_Server+keyURLPOST alipayUnifiedorder.jhtml
    NSString *URLString = [self getURLbyKey:@"appInterface/wechatUnifiedorder.jhtml"];
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


#pragma mark - 生成预订单
// 生成预订单
+(void)getOrderWithOrderType:(NSString *)orderType
                    goods_id:(NSString *)goodID
                     buy_num:(NSString *)num
                 coupons_ids:(NSArray *)coupons_ids
                        type:(NSString *)type
                     user_id:(NSString *)user_id
              consignee_name:(NSString *)consignee_name
               consignee_tel:(NSString *)consignee_tel
           consignee_address:(NSString *)consignee_address
                      remark:(NSString *)remark
                  express_id:(NSString *)express_id
                     success:(void (^)(NSDictionary *data))success
                     failure:(void (^)(NSString *description))failure

{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (orderType) {
        [parameters setObject:orderType forKey:@"orderType"];
    }else{
       
        return;
    }
    
    if (goodID) {
        [parameters setObject:goodID forKey:@"goods_id"];
    }else{
       
        return;
    }
    
    if (num) {
        [parameters setObject:num forKey:@"buy_num"];
    }else{
       
        return;
    }
    
    if (coupons_ids.count>0) {
        NSArray * array= coupons_ids;
        NSString *ns=[array componentsJoinedByString:@","];
        [parameters setObject:ns forKey:@"coupons_ids"];
    }else{
      
        [parameters setObject:@"NUL" forKey:@"coupons_ids"];
        //        return;
    }
    
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }else{
       
        return;
    }
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }else{
       
        return;
    }
    
    if (![consignee_name isEqualToString:@""]) {
        [parameters setObject:consignee_name forKey:@"consignee_name"];
    }else{
       
        [parameters setObject:@"NUL" forKey:@"consignee_name"];
        //        return;
    }
    
    if (![consignee_tel isEqualToString:@""]) {
        [parameters setObject:consignee_tel forKey:@"consignee_tel"];
    }else{
        
        [parameters setObject:@"NUL" forKey:@"consignee_tel"];
        //        return;
    }
    
    if (![consignee_address isEqualToString:@""]) {
        [parameters setObject:consignee_address forKey:@"consignee_address"];
    }else{
        
        [parameters setObject:@"NUL" forKey:@"consignee_address"];
        //        return;
    }
    
    if (![remark isEqualToString:@""] ) {
        [parameters setObject:remark forKey:@"remark"];
    }else{
       
        [parameters setObject:@"NUL" forKey:@"remark"];
        //        return;
    }
    
    if (![express_id isEqualToString:@""]) {
        [parameters setObject:express_id forKey:@"express_id"];
    }else{
       
        [parameters setObject:@"NUL" forKey:@"express_id"];
        //        return;
    }
    
    //    MLog(@"parameters%@",parameters);
    
    NSString *path = [self apiWithPathExtension:@"genOrder.jhtml"];
    
    [self postHttpWithDic:parameters urlStr:path success:success fail:failure];
    
}



#pragma mark - 获取我的订单列表

+ (void)getMyorderLisetWithUserID:(NSString *)user_id
                             type:(NSString *)type
                          pageNum:(NSString *)page
                         limitNum:(NSString *)limit
                          success:(void (^)(NSDictionary *resultDic))success
                             fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }
    if (page) {
        [parameters setObject:page forKey:@"pageNum"];
    }
    if (limit) {
        [parameters setObject:limit forKey:@"limitNum"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
    
}

#pragma mark -  修改默认地址
/**
 * 修改默认地址
 */
+ (void)changeDefaultAddressWithUserId:(NSString *)user_id
                             addressId:(NSString *)addressId
                               success:(void (^)(NSDictionary *resultDic))success
                                  fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    if (addressId) {
        [parameters setObject:addressId forKey:@"id"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 收获地址列表
 */
+ (void)receiveAddressListWithUserId:(NSString *)user_id
                             success:(void (^)(NSDictionary *resultDic))success
                                fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 *添加或修改我的收获地址
 *
 */
+ (void)addAddressWithUserId:(NSString *)user_id
                   addressId:(NSString *)addressId
                    user_tel:(NSString *)user_tel
                   user_name:(NSString *)user_name
                 province_id:(NSString *)province_id
                     city_id:(NSString *)city_id
              detail_address:(NSString *)detail_address
                  is_default:(NSString *)is_default
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    if (addressId) {
        [parameters setObject:addressId forKey:@"id"];
    }else{
        [parameters setObject:@"" forKey:@"id"];
    }
    
    if (user_tel) {
        [parameters setObject:user_tel forKey:@"user_tel"];
    }
    if (user_name) {
        [parameters setObject:user_name forKey:@"user_name"];
    }
    if (province_id) {
        [parameters setObject:province_id forKey:@"province_id"];
    }
    if (city_id) {
        [parameters setObject:city_id forKey:@"city_id"];
    }
    if (detail_address) {
        [parameters setObject:detail_address forKey:@"detail_address"];
    }
    if (is_default) {
        [parameters setObject:is_default forKey:@"is_default"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 * 获取城市列表
 */
+ (void)getCityInfoWithProvinceId:(NSString *)provinceId
                          success:(void (^)(NSDictionary *resultDic))success
                             fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (provinceId) {
        [parameters setObject:provinceId forKey:@"provinceId"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 删除地址
 */
+ (void)deleteAddressWithAddressId:(NSString *)addressId
                           success:(void (^)(NSDictionary *resultDic))success
                              fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (addressId) {
        [parameters setObject:addressId forKey:@"id"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}
#pragma mark -  获取用户信息
/**
 * 获取用户信息
 */
+ (void)getUserInfoWithUserId:(NSString *)user_id
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}



/**
 * 修改用户信息
 * fieldName:字段名称(多个请用,隔开)
 * fieldNameValue:修改后的字段值(多个请用,隔开)
 * updateFieldNameNum:修改字段数量
 */
+ (void)changeUserInfoWithUserId:(NSString *)user_id
                       fieldName:(NSString *)fieldName
                  fieldNameValue:(NSString *)fieldNameValue
              updateFieldNameNum:(NSString *)updateFieldNameNum
                         success:(void (^)(NSDictionary *resultDic))success
                            fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    if (fieldName) {
        [parameters setObject:fieldName forKey:@"fieldName"];
    }
    
    if (fieldNameValue) {
        [parameters setObject:fieldNameValue forKey:@"fieldNameValue"];
    }
    if (updateFieldNameNum) {
        [parameters setObject:updateFieldNameNum forKey:@"updateFieldNameNum"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 * Post 上传图片
 */
+ (void)postImageHttpWithImage:(UIImage*)image
                       success:(void (^)(NSDictionary *resultDic))success
                          fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSString stringWithFormat:@"%@", @""] forKey:@"id"];
    
    //当前时间戳 单位毫秒
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *requestTime = [NSString stringWithFormat:@"%lld",recordTime];
    
    [parameter setObject:requestTime forKey:@"request_time"];
    NSArray *allkeys = [parameter allKeys];
    NSString *sign = nil;
    for (NSString *mkey in allkeys)
    {
        NSObject *value = [parameter objectForKey:mkey];
        if (!sign) {
            sign = [NSString stringWithFormat:@"%@",value];
        }else{
            sign = [NSString stringWithFormat:@"%@|$|%@", sign, value];
        }
    }
//    NSString *str = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:sign publick:EncryptPublicKey]];
         NSString *str = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:sign publick:@""]];
    [parameter setObject:str forKey:@"sign"];
    
    // 登录授权验证
//    NSString *token = [[ShareManager shareInstance] token];
     NSString *token = @"";
    if (token) {
        [parameter setObject:token forKey:@"token"];
    }
    
    NSData *jsParameters = [NSJSONSerialization dataWithJSONObject:parameter  options:NSJSONWritingPrettyPrinted error:nil];
    NSString *aString = [[NSString alloc] initWithData:jsParameters encoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    NSString *jiamistr = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:aString publick:EncryptPublicKey2]];
     NSString *jiamistr = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:aString publick:@""]];
    [parameters setObject:jiamistr forKey:@"param"];
    
    AFHTTPSessionManager *om = [AFHTTPSessionManager manager];
    om.responseSerializer = [AFHTTPResponseSerializer serializer];
    om.requestSerializer.timeoutInterval = 20;
//    NSString *URLString = [self getURLbyKey:URL_UpdateImageUrl];
     NSString *URLString = [self getURLbyKey:@""];
    [om POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(image)
        {
            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"111.jpg" mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSData *data = (NSData *)responseObject;
        if ([data isKindOfClass:[NSData class]]) {
//            dict = [data objectFromJSONData];
        }
        
        if (success) {
            success((NSDictionary *)dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(@"网络请求失败了");
        }
    }];
}



/**
 * 拼接:URL_Server+keyURL
 */
+ (NSString *)apiWithPathExtension:(NSString *)pathExtension{
    
    NSString *str = [NSMutableString stringWithFormat:@"%@appInterface/%@", @"", pathExtension];
//
//    if ([ShareManager shareInstance].isInReview == YES) {
//        str = [NSMutableString stringWithFormat:@"%@appInterface/%@", URL_ServerTest, pathExtension];
//    }
    
    return str;
}



#pragma mark - 底层 post数据请求和图片上传

+ (void)postWithDictionary:(NSMutableDictionary *)parameter
                      path:(NSString *)path
                   success:(void (^)(NSDictionary *resultDictionary))success //成功
                      fail:(void (^)(NSString *description))fail      //失败
{
    [self postHttpWithDic:parameter
                   urlStr:path success:^(NSDictionary *responseObject) {
                       
                       BOOL result = NO;
                       NSString *description = @"";
                       NSDictionary *data = nil;
                       
                       if ([responseObject isKindOfClass:[NSDictionary class]]) {
                           NSDictionary *responseDict = (NSDictionary *)responseObject;
                           
                           int status = [[responseDict objectForKey:@"status"] intValue];
                           description = [responseDict objectForKey:@"desc"];
                           data = [responseDict objectForKey:@"data"];
                           
                           if (status == 0) {
                               result = YES;
                           }
                       }
                       
                       if (result) {
                           success(data);
                       } else {
                           fail(description);
                       }
                       
                   } fail:fail];
}


/**
 * Post请求数据
 */
+ (void)postHttpWithDic:(NSMutableDictionary *)parameter
                 urlStr:(NSString *)urlStr
                success:(void (^)(NSDictionary *resultDic))success //成功
                   fail:(void (^)(NSString *description))fail      //失败
{
    //当前时间戳 单位毫秒
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *requestTime = [NSString stringWithFormat:@"%lld",recordTime];
    [parameter setObject:requestTime forKey:@"request_time"];
    
    // iOS
    [parameter setObject:@"ios" forKey:@"system"];
    
    // version
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [parameter setObject:version forKey:@"version"];
    
    NSArray *allkeys = [parameter allKeys];
    NSString *sign = nil;
    for (NSString *mkey in allkeys)
    {
        NSObject *value = [parameter objectForKey:mkey];
        if (!sign) {
            sign = [NSString stringWithFormat:@"%@",value];
        }else{
            sign = [NSString stringWithFormat:@"%@|$|%@",sign,value];
        }
    }
//    MLog(@"signpost url = %@", sign);
    
//    NSString *str = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:sign publick:EncryptPublicKey]];
    NSString *str = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:sign publick:@""]];
    [parameter setObject:str forKey:@"sign"];
    
    
    // 登录授权验证
//    NSString *token = [[ShareManager shareInstance] token];
    NSString *token = @"";
    if (token) {
        [parameter setObject:token forKey:@"token"];
    }
    NSData *jsParameters = [NSJSONSerialization dataWithJSONObject:parameter  options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *aString = [[NSString alloc] initWithData:jsParameters encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    NSString *duicstr = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:aString publick:EncryptPublicKey2]];
     NSString *duicstr = [SecurityUtil encodeBase64Data:[SecurityUtil encryptAESData:aString publick:@""]];
    [parameters setObject:duicstr forKey:@"param"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    NSURLRequest *request = [requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            MLog(@"---------------------------------------------------------------");
//            MLog(@"post url = %@", urlStr);
//            MLog(@"parameter = %@", parameter);
//            MLog(@"result :%@", str);
            if (fail) {
                
                fail(@"网络请求失败了");
            }
        } else {
            
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
                int status = [[(NSDictionary *)responseObject objectForKey:@"status"] intValue];
                
                if (status == 0) {
                    if (code == 100 || code == 101) {
//
//                        [ShareManager shareInstance].userinfo.islogin = NO;
//
//                        [Tool autoLoginSuccess:^(NSDictionary *success) {
//                        } fail:^(NSString *failure) {
//                        }];
                        
                    } else {
                        // 刷新登录token
                        
//                        [LoginModel refreshToken];
                    }
                }
            }
            
            if (success) {
                success((NSDictionary *)responseObject);
                
            }
        }
    }];
    
    [dataTask resume];
}





/**
 * 获取分类下商品列表
 *
 */
+ (void)getGoodsListOfTypeWithGoodsTypeIde:(NSString *)goodsTypeId
                                   success:(void (^)(NSDictionary *resultDic))success
                                      fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (goodsTypeId) {
        [parameters setObject:goodsTypeId forKey:@"goodsTypeId"];
    }else{
        [parameters setObject:@"" forKey:@"goodsTypeId"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


+ (void)searchGoodsWithSearchKey:(NSString *)searchKey
                         success:(void (^)(NSDictionary *resultDic))success
                            fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (searchKey) {
        [parameters setObject:searchKey forKey:@"searchKey"];
    }else{
        [parameters setObject:@"" forKey:@"searchKey"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
    
}



/**
 * 加载商品详情
 *
 */
+ (void)loadGoodsDetailInfoWithGoodsId:(NSString *)goods_fight_id
                                userId:(NSString *)user_id
                               success:(void (^)(NSDictionary *resultDic))success
                                  fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (goods_fight_id) {
        [parameters setObject:goods_fight_id forKey:@"goods_fight_id"];
    }else{
        [parameters setObject:@"" forKey:@"goods_fight_id"];
    }
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }else{
        [parameters setObject:@"" forKey:@"user_id"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

/**
 * 获取活动记录（参与活动的所以人）
 *
 */
+ (void)loadDuoBaoRecordWithGoodsId:(NSString *)goods_fight_id
                            pageNum:(NSString *)pageNum
                           limitNum:(NSString *)limitNum
                            success:(void (^)(NSDictionary *resultDic))success
                               fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (goods_fight_id) {
        [parameters setObject:goods_fight_id forKey:@"goods_fight_id"];
    }else{
        [parameters setObject:@"" forKey:@"goods_fight_id"];
    }
    
    if (pageNum) {
        [parameters setObject:pageNum forKey:@"pageNum"];
    }else{
        [parameters setObject:@"" forKey:@"pageNum"];
    }
    
    if (limitNum) {
        [parameters setObject:limitNum forKey:@"limitNum"];
    }else{
        [parameters setObject:@"" forKey:@"limitNum"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}






/**
 * 获取用户消息
 */
+(void)getUserInfoWithTell:(NSString *)tel
                   success:(void (^)(NSDictionary *resultDic))success
                      fail:(void (^)(NSString *description))fail{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (tel) {
        [parameters setObject:tel forKey:@"receive_tel"];
    }
    
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
    
}



/**
 * 晒单分享回调或者app分享回调
 *
 */
+ (void)getShaiDanOrAppShareBackWithUserId:(NSString *)user_id
                                      type:(NSString *)type
                                 target_id:(NSString *)target_id
                                   success:(void (^)(NSDictionary *resultDic))success
                                      fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    if (user_id) {
        [parameters setObject:user_id forKey:@"user_id"];
    }
    
    if (type) {
        [parameters setObject:type forKey:@"type"];
    }
    
    if (target_id) {
        [parameters setObject:target_id forKey:@"target_id"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"target_id"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}


/**
 * 修改订单地址
 */
+ (void)changeOrderAddressWithOrderId:(NSString *)orderId
                       consignee_name:(NSString *)consignee_name
                        consignee_tel:(NSString *)consignee_tel
                    consignee_address:(NSString *)consignee_address
                           order_type:(NSString *)order_type
                              success:(void (^)(NSDictionary *resultDic))success
                                 fail:(void (^)(NSString *description))fail
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (orderId) {
        [parameters setObject:orderId forKey:@"id"];
    }
    
    
    if (consignee_name) {
        [parameters setObject:consignee_name forKey:@"consignee_name"];
    }
    
    if (consignee_tel) {
        [parameters setObject:consignee_tel forKey:@"consignee_tel"];
    }
    
    if (consignee_address) {
        [parameters setObject:consignee_address forKey:@"consignee_address"];
    }
    if (order_type) {
        [parameters setObject:order_type forKey:@"order_type"];
    }
    //拼接:URL_Server+keyURL
    NSString *URLString = @"";
    
    [self postHttpWithDic:parameters urlStr:URLString success:success fail:fail];
}

@end
