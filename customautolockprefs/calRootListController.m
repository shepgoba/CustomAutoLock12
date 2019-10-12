#include "calRootListController.h"
#include <spawn.h>

@implementation calRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
-(void)respringDevice
{
	UIAlertController *confirmRespringAlert = [UIAlertController alertControllerWithTitle:@"Apply settings?" message:@"This will respring your device" preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) 
    {
       pid_t pid;
		const char *argv[] = {"sbreload", NULL};
		posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)argv, NULL);
    }];

	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    [confirmRespringAlert addAction:confirm];
    [confirmRespringAlert addAction:cancel];
	[self presentViewController:confirmRespringAlert animated:YES completion:nil];
}
-(void)openTwitter
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/shepgoba"] options:@{} completionHandler:nil];
}
@end
