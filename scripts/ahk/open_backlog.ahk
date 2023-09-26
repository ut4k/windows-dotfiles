#Persistent
SetTitleMatchMode, 2

; Define a hotkey to open the input form
^!b::OpenInputForm()

OpenInputForm() {
	confFile = %a_scriptdir%/config/myahk.ini

	; load config from external file
	IniRead, BacklogUrl, %confFile%, Common, OPEN_BACKLOG_URL

    ; Display a custom message and an input box to capture user input
    InputBox, userInput, Backlog opener, Please Enter backlog issue key(ex. FOO-123)
	
    ; Check if the user entered something
    if (userInput) {
        ; Construct the URL
        url := % BacklogUrl . userInput
        
        ; Open the URL in the default web browser
        Run, %url%
    }
}