//
//  YLNetTool.m
//
//  Created by Oneself on 16/6/5.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "YLNetTool.h"

static const NSString *YLNetToolHomeUrl = @"http://10.73.59.159:8000/";

@implementation YLNetTool

#pragma mark - 请求方法
+ (void)getWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", YLNetToolHomeUrl, url] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@", YLNetToolHomeUrl, url] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) failure(error);
    }];
}

#pragma mark - 判断当前网络
+ (void)setReachabilityStatusChangeBlock:(void (^)(YLNetworkReachabilityStatus))block {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (block)
            block((YLNetworkReachabilityStatus)status);
    }];
    [manager startMonitoring];
}

@end
