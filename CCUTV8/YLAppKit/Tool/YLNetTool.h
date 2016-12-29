//
//  YLNetTool.h
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, YLNetworkReachabilityStatus) {
    YLNetworkReachabilityStatusUnknown          = AFNetworkReachabilityStatusUnknown,
    YLNetworkReachabilityStatusNotReachable     = AFNetworkReachabilityStatusNotReachable,
    YLNetworkReachabilityStatusReachableViaWWAN = AFNetworkReachabilityStatusReachableViaWWAN,
    YLNetworkReachabilityStatusReachableViaWiFi = AFNetworkReachabilityStatusReachableViaWiFi,
};

@interface YLNetTool : NSObject

#pragma mark - 请求方法
+ (void) getWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - 判断当前网络
+ (void)setReachabilityStatusChangeBlock:(void (^)(YLNetworkReachabilityStatus))block;

@end
