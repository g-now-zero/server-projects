# Virtual Environment Setup with Proxmox VE, Windows Server, Active Directory, Powershell User Creation



This project provides a step-by-step guide to setting up a virtual environment using Proxmox VE, Windows Server, Active Directory, and DHCP. By following the steps outlined in this guide, users can create a flexible and powerful virtualization platform that supports both container-based and hypervisor-based virtualization, making it suitable for a wide range of use cases and workloads. Here is my network diagram for the project:

!(https://i.imgur.com/M8xiSb0.jpg)

## Getting Started

To get started, users should download and install Proxmox VE on their host machine. They should also download the Windows 11 and Server 2019 ISOs. From there, users can follow the steps outlined in this guide to create and configure their virtual environment.

## Prerequisites

Before beginning this project, users should have:

- A host machine capable of running ![Proxmox VE](https://www.proxmox.com/en/downloads)
- The ![Windows 11](https://www.microsoft.com/software-download/windows11) and ![Server 2019](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019) ISOs
- ![VirtIO Windows Driver](https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md) 
- Basic knowledge of virtualization and networking

## Steps

1. Download and install Proxmox VE on your host machine. Proxmox VE is a powerful virtualization platform that allows you to create and manage virtual machines. Here's an example photo of accessing the GUI the first time I downloaded Proxmox VE, running an Ubuntu 20.04 virtual machine:

!(https://i.imgur.com/qFkVzKn.png)

2. Download the Windows 11, Server 2019 and VirtIO Windows Drivers and upload ISOs to Proxmox VE. These ISOs are required to install Windows 11 and Server 2019, and to install VirtIO drivers for optimal performance:

!(https://i.imgur.com/x8Ku85M.png)

3. Create a domain controller virtual machine and install Server 2019 on it by following the steps outlined in the guide. This will allow you to create and manage users, computers, and other resources on a network:

!(https://i.imgur.com/RHZbzzL.png)

4. Name the server and install Active Directory using PowerShell. Once the server is named, you can install Active Directory using PowerShell, which is a powerful scripting tool that allows you to automate tasks in Windows:

!(https://i.imgur.com/Fm0T599.png)

5. Set up RAS/NAT. RAS/NAT allows you to set up a virtual private network (VPN) and network address translation (NAT) to enable secure remote access to your network resources. This step is important if you want to enable remote access to your network resources:

!(https://i.imgur.com/Dsdy0Q4.png)

6. Set up DHCP on the domain controller. DHCP (Dynamic Host Configuration Protocol) is used to automatically assign IP addresses and other network configuration settings to devices on your network. By setting up DHCP on the domain controller, you can simplify network management and ensure that devices are configured correctly:

!(https://i.imgur.com/xAbLnjf.png)

7. Run a PowerShell script to create 100 users in Active Directory. PowerShell can be used to automate many tasks in Windows, including the creation of multiple users in Active Directory. This step will create 100 users in Active Directory, which can be used to test your network and ensure that everything is working correctly:

!(https://i.imgur.com/sVxsemU.png)

8. Create a client virtual machine and install Windows 11 on it. This will allow you to test network connectivity and ensure that your network resources are accessible from client machines.

9. Join the client to the domain and log in with a domain account. Once the client is joined to the domain, you can log in with a domain account and ensure that everything is working correctly.

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
