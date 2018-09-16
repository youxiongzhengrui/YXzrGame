//
//  UrlEncodeUtils.m
//  xiangyue
//
//  Created by 申豆 on 14-12-11.
//  Copyright (c) 2014年 shendou. All rights reserved.
//

#import "UrlEncodeUtils.h"
#import "NSString+IDNExtend.h"

@implementation UrlEncodeUtils
+(NSString *)enCodeUrl:(NSString *)str
{
	return [str urlEncoding];
//    NSString* encodedValue = (NSString*)CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)str, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
//    return encodedValue;
}

+(NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    return (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) input,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8);
}

+(NSMutableDictionary *)encodeAllKeyAndValueForDict:(NSDictionary *)dic
{
    NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
    for (NSString *keys in [dic allKeys]) {
        
        [newDic setObject:[UrlEncodeUtils enCodeUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:keys]]] forKey:keys];
    }
    return newDic;
}

@end
