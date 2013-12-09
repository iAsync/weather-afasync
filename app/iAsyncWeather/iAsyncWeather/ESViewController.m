//
//  ESViewController.m
//  iAsyncWeather
//
//  Created by Oleksandr Dodatko on 19/10/2013.
//  Copyright (c) 2013 Oleksandr Dodatko. All rights reserved.
//

#import "ESViewController.h"

@interface ESViewController ()

@end

@implementation ESViewController
{
   JFFCancelAsyncOperation _cancelLoad;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

   // WTF : workaround
   self.activityIndicator.hidden = YES;
   
   UIColor* clearColor = [ UIColor clearColor ];
   self.lblWeahterDetails.backgroundColor = clearColor;
   self.lblWeatherTitle.backgroundColor   = clearColor;
   self.lblLatitudeData.backgroundColor   = clearColor;
   self.lblLongitudeData.backgroundColor  = clearColor;
}


-(BOOL)textFieldShouldReturn:( UITextField* )textField
{
   [ textField resignFirstResponder ];
   return YES;
}

-(IBAction)getWeatherButtonTapped:(id)sender
{
   [ self.txtAddress resignFirstResponder ];
   
   NSString* address = self.txtAddress.text;
   if ( ![ self validateAddress: address ] )
   {
      UIAlertView* alert =
      [ [ UIAlertView alloc ] initWithTitle: @"iAsync Weather"
                                    message: @"Please enter address"
                                   delegate: nil
                          cancelButtonTitle: @"OK. I'll do it."
                          otherButtonTitles: nil ];
      [ alert show ];
      
      return;
   }
   
   
   JFFAsyncOperation loader = [ AWOperationsFactory asyncWeatherForAddress: address ];
   
   
   __weak ESViewController* weakSelf = self;
   JFFCancelAsyncOperationHandler onCancel = ^void(BOOL isOperationKeepGoing)
   {
      [ weakSelf onWeatherInfoRequestCancelled ];
   };
   JFFDidFinishAsyncOperationHandler onLoaded = ^void(id result, NSError *error)
   {
      [ weakSelf onWeatherInfoLoaded: result
                           withError: error ];
   };
   JFFCancelAsyncOperation cancelLoad = loader( nil, onCancel, onLoaded );
   self->_cancelLoad = cancelLoad;
   
   self.activityIndicator.hidden = NO;
   [ self.activityIndicator startAnimating ];
}

-(IBAction)cancelButtonTapped:(id)sender
{
   if ( nil != self->_cancelLoad )
   {
      self->_cancelLoad( YES );
   }
   
   [ self.activityIndicator stopAnimating ];
   self.activityIndicator.hidden = YES;
   self.resultView.hidden = YES;
}

-(BOOL)validateAddress:( NSString* )address
{
   return [ address hasSymbols ];
}

-(void)onWeatherInfoRequestCancelled
{
   UIAlertView* alert =
   [ [ UIAlertView alloc ] initWithTitle: @"iAsync Weather"
                                 message: @"I have changed my mind. I do not need to know the weather"
                                delegate: nil
                       cancelButtonTitle: @"Ok."
                       otherButtonTitles: nil ];
   [ alert show ];
}

-(void)onWeatherInfoLoaded:( AWWeatherInLocation* )model
                 withError:( NSError* )error
{
   if ( nil == model )
   {
      [ self reportError: error ];
      return;
   }
   else
   {
      [ self onSuccessfulLoad: model ];
   }
}

-(void)onSuccessfulLoad:( AWWeatherInLocation* )model
{
   self.lblLatitudeData.text  = [ @(model.location.latitude ) stringValue];
   self.lblLongitudeData.text = [ @(model.location.longitude) stringValue];
   
   self.txtRemoteAddress.text = model.location.formattedAddress;

   self.lblWeatherTitle.text   = model.weather.weatherName;
   self.lblWeahterDetails.text = model.weather.weatherDescription;
   
   self.resultView.hidden = NO;
}

-(void)reportError:( NSError* )error
{
   NSParameterAssert( nil != error );
   
   self.resultView.hidden = YES;
   [ self.activityIndicator stopAnimating ];
   self.activityIndicator.hidden = YES;
   
   UIAlertView* alert =
   [ [ UIAlertView alloc ] initWithTitle: @"Error"
                                 message: error.localizedDescription
                                delegate: nil
                       cancelButtonTitle: @"OK. I'll try again later"
                       otherButtonTitles: nil ];
   [ alert show ];
}

@end
