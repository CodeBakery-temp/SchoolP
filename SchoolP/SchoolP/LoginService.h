#import <Foundation/Foundation.h>

@class User;

@interface LoginService: NSObject

@property (nonatomic, copy) NSString *userLogin;

+(id) withUserDictionary: (NSDictionary *) dic;

-(id) initWithUserDictionary: (NSDictionary *) dic;

-(User*) checkLogin: (NSDictionary *) dic;

@end