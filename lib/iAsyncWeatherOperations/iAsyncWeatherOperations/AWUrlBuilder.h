//
//  AWUrlBuilder.h
//  iAsyncWeatherOperations
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AWCoordinates;

@interface AWUrlBuilder : NSObject

+(NSString*)locationGetterForAddress:( NSString* )address;
+(NSString*)weatherGetterForCoordinates:( AWCoordinates* )coordinates;

@end
