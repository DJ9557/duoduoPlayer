//
//  TTIICoverView.m
//  PrettyPatPlayerPlayer
//
//  Created by MAC on 2019/12/9.
//  Copyright © 2019 PPVideo. All rights reserved.
//

#import "PPVideo_CoverView.h"

@interface PPVideo_CoverView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PPVideo_CoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITableView *tableView = [[UITableView alloc] init];
        tableView.layer.cornerRadius = 6;
        tableView.scrollEnabled = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = APPGrayColor;
        //设置分割线在cell的图片下面
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return self;
}

#pragma mark - Custom Accessors

- (NSMutableArray *)PPVideo_imagesArr{
    
    if (!_PPVideo_imagesArr) {
        _PPVideo_imagesArr = [NSMutableArray array];
    }
    return _PPVideo_imagesArr;
}

- (NSMutableArray *)PPVideo_labelArr{
    if (!_PPVideo_labelArr) {
        _PPVideo_labelArr = [NSMutableArray array];
    }
    return _PPVideo_labelArr;
}

#pragma make- 布局

- (void)layoutSubviews {
    CGRect rect = self.tableView.frame;
    NSInteger widthLab = 100;
    for(NSString *string in self.PPVideo_labelArr){
        CGFloat width = [self calculateRowWidth:string];
        if(width+20> widthLab){
            widthLab = width+20;
        }
    }
    BOOL haveImage = YES;
    for(NSString *string in self.PPVideo_imagesArr){
        if(string.length == 0){
            haveImage = NO;
        }
    }
    if (haveImage) {
        widthLab +=2;
    }
    rect.size.width = widthLab;
    rect.size.height = self.PPVideo_imagesArr.count *45;
    rect.origin.y = PPVideo_AutoScaleHeight(74);
    if (self.PPVideo_inLeft) {
        rect.origin.x = 10;
    }else{
        rect.origin.x = self.bounds.size.width - rect.size.width-10;
    }
    self.tableView.frame = rect;
}

#pragma make - 画三角形

- (void)drawRect:(CGRect)rect {
    if (self.PPVideo_inLeft) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(ctx, 30, PPVideo_AutoScaleHeight(66));
        CGContextAddLineToPoint(ctx, 38, PPVideo_AutoScaleHeight(75));
        CGContextAddLineToPoint(ctx, 22, PPVideo_AutoScaleHeight(75));
        CGContextAddLineToPoint(ctx, 30, PPVideo_AutoScaleHeight(66));
        [PPVideo_BLACK set];
        
        CGContextFillPath(ctx);
    }else{
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(ctx, self.bounds.size.width - 30, PPVideo_AutoScaleHeight(66));
        CGContextAddLineToPoint(ctx, self.bounds.size.width - 38, PPVideo_AutoScaleHeight(75));
        CGContextAddLineToPoint(ctx, self.bounds.size.width-22, PPVideo_AutoScaleHeight(75));
        CGContextAddLineToPoint(ctx, self.bounds.size.width-30, PPVideo_AutoScaleHeight(66));
        [PPVideo_BLACK set];
        
        CGContextFillPath(ctx);
    }
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 12)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.PPVideo_imagesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = PPVideo_BLACK;
    NSString *imageName = self.PPVideo_imagesArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = self.PPVideo_labelArr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = imageName.length>0 ? NSTextAlignmentLeft : NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.PPVideo_jump) {
        self.PPVideo_jump(indexPath.row);
    }
    [self removeFromSuperview];
}

// 一旦触摸此视图变回从父控件中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
