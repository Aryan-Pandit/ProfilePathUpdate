#Get location of where the profile paths of users will be changed.
$userForLocation = Read-Host "Provide a user/username for location"
$location = Get-ADUser -Identity $userForLocation

#Get location without the name of the user as a parameter
$locationDN = $location.DistinguishedName
$name = (Get-ADUser -Identity $userForLocation).Name
$nameParam = 'CN='+$name
$locationDN = $locationDN -replace "$nameParam,", ''

#Get a list of users from the location
$users = Get-ADUser -Filter * -SearchBase $locationDN

#Ask user to input the new profile path name they would like for the users
$newProfilePath = Read-Host "Enter the new profile path"

#Run a for-loop to set the new profile path names
foreach ($user in $users) {
    $username = $user.SamAccountName
    $newProfilePath = "$newProfilePath\$username"
    Set-ADUser -Identity $user -ProfilePath $newProfilePath
}