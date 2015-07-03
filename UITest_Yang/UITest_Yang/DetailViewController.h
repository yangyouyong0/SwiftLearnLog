//
//  DetailViewController.h
//  UITest_Yang
//
//  Created by yangyouyong on 15/7/2.
//  Copyright © 2015年 yangyouyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

