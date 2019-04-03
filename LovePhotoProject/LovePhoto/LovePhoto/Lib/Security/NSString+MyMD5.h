//
//  NSString+MyMD5.h
//  LovePhoto
//
//  Created by 黎应明 on 2019/4/2.
//  Copyright © 2019年 黎应明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString_MyMD5 : NSString
-(NSString *)md5Encrypt;
@end

NS_ASSUME_NONNULL_END
