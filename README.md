getFFTab
========

GetFFTab is an AHK function to grab the Acc Object for a tab using the tab's name. 

This example will switch to the "Subsonic" tab, wait a second, then switch back to the last active tab.
Note that the "last" variable needs to be valued after the first accDoDefaultAction(0) or AHK will throw an error.

WinGetTitle, active, ahk_class MozillaWindowClass
now := RegExReplace(active, " - Firefox", "") ; Get the title of our currently active tab.

sub := GetFFTab("Subsonic") ; Makes an actionable object of the Subsonic tab.
sub.accDoDefaultAction(0) ; Activates the Subsonic tab.
Sleep 1000
last := GetFFTab(now) ; Again, note that if we had run this command _before_ Line 13, Line 14 would fail.
last.accDoDefaultAction(0) ; Re-activate the previous tab.
