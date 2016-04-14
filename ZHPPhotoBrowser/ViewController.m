//
//  ViewController.m
//  ZHPPhotoBrowser
//
//  Created by WCiOS on 16/4/14.
//  Copyright © 2016年 WCiOS. All rights reserved.
//

#import "ViewController.h"
#import "PBViewController.h"
@interface ViewController ()<PBViewControllerDataSource,PBViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *images = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    NSInteger counts = images.count;
    CGFloat picBtnW = (self.view.frame.size.width-60)/5;
    CGFloat picBtnH = picBtnW;
    for (int i = 0; i < counts; i++) {
        
        CGFloat picBtnX = 10 + (picBtnW + 10)*i;
        UIButton *picBtn = [[UIButton alloc]init];
        picBtn.tag = i+1;
        picBtn.frame = CGRectMake(picBtnX, 100, picBtnW, picBtnH);

        [picBtn setImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:UIControlStateNormal];
        picBtn.backgroundColor = [UIColor whiteColor];
        picBtn.layer.cornerRadius = 4;
        picBtn.layer.masksToBounds = YES;
        [picBtn addTarget:self action:@selector(lookupPicture:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:picBtn];
    }
    

}
#pragma mark--点击放大图片
-(void)lookupPicture:(UIButton *)btn{
    
//    self.picBtn = btn;
    
    NSInteger index=btn.tag;
    PBViewController * photoBrowser=[PBViewController new];
    photoBrowser.pb_dataSource=self;
    photoBrowser.pb_delegate=self;
    [photoBrowser setInitializePageIndex:index-1];
    [self presentViewController:photoBrowser animated:YES completion:^{
        
    }];
    
}

-(NSInteger)numberOfPagesInViewController:(PBViewController *)viewController{
   NSArray *images = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    return images?images.count:0;
}
-(UIImage *)viewController:(PBViewController *)viewController imageForPageAtIndex:(NSInteger)index{
    UIButton * btn=[self.view viewWithTag:index+1];
    return btn.currentImage;
}
- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [viewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
