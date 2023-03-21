# Define variable for Active Directory password
$password = ConvertTo-SecureString "Password1" -AsPlainText -Force

# Create new Active Directory OU called "_USERS"
New-ADOrganizationalUnit -Name "_USERS" -ProtectedFromAccidentalDeletion 
$false

# Read list of 100 names for user creation from text file
$names = Get-Content 
"C:\Users\a-gnowotarski\Desktop\addsusersscript\names.txt"

# Loop through each name and create a new user
foreach ($name in $names) {
    # Split name into first and last name
    $firstName, $lastName = $name -split ' '
    
    # Generate username
    $username = $firstName.Substring(0,1) + $lastName.ToLower()
    
    # Write output message
    Write-Host "The following user has been created: $($username)" 
-BackgroundColor white -ForegroundColor Black
    
    # Create new user in Active Directory
    New-ADUser -AccountPassword $password `
        -GivenName $firstName `
        -Surname $lastName `
        -DisplayName $username `
        -Name $username `
        -EmployeeID $username `
        -PasswordNeverExpires $true `
        -Path "OU=_USERS,$(([ADSI]'').distinguishedName)"
}
