//
//  AWParserFactory.h
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AWWeatherParser;
@protocol AWCoordinatesParser;

@interface AWParserFactory : NSObject

+(id<AWWeatherParser>)jsonWeatherParser;
+(id<AWCoordinatesParser>)jsonCoordinatesParser;

@end
