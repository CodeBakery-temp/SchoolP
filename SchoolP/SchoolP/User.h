#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *mailAddress;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *admin;

+(id) userWithName: (NSString *)name
          lastName: (NSString *)lastName 
          password: (NSString*) password
       mailAddress: (NSString *)mailAddress
       phoneNumber: (NSString *)phoneNumber 
             admin: (NSString *)admin
           courses: (NSDictionary *)courses;


-(id) initWithUseName: (NSString *)name
             lastName: (NSString *)lastName 
             password: (NSString*) password
          mailAddress: (NSString *)mailAddress
          phoneNumber: (NSString *)phoneNumber
                admin: (NSString *)admin
              courses: (NSDictionary *)courses;

-(NSMutableArray*)courses;

@end
