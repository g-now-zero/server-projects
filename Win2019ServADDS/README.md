# Virtual Environment Setup with Proxmox VE, Windows Server, Active Directory, Powershell User Creation



This project provides a step-by-step guide of setting up a virtual environment using Proxmox VE virtualization to setup a Windows Domain environment that runs Active Directory and creating bulk users with Powershell that are able to login to the domain on a Client computer.  Here is my network diagram for the project:

<p align="center">
<img src="https://i.imgur.com/M8xiSb0.jpg" width="800">
</p>

## Getting Started

To get started, download and install Proxmox VE on the host machine. Also download the Windows 11 and Server 2019 ISOs. From there, follow the steps outlined in this guide to create and configure the virtual environment.

## Prerequisites

Before beginning this project, you should have:

- A host machine capable of running ![Proxmox VE](https://www.proxmox.com/en/downloads)
  (Why Proxmox? Proxmox VE is a powerful virtualization platform that allows you to create and 
  manage virtual machines. I chose this platform because A) it is an Open Source server magagement platform and B) it is Kernel-Based virtualization which 
  is extremely efficient.)
- The ![Windows 11](https://www.microsoft.com/software-download/windows11) and ![Server 2019](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019) ISOs
- ![VirtIO Windows Driver](https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md) 
- Knowledge of virtualization and networking

## Steps

### 1. Download and install Proxmox VE on your host machine.
      I. Download Proxmox VE:
         - Go to the ![Proxmox VE](https://www.proxmox.com/en/downloads) website and download the latest version of Proxmox VE. The 
           website provides download links for ISO images, which can be used to install Proxmox VE on your host machine.

      II. Check Host Machine Requirements:
         - It is recommended to check the minimum hardware requirements before installing Proxmox VE. The recommended hardware 
           requirements are typically found on the Proxmox VE website.
         - I will say, I ended up having a 2021 Dell with 256GB SSD, 16GB of RAM and a 5500U Hexacore APU lying around and this did the 
           trick.

      III. Install Proxmox VE:
         - Find a USB drive! I ended up using 32GB one I scooped off of Amazon for cheap.
         - Since I have MacOS as my daily computer, I downloaded balenaEtcher, which is a free and open-source utility used for writing 
           image files to create live USB flash drives.
   <p align="center">
   <img src="hhttps://i.imgur.com/1P09wF9.png" width="600">
   </p>           
      
         - Insert the USB drive into your main machine and format the USB drive using the Proxmox .img ISO.
         - Insert the USB drive into your host (Proxmox VE) machine and boot from it.
         - Follow the on-screen prompts to install Proxmox VE on your host machine.
         - During the installation process, you will be prompted to configure network settings, storage settings, and other important 
           configurations. I did so according to my network parameters. Also note I created a DHCP reservation for my Proxmox VE host.
      
       IV. Screenshot of the Proxmox VE installation process:
   
   <p align="center">
   <img src="https://pve.proxmox.com/pve-docs/images/screenshot/pve-grub-menu.png" width="800">
   </p>
   
   <p align="center">
   <img src="https://pve.proxmox.com/pve-docs/images/screenshot/pve-installation.png" width="800">
   </p>
   
         In the screenshot above, you can see the Proxmox VE installation process. During the installation, you will be prompted to select 
         your language, time zone, keyboard layout, and other important settings. You will also need to create a root password for the Proxmox 
         VE web interface. Once the installation is complete, you can log in to the Proxmox VE web interface and start creating virtual 
         machines. I completed this using my network diagram for proper parameters.
          

### 2. Download the Windows 11, Server 2019 and VirtIO Windows Drivers and upload ISOs to Proxmox VE. These ISOs are required to install Windows 11 and Server 2019, and to install VirtIO drivers for optimal performance:

      I. Download the required files:
         - Windows 11 ISO: The Windows 11 ISO is required to install Windows 11 on the client virtual machine. Download the ISO from the 
           Microsoft website.
         - Server 2019 ISO: The Server 2019 ISO is required to install Windows Server 2019 on the domain controller virtual machine.
           Download the ISO from the Microsoft website.
         - VirtIO Windows Drivers: The VirtIO Windows Drivers are required for optimal performance of the virtual machine. Download the 
           drivers from the VirtIO website.

      II. Upload the ISOs to Proxmox VE:
         - Open the Proxmox VE web interface and log in.
         - Select the storage location where you want to save the ISO files.
         - Click the "Upload" button to upload the ISO files.
         - Once the files are uploaded, they will be available to use when creating virtual machines.
         
<p align="center">
<img src="https://i.imgur.com/iekEqog.png" width="800">
</p>

         In the screenshot above, you can see the Proxmox VE web interface where you can upload ISO files. To upload an ISO, simply 
         select the storage location where you want to save the file and click the "Upload" button. Once the file is uploaded, it will 
         be available to use when creating virtual machines.

      III. Explanation of VirtIO Windows Drivers:
         - VirtIO Windows Drivers are a set of drivers that are designed to improve the performance of virtual machines running on 
           Proxmox VE.
         - These drivers provide enhanced network, disk, and memory performance when compared to the default drivers that are included 
           with Windows operating systems.
           

3. Create a domain controller virtual machine and install Server 2019 on it by following the steps outlined in the guide. This will allow you to create and manage users, computers, and other resources on a network:

        I. Create a Virtual Machine:
           - Open the Proxmox VE web interface and log in.
           - Click on "Create VM" to begin creating a new virtual machine.
           - Enter a name for the virtual machine.
           - Select the operating system type and version. In this case, select "Microsoft Windows" for the type and "Windows Server 2019" 
           for the version.
           - Set the amount of memory (RAM) you want to allocate to the virtual machine. It is recommended to allocate at least 4GB of RAM 
           for Windows Server 2019.
           - Set the number of CPU cores you want to allocate to the virtual machine. It is recommended to allocate at least 2 CPU cores 
           for Windows Server 2019.
           - Configure the storage settings for the virtual machine, including the amount of storage space you want to allocate and the 
           storage format.
           - Click "Create" to save the virtual machine settings.

        II. Install Windows Server 2019:
           - Start the virtual machine and insert the Server 2019 ISO into the virtual DVD drive.
           - Boot the virtual machine from the ISO and follow the on-screenprompts to install Windows Server 2019.
           - During the installation process, you will be prompted to select the language, time zone, and keyboard layout.
           - You will also need to select the disk where you want to install Windows Server 2019.
           - Once the installation is complete, you will need to configure the server settings and install any necessary updates.

<p align="center">
Here is my newly created VM domain controller "Win-DC1" running Windows Server 2019 with correct VirtIO drivers:
</p>
<p align="center">
<img src="https://i.imgur.com/RHZbzzL.png" width="750">
</p>

### 4. Name the server and install Active Directory using PowerShell. Once the server is named, install Active Directory using PowerShell:

   I. Here is the following Powershell script. Things to note are editing DomainName and DomainNetbiosName are names I gave.

  ```powershell
  
      # Powershell script to install and configure AD DS on a Windows 2019 Server

      # Import the ADDSDeployment module
      Import-Module ADDSDeployment

      # Install AD DS and create a new forest
      Install-ADDSForest `
          -CreateDnsDelegation:$false `
          -DatabasePath "C:\Windows\NTDS" `
          -DomainMode "WinThreshold" `
          -DomainName "gdomain.com" `
          -DomainNetbiosName "GDOMAIN" `
          -ForestMode "WinThreshold" `
          -InstallDns:$true `
          -LogPath "C:\Windows\NTDS" `
          -NoRebootOnCompletion:$false `
          -SysvolPath "C:\Windows\SYSVOL" `
          -Force:$true

      # This script should be run on a Windows 2019 Server as an administrator
      # The Powershell application used is Windows Powershell ISE
      # Administrative permissions are required to run the script on the server
      
  ```
<p align="center">
Here is the newly created Active Directory in the Server Dashboard.
</p>
<p align="center">
<img src="https://i.imgur.com/Fm0T599.png" width="800">
</p>

### 5. Set up RAS/NAT based on your own network topology. RAS/NAT allows you to set up network address translation (NAT) to enable secure remote access to your network resources. This step is important if you want to enable remote access to your network resources:

<p align="center">
<img src="https://i.imgur.com/Dsdy0Q4.png" width="800">
</p>

### 6. Set up DHCP on the domain controller. DHCP (Dynamic Host Configuration Protocol) is used to automatically assign IP addresses and other network configuration settings to devices on your network. By setting up DHCP on the domain controller, you can simplify network management and ensure that devices are configured correctly. * I followed the installation steps using my network parameters outlined in my network diagram:

<p align="center">
<img src="https://i.imgur.com/DuXtXDA.png" width="600">
</p>
<p align="center">
<img src="https://i.imgur.com/xAbLnjf.png" width="600">
</p>

### 7. Run a PowerShell script to create 100 users in Active Directory. PowerShell is used to automate many tasks in Windows, including the creation of multiple users in Active Directory. This step will create 100 users in Active Directory, which can be used to test your network and ensure that everything is working correctly:

```powershell

# Define variable for Active Directory password
$password = ConvertTo-SecureString "Password1" -AsPlainText -Force

# Create new Active Directory OU called "_USERS"
New-ADOrganizationalUnit -Name "_USERS" -ProtectedFromAccidentalDeletion $false

# Read list of 100 names for user creation from text file – if you’re running this script you will need to define the path to the addsusersscript folder
$names = Get-Content "C:\Users\a-gnowotarski\Desktop\addsusersscript\names.txt"

# Loop through each name and create a new user
foreach ($name in $names) {
    # Split name into first and last name
    $firstName, $lastName = $name -split ' '
    
    # Generate username
    $username = $firstName.Substring(0,1) + $lastName.ToLower()
    
    # Write output message
    Write-Host "The following user has been created: $($username)" -BackgroundColor white -ForegroundColor Black
    
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

```

This Powershell script first defines a secure password for the new _USERS, creates a new Organizational Unit in Active Directory called "Users," and reads a list of 100 names from the names.txt file. It then loops through each name, splits it into a first and last name, generates a username, and creates a new user in Active Directory with the given attributes. Finally, it outputs a message to the console for each user created. These scripts can be found in the repo.


<p align="center">
Here is the script running.
</p>
<p align="center">
<img src="https://i.imgur.com/sVxsemU.png" width="600">
</p>

### 8. Create a client virtual machine and install Windows 11 on it. This will allow you to test network connectivity and ensure that 
your network resources are accessible from client machines:

    I. Create a client virtual machine and install Windows 11 Pro:
        a. Click on the "Create VM" button.
        b. Fill out the necessary information, such as the name, CPU, memory, and storage.
        c. Select the "Windows" operating system.
        d. Choose "VirtIO" for the disk and network device.
        e. Select the ISO file for Windows 11 Pro.
        f. Click on "Create" to create the virtual machine.
        g. Start the virtual machine and follow the prompts to install Windows 11 Pro.


<p align="center">
<img src="https://i.imgur.com/x8Ku85M.png" width="600">
</p>

<p align="center">
<img src="https://i.imgur.com/antOqAH.png" width="600">
</p>

<p align="center">
<img src="https://i.imgur.com/g4AgwMl.png" width="600">
</p>

### 9. Join the client to the domain and log in with a domain account. Once the client is joined to the domain, you can log in with a 
domain account and ensure that everything is working correctly:

    II. Join the Win11Client to newly created domain gdomain.com and log in with a domain account (awelch in this case which is one of the names in 
    names.txt):
        a. Open the System Properties.
        b. Click on "Change settings" next to "Computer name, domain, and workgroup settings".
        c. Click on "Change" to change the computer name and join the domain.
        d. Restart the computer.
        e. Log in with a domain account


<p align="center">
<img src="https://i.imgur.com/ZjcsMwa.png" width="600">
</p>

<p align="center">
<img src="https://i.imgur.com/ckqgFhX.png" width="600">
</p>

<p align="center">
<img src="https://i.imgur.com/7cdWjaB.png" width="600">
</p>

## Conclusion

This project provides a step-by-step guide to creating a domain controller virtual machine and installing Server 2019 on it, as well as setting up RAS/NAT, DHCP, and running a PowerShell script to create multiple users in Active Directory. By completing these steps, you can create a fully functional Windows network for testing and development purposes.

This project stands as a steppingstone in my interest in learning more about server administration and management, familiarity with Github, as well as anyone who wants to develop their own server projects. The steps outlined in this project can be customized to fit your specific needs and can be used as a starting point for your own server projects.

If you have any questions about this project, or if you would like to collaborate on a server project of your own, please feel free to reach out to me. Thank you for visiting this repository, and I hope you find this Windows 2019 server project to be both informative and useful!

## Built With

This project was built using the following:

- Proxmox VE
- Windows Server 2019
- Windows 11
- Windows VirtIO drivers
- PowerShell

## Authors

- Gregory N. (https://github.com/gregorynow)

## Acknowledgments

- [Proxmox VE Documentation](https://pve.proxmox.com/pve-docs/)
- [Microsoft Active Directory Documentation](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
