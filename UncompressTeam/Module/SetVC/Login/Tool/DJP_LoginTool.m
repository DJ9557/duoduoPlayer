#import "DJP_LoginTool.h"

@implementation DJP_LoginTool

+ (void)setCornerRadiusAndBorderWithButton:(UIButton *)btn AndBorderColor:(UIColor *)color{
    //设置圆角的半径
    [btn.layer setCornerRadius:20];
     //切割超出圆角范围的子视图
     btn.layer.masksToBounds = YES;
    //设置边框的颜色
    [btn.layer setBorderColor:color.CGColor];
    //设置边框的粗细
    [btn.layer setBorderWidth:0.8f];
}

+ (NSMutableAttributedString *)textFieldPlaceholderString:(NSString *)string AndTextColor:(UIColor *)color{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:
    @{NSForegroundColorAttributeName:color,
      NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}
    ];
    
    return attrString;
}


@end

