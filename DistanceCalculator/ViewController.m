//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Billy Rey Caballero on 21/3/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *destination1;
@property (weak, nonatomic) IBOutlet UITextField *destination2;
@property (weak, nonatomic) IBOutlet UITextField *destination3;
@property (weak, nonatomic) IBOutlet UITextField *destination4;
@property (weak, nonatomic) IBOutlet UILabel *destination1Label;
@property (weak, nonatomic) IBOutlet UILabel *destination2Label;
@property (weak, nonatomic) IBOutlet UILabel *destination3Label;
@property (weak, nonatomic) IBOutlet UILabel *destination4Label;
@property (weak, nonatomic) IBOutlet UIButton *calculateDistance;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)calculateDistanceButton:(id)sender {
    self.calculateDistance.enabled = NO;
    self.request = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *dest1 = self.destination1.text;
    NSString *dest2 = self.destination2.text;
    NSString *dest3 = self.destination3.text;
    NSString *dest4 = self.destination4.text;
    NSArray *destinations = @[dest1, dest2, dest3, dest4];
    self.request = [self.request initWithLocationDescriptions:destinations sourceDescription:start];
    __weak ViewController *weakSelf = self;
    
    self.request.callback = ^void(NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
        NSNull *badResult = [NSNull null];
        
        if(responses[0] != badResult){
            double distance1 = ([responses[0] floatValue]/1000.0);
            NSString *distance1Value = [NSString stringWithFormat:@"%0.2f  km.", distance1];
            strongSelf.destination1Label.text = distance1Value;
         }
        else{
            strongSelf.destination1Label.text = @"Error";
        }
        
        if(responses[1] != badResult){
            double distance2 = ([responses[1] floatValue]/1000.0);
            NSString *distance2Value = [NSString stringWithFormat:@"%0.2f  km.", distance2];
            strongSelf.destination2Label.text = distance2Value;
        }
        else{
            strongSelf.destination2Label.text = @"Error";
        }
        
        if(responses[2] != badResult){
            double distance3 = ([responses[2] floatValue]/1000.0);
            NSString *distance3Value = [NSString stringWithFormat:@"%0.2f  km.", distance3];
            strongSelf.destination3Label.text = distance3Value;
        }
        else{
            strongSelf.destination3Label.text = @"Error";
        }
        
        if(responses[3] != badResult){
            double distance4 = ([responses[3] floatValue]/1000.0);
            NSString *distance4Value = [NSString stringWithFormat:@"%0.2f  km.", distance4];
            strongSelf.destination4Label.text = distance4Value;
        }
        else{
            strongSelf.destination4Label.text = @"Error";
        }
        
        strongSelf.request = nil;
        strongSelf.calculateDistance.enabled = YES;
    };
    [self.request start];
}

@end
