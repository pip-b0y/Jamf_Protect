THIS IS AS IS. PLEASE TEST TEST TEST INCASE IT IS WRONG AND NOT EFFECTIVE.
A catch all Apple usb connected device the analytic would look like the below (with out the ##)
##
$event.type == 0 AND $event.device.vendorName == "Apple Inc."
##
The above analytic will catch any USB Apple Built device it may pick up on Apple Keyboards and mice and possibly Apple Displays as well.

A iPhone or iPad specific analytic will look like below
For iPhone only detection (ignore the ##)
##
$event.type == 0 AND $event.device.vendorName == "Apple Inc." AND $event.device.productName == "iPhone"
##
For iPad only Detection (ignore the ##)
##
$event.type == 0 AND $event.device.vendorName == "Apple Inc." AND $event.device.productName == "iPad"
##

To detect only iPads and iPhones ignoring keyboards and other Apple Devices that may get detected you can use the analytic below (ignore the ##)
##
$event.type == 0 AND $event.device.vendorName == "Apple Inc." AND $event.device.productName IN {"iPhone", "iPad"}
##
