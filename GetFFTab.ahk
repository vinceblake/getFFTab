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
for each, child in Acc_Children(Acc_Get("Object", "4", 0, "ahk_class MozillaWindowClass"))
{
	c1 := a_index
	try role := Acc_GetRoleText(child.accRole(0))
	If InStr(role, "tool bar")
		for each, child in Acc_Children(child)
		{
			c2 := a_index
			try role := Acc_GetRoleText(child.accRole(0))
			if inStr(role, "page tab list")
				for each, child in Acc_Children(child)
				{
					try name := child.AccName(0)
					if InStr(name, TabName)
						c3 := a_index
						
					if c3
						break
				}
			if c3
				break
		}
	if c3
		break
}

path := "4." c1 "." c2 "." c3
return Acc_Get("Object", path, 0, Title)

}
