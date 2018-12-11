//
//  CollectionViewCell.m
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)-40)];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame), 40)];
        self.text.backgroundColor = [UIColor lightGrayColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        self.text.numberOfLines = 0;
        self.text.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:self.text];
        
        //self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.btn.frame = CGRectMake(5, CGRectGetMaxY(self.text.frame), CGRectGetWidth(self.frame)-10,30);
       // [self.btn setTitle:@"按钮" forState:UIControlStateNormal];
        //self.btn.backgroundColor = [UIColor orangeColor];
        //[self addSubview:self.btn];
    }
    return self;
}


@end
