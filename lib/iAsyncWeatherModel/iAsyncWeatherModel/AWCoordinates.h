//
//  AWCoordinates.h
//  iAsyncWeatherModel
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWCoordinates : NSObject

@property ( nonatomic ) float latitude ;
@property ( nonatomic ) float longitude;

@property ( nonatomic ) NSString* formattedAddress;

@end
