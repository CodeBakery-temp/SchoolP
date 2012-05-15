#import <Foundation/Foundation.h>

@class Admin, Student;

@interface LoginService: NSObject

@property (nonatomic, copy) NSString *studentLogin;

+(id) withUserDictionary: (NSDictionary *) dic;

-(id) initWithUserDictionary: (NSDictionary *) dic;

-(Student*) checkLogin: (NSDictionary *) dic;

@end