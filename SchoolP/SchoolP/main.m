#import <Foundation/Foundation.h>
#import "Admin.h"
#import "Student.h"
#import "StudentService.h"
#import "DBService.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        NSLog(@"___________START");

        /*
         // Databas anrop med users get STUDENT
         DBService* db = [DBService database];
         NSDictionary *users = [db getAllUsers];
         for(Student* obj in [users objectForKey:@"STUDENT"]) {
            NSLog(@"%@", [obj mailAddress]);
         }
         */
        
        /*
         //dag år månad
         [[Schedule alloc] schedule];
         */
        
        /*Student *student = [Student studentWithName:@"Orvar" lastName:@"Hassling" mailAddress:@"copy@paste.nu" phoneNumber:@"0735413452"];
         
         ServiceStudent *studentMM = [ServiceStudent studentWithName:@"adad" lastName:@"fnfnfn" mailAddress:@"haha.com" phoneNumber:@"123456789"];
         
         NSLog(@"This is NSDictionary --> %@", studentMM);
         
         
         NSLog(@"%@", student);
         */
        
        /*
         // Notification
         NSString * myMessage = [NSString stringWithFormat:@"%@ %@ (phonenumer: %@), you are late! A copy was sent to you're mail: %@", studentIM.firstName, studentIM.lastName, studentIM.phoneNumber, studentIM.mailAddress];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:myMessage forKey: admin.firstName];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" object: studentIM
                                                          userInfo:dict];
         */
        
        NSLog(@"___________STOP");
        
    }
    return 0;
}

