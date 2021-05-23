# PowerShell-Zoom-Meeting-Menu

### A simple Script to manage you Zoom Meetings 

_The script loads the meetings information from a text file, then print the menu and let you choose your action_

### Actions are: 

  _a. Open a zoom meeting_
  
  _b. Add new meeting information_
  
  _c. Delete meeting information_



### Usage:
 _As the script written in PowerShell it is of course intended for Windows Microsoft users_
 
 _You will need to edit your user name inside the script and update file location_
 
 **User Name variable: $ConfUserName**
 
 **File location variable: $FullFileName**
 
 
 _As the script loads the information from a text file, you will need to edit the text file_ 
  
_The text file holds the meetings information a shown below:_

Meeting Name,Meeting ConfNumber,Meeting Password(If needed)

#### Notice: saperation by comma (only comma



### Example:
CPP Course,2546854210,fGGGejdwfle242k2llfjsdsF

JAVA Course,55676985423,t5jksdFSFk39fklds432SDEE

Each line represent a meeting details




**One more thing (important)**
If you haven't allowed script to run on you PC you might need to run this line in PowerShell:

_Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force_

You can check your Execution Policy by running this command:

_Get-ExecutionPolicy -List_

