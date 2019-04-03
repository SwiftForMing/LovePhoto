//
//  HttpHelper.h
//  LovePhoto
//
//  Created by 黎应明 on 2019/4/2.
//  Copyright © 2019年 黎应明. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface HttpHelper : NSObject
//单例创建网络请求
+ (instancetype)helper;

/**
 *获取公共资源 get请求
 */

+ (void)getHttpWithUrlStr:(NSString *)urlStr
                  success:(void (^)(NSDictionary *resultDic))success
                     fail:(void (^)(NSString *description))fail;


/**
 *公共接口
 */
#pragma mark - System
+ (NSString *)getURL;


/**
 * 获取版本号
 */
#pragma mark - 获取版本号
+ (void)getVersion:(void (^)(NSDictionary *resultDic))success
              fail:(void (^)(NSString *description))fail;

#pragma mark - 登录绑定模块
/**
 * 获取验证码
 */
+ (void)getVerificationCodeByMobile:(NSString *)mobile
                               type:(NSString *)type
                            success:(void (^)(NSDictionary *resultDic))success
                               fail:(void (^)(NSString *description))fail;
/**
 * 注册
 */
+ (void)registerByWithMobile:(NSString *)mobile
                    password:(NSString *)password
           recommend_user_id:(NSString *)recommend_user_id
                   auth_code:(NSString *)auth_code
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail;
/**
 * 登录
 */
+ (void)loginByWithMobile:(NSString *)mobile
                 password:(NSString *)password
                 jpush_id:(NSString *)jpush_id
                  success:(void (^)(NSDictionary *resultDic))success
                     fail:(void (^)(NSString *description))fail;


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
                           fail:(void (^)(NSString *description))fail;
/**
 * 找回密码
 */
+ (void)findPwdByWithMobile:(NSString *)mobile
                   password:(NSString *)password
                  auth_code:(NSString *)auth_code
                    success:(void (^)(NSDictionary *resultDic))success
                       fail:(void (^)(NSString *description))fail;


/**
 * 第三方绑定
 */
+ (void)bangDingByWithLoginId:(NSString *)app_login_id
                         type:(NSString *)type
                      url_tel:(NSString *)url_tel
                    auth_code:(NSString *)auth_code
            recommend_user_id:(NSString *)recommend_user_id
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail;
#pragma mark - 搜索模块
/**
 * 关键字搜索
 */
+(void)getSearchKeyDataWithKeyWord:(NSString *)key
                           success:(void (^)(NSDictionary *resultDic))success
                              fail:(void (^)(NSString *description))fail;
/**
 * ID搜索
 */
+(void)getSearchIDDataWithID:(NSString *)goodID
                     pageNum:(NSString *)page
                    limitNum:(NSString *)limit
                     success:(void (^)(NSDictionary *resultDic))success
                        fail:(void (^)(NSString *description))fail;
#pragma mark - 地址

/**
 * 修改默认地址
 */
+ (void)changeDefaultAddressWithUserId:(NSString *)user_id
                             addressId:(NSString *)addressId
                               success:(void (^)(NSDictionary *resultDic))success
                                  fail:(void (^)(NSString *description))fail;

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
                        fail:(void (^)(NSString *description))fail;


/**
 * 获取城市列表
 */
+ (void)getCityInfoWithProvinceId:(NSString *)provinceId
                          success:(void (^)(NSDictionary *resultDic))success
                             fail:(void (^)(NSString *description))fail;

/**
 * 删除地址
 */
+ (void)deleteAddressWithAddressId:(NSString *)addressId
                           success:(void (^)(NSDictionary *resultDic))success
                              fail:(void (^)(NSString *description))fail;

/**
 * 收获地址列表
 */
+ (void)receiveAddressListWithUserId:(NSString *)user_id
                             success:(void (^)(NSDictionary *resultDic))success
                                fail:(void (^)(NSString *description))fail;
/**
 * 获取用户信息
 */
+ (void)getUserInfoWithUserId:(NSString *)user_id
                      success:(void (^)(NSDictionary *resultDic))success
                         fail:(void (^)(NSString *description))fail;

/**
 * Post 上传图片
 */
+ (void)postImageHttpWithImage:(UIImage *)image
                       success:(void (^)(NSDictionary *resultDic))success
                          fail:(void (^)(NSString *description))fail;

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
                     failure:(void (^)(NSString *description))failure;
@end

//NS_ASSUME_NONNULL_END
