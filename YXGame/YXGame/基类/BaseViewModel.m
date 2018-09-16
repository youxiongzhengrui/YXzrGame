//
//  BaseViewModel.m
//  JJJR_Main
//
//  Created by zhouqixin on 2016/10/27.
//  Copyright © 2016年 zhouqixin. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel ()

//存储所有请求的数组
@property (nonatomic, strong) NSMutableArray *requestArray;

@end

@implementation BaseViewModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)registerRequest:(NSURLSessionTask *)task {
    if (task) {
        [self.requestArray addObject:task];
    }
}

- (NSMutableArray *)requestArray {
    
    if (!_requestArray) {
        return [NSMutableArray array];
    }
    return _requestArray;
}

- (void)cancelAllHTTPRequest {
    if (self.requestArray && [self.requestArray count]) {
        [self.requestArray enumerateObjectsUsingBlock:^(NSURLSessionTask *  _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (task.state == NSURLSessionTaskStateRunning || task.state == NSURLSessionTaskStateSuspended) {
                
                [task cancel];
                [self.requestArray removeObject:task];
                
            } else {
            
                [self.requestArray removeObject:task];
            }
        }];
    }
}

- (void)dealloc {
    [self cancelAllHTTPRequest];
}

@end
