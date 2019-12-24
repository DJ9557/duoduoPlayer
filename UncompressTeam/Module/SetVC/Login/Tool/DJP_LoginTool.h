#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJP_LoginTool : NSObject
+ (void)setCornerRadiusAndBorderWithButton:(UIButton *)btn AndBorderColor:(UIColor *)color;

+ (NSMutableAttributedString *)textFieldPlaceholderString:(NSString *)string AndTextColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
