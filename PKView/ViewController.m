//
//  ViewController.m
//  PKView
//
//  Created by Fancy on 2021/6/25.
//

#import "ViewController.h"
#import "PKCustomView.h"

@interface ViewController ()

@property (nonatomic, strong) PKView       *view1;
@property (nonatomic, strong) PKCustomView *view2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view1 = ({
        PKView *view = [[PKView alloc] initWithFrame:CGRectMake(20, 150, CGRectGetWidth(self.view.bounds) - 40, 50)];
        view.progress = .8;
        view;
    });
    
    [self.view addSubview:self.view1];
    
    self.view2 = ({
        PKCustomView *view = [[PKCustomView alloc] initWithFrame:CGRectMake(20, 250, CGRectGetWidth(self.view.bounds) - 40, 50)];
        view.progress = .8;
        view.leftLabel.text = @"选项1";
        view.rightLabel.text = @"选项2";
        view;
    });
    
    [self.view addSubview:self.view2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view1 animate];
    [self.view2 animate]; 
}

@end
