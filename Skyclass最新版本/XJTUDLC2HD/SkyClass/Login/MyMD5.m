//
//  MyMD5.m
//  Skyclass_ios
//
//  Created by skyclass on 13-5-14.
//  Copyright (c) 2013年 skyclass. All rights reserved.
//

#import "MyMD5.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MyMD5

+(NSString *) md5: (NSString *) inPutText 
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", result[i]];
    NSString *str = [hash lowercaseString];
/*    NSLog(@"hex:%@",str);
    char *ptr=[str cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i=0; i<[str length]; i++) {
     
        ptr[i]=(char)(ptr[i] ^ 'I');
      
    }
    return [[NSString alloc]initWithCString:ptr encoding:NSASCIIStringEncoding];*/
    return str;
}
@end
