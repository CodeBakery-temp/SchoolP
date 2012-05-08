#import "Admin.h"

@implementation Admin

@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mailAddress = _mailAddress;

-(id)init
{
    return [self initWithAdminName:@"unknown" lastName: @"unknown"  MailAddress:@"unknown"];
}



-(id) initWithAdminName: (NSString *)name lastName: (NSString *) lastName MailAddress: (NSString *)mailAddress
{
    if(self = [super init])
    {
        _firstName = name;
        _lastName = lastName;
        _mailAddress = mailAddress;
    }
    
    return self;
}

+(id) adminWithName: (NSString *)name lastName: (NSString *) lastName MailAddress: (NSString *)mailAddress
{
    return [[self alloc]initWithAdminName:name lastName:lastName MailAddress:mailAddress];
}

-(void) sendMessageToStudentWithMailAdress: (NSString *)mail
{
    //Skickar meddelande till adressen angiven i "mail" variabeln.
}

-(void) sendMessageToStudents:(NSString *)mail
{
    //Samma som ovan, fast alla mail i en array/dictionary
}

@end
