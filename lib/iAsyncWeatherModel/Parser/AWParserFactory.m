//
//  AWParserFactory.m
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "AWParserFactory.h"

#import "AWCoordinatesJsonParser.h"
#import "AWWeatherJsonParser.h"


@implementation AWParserFactory

+(id<AWWeatherParser>)jsonWeatherParser
{
   return [ AWWeatherJsonParser new ];
}

+(id<AWCoordinatesParser>)jsonCoordinatesParser
{
   return [ AWCoordinatesJsonParser new ];
}

@end
