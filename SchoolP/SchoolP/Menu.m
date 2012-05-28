#import "DBService.h"
#import "LoginService.h"
#import "ScheduleService.h"
#import "Menu.h"
#import "Lecture.h"
#import "Note.h"
#import "User.h"
#import "Message.h"

NSString const* homefolder = @"username";

@implementation Menu

@synthesize menu = _menu;

-(id)initMenu : (int) menu
{
    return [self initMenu:0];
}

+(void) menu
{
    int value = 0;
    //////TO GET ONE USER FROM LOGIN START//////
    ScheduleService* schedule = [ScheduleService schedule];
    
    // DATE
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSWeekCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    // LOGIN
    LoginService* userLogin = [LoginService login];
    User* user = [userLogin checkLogin];
    NSLog(@"User logged in: \n %@", user);
    NSArray* allYourLectures = [schedule getLecturesOfWeek:user currentWeek:[components week]];
    NSDictionary* lecturesSorted = [schedule getLecturesPerDaysRefined:allYourLectures];
    
    // GET NOTES
    NSArray* allYourNotes = [schedule getNotesOfWeek:user currentWeek:[components week]];
    NSDictionary* notesSorted = [schedule getNotesPerDays:allYourNotes];
    
    // YOUR MESSAGES
    NSArray* message = [schedule getUserMessages:user];
    NSLog(@"Inbox :%lu", [message count]);
    
    
    if ([[user admin] isEqualTo:@"1"]) {
        
        // GET TODAY'S, THIS WEEK'S SCHEDULE & READ MESSAGES
        
        /////// Denna kod här nedanför är menyn för ADMIN
        
        do {
             NSLog (@"________________________________________________________\n 1 = Today \n 2 = Week \n 3 = Inbox \n 4 = Create Lecture Template \n 5 = Update Lecture Template \n 6 = Update Lecture Event \n 7 = Create Note \n 8 = Send Message [one] \n 9 = Send Message [many]\n 0 = Exit\nPICK A NUMBER! \n");
            scanf ("%i", &value);
            switch (value)
            {
                case 1:
                    // Lectures DAY
                    [schedule printCurrentDay:lecturesSorted notes:notesSorted];
                    /*for (Lecture* lec in lecturesToday) {
                        [lec printLecture];
                    }*/
                    //[schedule createLecture:[db getLectures] jsonPath:@"/Users/DQF/Desktop/schema.json"];
                    break;
                case 2:
                    // Lectures WEEK
                    [schedule printCurrentWeek:lecturesSorted notes:notesSorted];
                    //[schedule createMessage:@"/Users/Evhuul/Desktop/message.json"];
                    break;
                case 3:
                    // Message Inbox
                    [schedule printInbox:[schedule getUserMessages:user]];
                    //[schedule createMessage:@"/Users/Evhuul/Desktop/messageall.json"];
                    break;
                case 4:
                    // Create Lecture Template
                    [schedule createLecture:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/lecture.json", homefolder]];
                    //id på kursen 1 JavaScript, 2 Objective-C, 3 InDesign
                    break;
                case 5:
                    // Update Lecture Template
                    [schedule updateLectureTemplate:@"1" jsonPath:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/lecture.json", homefolder]];
                    break;
                case 6:
                    // Update Lecture Event
                    [schedule updateLectureEvent:@"1" version:@"1" jsonPath:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/lecture.json", homefolder]];
                    
                    break;
                case 7:
                    // Create Note
                    [schedule createNote:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/note.json", homefolder]];
                    break;
                case 8:
                    // Create Message [ONE]
                    [schedule createMessage:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/message.json", homefolder]];
                    break;
                case 9:
                    // Create Message [MANY]
                    [schedule createMessage:[NSString stringWithFormat:@"/Users/%c/Dropbox/Project Schema/kod/JSON/messageAll.json", homefolder]];
                    break;
                default:
                    while (value != 0);
                    NSLog(@"Good bye!");
                    break;
            }
        }while (value != 0); 
        /////// Denna kod här nedanför är menyn för STUDENT
    } else {
        do {
            NSLog (@"________________________________________________________\n 1 = Today \n 2 = Week \n 3 = Inbox \n 0 = Exit\nPICK A NUMBER! \n");
            scanf ("%i", &value);
            switch (value)
            {
                case 1:
                    [schedule printCurrentDay:lecturesSorted notes:notesSorted];
                    break;
                case 2:
                    [schedule printCurrentWeek:lecturesSorted notes:notesSorted];
                    
                    break;
                case 3:
                    [schedule printInbox:[schedule getUserMessages:user]];
                    break;
                default:
                    while (value != 0);
                    NSLog(@"Good bye!");
                    break;
            }
        }while (value != 0);
    }
}

@end