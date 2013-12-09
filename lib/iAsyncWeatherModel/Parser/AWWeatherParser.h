//
//  AWWeatherParser.h
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AWWeatherInfo;

@protocol AWWeatherParser <NSObject>

-(AWWeatherInfo*)parseData:( NSData* )rawData
                     error:( NSError** )outError;

@end
