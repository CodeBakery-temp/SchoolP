#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *mailAddress;
@property (nonatomic, copy) NSString *phoneNumber;



-(id) initWithStudentName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber: (NSString *) phoneNumber;

+(id) studentWithName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber: (NSString *) phoneNumber;



@end
