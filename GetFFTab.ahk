/*
This function accepts all or part of a tab's name and returns the relevant actionable object.
You can then use accDoDefaultAction(0) to activate the tab in Firefox. 

Note that using accDoDefaultAction will disrupt any previously defined tab objects.
Attempting to act on a previously defined tab after running accDoDefaultAction
will result in an AHK error. You will therefore need to define a tab, activate it,
and only after that can you establish a second tab on which to act.

Requires the Acc Library: 
http://www.autohotkey.com/board/topic/77303-acc-library-ahk-l-updated-09272012/
*/

GetFFTab(TabName=""){
for each, child in Acc_Children(Acc_Get("Object", "4", 0, "ahk_class MozillaWindowClass")) ; 4 is the "application" path. It is a constant.
{
	c1 := a_index ; We will use the c variables to map the path to the object we want to retrieve.
	try role := Acc_GetRoleText(child.accRole(0)) ; 0 is a constant. 
	If InStr(role, "tool bar") ; Obtained this information from Jethrow's Acc Viewer program.
		for each, child in Acc_Children(child)
		{
			c2 := a_index ; Getting closer...
			try role := Acc_GetRoleText(child.accRole(0))
			if inStr(role, "page tab list")
				for each, child in Acc_Children(child)
				{
					try name := child.AccName(0)
					if InStr(name, TabName)
					{
						c3 := a_index ; This is the final piece of the path to the desired tab.
						break ; Stop looking in the inner loop.
				}
			if c3
				break ; Stop looking in the middle loop.
		}
	if c3
		break ; Stop looking in the outer loop.
}

path := "4." c1 "." c2 "." c3 ; Here's our full path to the tab
return Acc_Get("Object", path, 0, Title) ; Return the object located at our path.

}
