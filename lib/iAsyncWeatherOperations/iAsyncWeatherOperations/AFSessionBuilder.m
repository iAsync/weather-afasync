#import "AFSessionBuilder.h"

@implementation AFSessionBuilder

+(AFHTTPSessionManager*)createNewSessionManager
{
   AFHTTPSessionManager* result = [ AFHTTPSessionManager manager ];
   result.responseSerializer = [ AFHTTPResponseSerializer serializer ];

   return result;
}

// TODO : use proper base URL
+(AFHTTPSessionManager*)locationSessionManager
{
   return [ self createNewSessionManager ];
}

+(AFHTTPSessionManager*)weatherSessionManager
{
   return [ self createNewSessionManager ];
}

@end
