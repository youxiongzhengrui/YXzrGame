//
//  UrlEncodeUtils.h
//  xiangyue
//
//  Created by 申豆 on 14-12-11.
//  Copyright (c) 2014年 shendou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlEncodeUtils : NSObject
+(NSString *)enCodeUrl:(NSString *)str;
+(NSString *)decodeFromPercentEscapeString: (NSString *) input;
+(NSMutableDictionary *)encodeAllKeyAndValueForDict:(NSDictionary *)dic;
@end
