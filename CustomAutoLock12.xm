#import <substrate.h>

static BOOL enabled;
static double minutes;
static double seconds;

static BOOL isANormalInterval(double input)
{
	// These are all seconds
	int intInput = input;
	switch (intInput)
	{
		case 30:
		case 60:
		case 120:
		case 180:
		case 240:
		case 300:
			return YES;
		break;
		default:
			return NO;
	}
}

static void loadPrefs()
{
	static NSMutableDictionary *settings;

	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.shepgoba.customautolockprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList)
	{
		settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.shepgoba.customautolockprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
		CFRelease(keyList);
	}

	if (settings == nil)
		settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shepgoba.customautolockprefs.plist"];

	enabled = [settings objectForKey:@"enabled"] ? [[settings objectForKey:@"enabled"] boolValue] : YES;
	minutes = [settings objectForKey:@"minutesDuration"] ? [[settings objectForKey:@"minutesDuration"] doubleValue] : 0;
	seconds = [settings objectForKey:@"secondsDuration"] ? [[settings objectForKey:@"secondsDuration"] doubleValue] : 0;
}

%group Tweak
%hook SBIdleTimerDescriptor
-(void)setTotalInterval:(double)arg1
{
	// Just to make sure we aren't hooking some random timer
	if (isANormalInterval(arg1))
	{
		double totalTime = minutes * 60 + seconds;
		if (totalTime != 0)
			%orig(totalTime);
		else
			%orig;
	}
	else
		%orig;
}
%end
%end

%ctor
{
	loadPrefs();
	NSLog(@"totalTime: %f", minutes * 60 + seconds);
	if (enabled)
		%init(Tweak);
}