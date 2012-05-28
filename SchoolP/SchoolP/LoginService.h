#import <Foundation/Foundation.h>

@class User;

@interface LoginService: NSObject

@property (nonatomic, copy) NSString *userLogin;

+(id) login;

-(id) initWithUsers;

-(User*) checkLogin;

@end