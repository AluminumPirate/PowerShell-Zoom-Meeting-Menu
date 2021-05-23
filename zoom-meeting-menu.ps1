
# PLEASE NOTICE !   
# If Meeting's password are confidential, be a programmer and add a code section where you ask the user for the Meeting's password
# DO NOT (EVER!) WRITE  CONFIDENTIAL INFORMATION IN A SIMPLE PLAINTEXT FILE!

# Edit the $ConfUserName variable as the name you want to login with to the Zoom Meeting


# General usage.
$NameLocation = 0
$ConfNumberLocation = 1
$ConfPasswordLocation = 2

# Choose user name
$ConfUserName = "Some Name" 

# Choose file to edit Meetings
$FullFileName = ".\Meetings_details.txt"



# Arry List for meetings
[System.Collections.ArrayList]$Meetings = @()


# Import meetings from file
function Get-Meetings-From-File {
    $Index = 0
    $Meetings.Clear()

    $File = Get-Content $FullFileName
    foreach($Line in $File){
        $NLine = $Line.Split(",")
        $Meetings.Add(@($NLine[0], $NLine[1], $NLine[2])) 
    }
}


# Currently Just callting Get-Meetings-From-File. Might be usefull someday to add more content
function Update-File-Content {
	
    Get-Meetings-From-File
}


# Add meeting line to meeting details file
function Add-Meeting-Entry-To-File {
	
	# do not allow empty name
	do {
		$Name = Read-Host "Meeting Name"
	} until($Name  -ne [string]::empty)
	
	# allow only numeric value
	do {
		$ConfNum = Read-Host "Conference number"
	} until($ConfNum -match "^\d+$" -And $ConfNum -ne [string]::empty)
	
	# may be empty
	$ConfPass = Read-Host "Conference password"
	
	$Meeting = $Name + "," + $ConfNum +  "," + $ConfPass
	
	# add content to file
	Add-Content $FullFileName -Value $Meeting

}


# Delete meeting by line number
function Delete-Meetings-Entry-From-File($LineToRemove) {

    $File
    # Get File content and store it into $content variable
    $content = Get-Content $FullFileName | Where-Object ReadCount -notin $LineToRemove
    
    # Set the new content
    $content | Set-Content -Path $FullFileName
}


# Head of menu
function Write-Menu-Beginning {
    $Title = 'Zoom Meetings Launcher'

    Write-Host "================ $Title ================"
    
    Write-host "`n"
}

# Bottom of menu
function Write-Menu-Ending($Index) {
    
    Write-host "`n"
	Write-Host $Index": Add a new Meeting."
    $Index++
    Write-Host $Index": Delete Meeting."
    $Index++
}


# Display menu 
function Show-Menu {

    Clear-Host
    Write-Menu-Beginning

    $MenuIndex = 0

    Foreach ($Meeting in $Meetings)
    {
        Write-Host $MenuIndex": Start" $Meeting[0] "Meeting."
        $MenuIndex++
        
    }
    Write-Menu-Ending($MenuIndex)
    Write-Host "Q: Enter 'Q' or 'q' to quit."
}



# Replace spaces in user name
$ConfUserName = $ConfUserName -replace(" ", "+")

# Initialize $Meeting variable
Get-Meetings-From-File

do
 {
    Show-Menu

    $Selection = Read-Host "`nChoose option"

	# f input is numeric and not empty keep going
    if (($Selection -as [int]) -match "^\d+$"  -And  $Selection -ne [string]::empty) {
        $Selection = ($Selection -as [int])

		# if input is Meeting length, prompt add meeting 
        if ($Selection -eq $Meetings.count) {
            Add-Meeting-Entry-To-File      
            Update-File-Content
		
		# if input is Meeting length + 1, prompt delete meeting
	    } elseif ($Selection -eq ($Meetings.count+1)) {
            $MeetingToDelete = Read-Host "`nChoose Meeting number from above list"
		    Delete-Meetings-Entry-From-File(($MeetingToDelete -as [int]) +1 )
            Update-File-Content
            
		# if  input is inside Meeting length range, launch Zoom meeting
        }elseif ($Selection -ge 0 -And $Selection -lt $Meetings.count) {
            $command = "zoommtg://zoom.us/join?action=join&confno="+$Meetings[$Selection][$ConfNumberLocation] + "?&uname=" + $ConfUserName + "&pwd=" + $Meetings[$Selection][$ConfPasswordLocation]
            $command = """$command"""
            
            start ($command)
		    exit
	    }
    }   
	# if input is 'q' or 'Q' exit program
 }
 until ($Selection -eq 'q')
 
 exit
