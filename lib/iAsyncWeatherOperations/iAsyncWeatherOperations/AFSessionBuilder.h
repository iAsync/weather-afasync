#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface AFSessionBuilder : NSObject

+(AFHTTPSessionManager*)locationSessionManager;
+(AFHTTPSessionManager*)weatherSessionManager;

@end
