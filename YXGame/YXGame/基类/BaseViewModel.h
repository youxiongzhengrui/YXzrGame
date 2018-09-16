//
//  BaseViewModel.h
//  JJJR_Main
//
//  Created by zhouqixin on 2016/10/27.
//  Copyright © 2016年 zhouqixin. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseWebService.h"

@interface BaseViewModel : NSObject

#define mark - Warning  :  Require Implementation Methods Blow.
//注册请求
- (void)registerRequest:(NSURLSessionTask *)task;

//取消所有的请求
- (void)cancelAllHTTPRequest;

@end
