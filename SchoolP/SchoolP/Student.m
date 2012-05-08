#import "Student.h"

@implementation Student

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mailAddress = _mailAddress;
@synthesize phoneNumber = _phoneNumber;

-(id)init
{
    return [self initWithStudentName:@"unknown" lastName: @"unknown"  mailAddress:@"unknown" phoneNumber:@"0"];
}

-(id) initWithStudentName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber:(NSString *)phoneNumber
{
    if(self = [super init])
    {
        _firstName = name;
        _lastName = lastName;
        _mailAddress = mailAddress;
        _phoneNumber = phoneNumber;
    }
    
    return self;
}

+(id) studentWithName: (NSString *)name lastName: (NSString *) lastName mailAddress: (NSString *)mailAddress phoneNumber:(NSString *)phoneNumber
{
    return [[self alloc]initWithStudentName:name lastName:lastName mailAddress:mailAddress phoneNumber:phoneNumber];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@" %@, %@, %@, %@", self.firstName, self.lastName, self.mailAddress, self.phoneNumber];
}




@end
