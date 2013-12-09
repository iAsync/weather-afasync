//
//  ESViewController.h
//  iAsyncWeather
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextView *txtRemoteAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblWeatherTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblWeahterDetails;
@property (weak, nonatomic) IBOutlet UILabel *lblLatitudeData;
@property (weak, nonatomic) IBOutlet UILabel *lblLongitudeData;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *resultView;

-(IBAction)getWeatherButtonTapped:(id)sender;
-(IBAction)cancelButtonTapped:(id)sender;

@end
