#import <stdio.h>
#import <string.h>
#import <objc/objc.h>

@interface IOBluetoothHostController
+ (IOBluetoothHostController *)defaultController;
- (int)BluetoothHCIReadLocalName:(char[248])name;
- (int)BluetoothHCIWriteLocalName:(char[248])name;
@end

int main()
{
    IOBluetoothHostController *controller = [IOBluetoothHostController defaultController];

    char oldName[248];
    [controller BluetoothHCIReadLocalName:oldName];
    printf("Current bluetooth name is \"%s\". New name? ", oldName);

    BOOL changed = false;
    char newName[248];
    if (fgets(newName, sizeof(newName), stdin) != NULL) {
        // Get rid of newline at end
        newName[strcspn(newName, "\n")] = '\0';

        if (newName[0] != '\0') {
            [controller BluetoothHCIWriteLocalName:newName];
            changed = true;
        }
    } else {
        printf("\n");
    }

    if (changed) {
        // Read again for good measure
        [controller BluetoothHCIReadLocalName:newName];
        printf("Bluetooth name has been changed to \"%s\"\n", newName);
    } else {
        printf("Name not changed\n");
    }

    return 0;
}
