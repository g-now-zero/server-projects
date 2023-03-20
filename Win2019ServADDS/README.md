# Virtual Environment Setup with Proxmox VE, Windows Server, Active Directory, Powershell User Creation



This project provides a step-by-step guide to setting up a virtual environment using Proxmox VE, Windows Server, Active Directory, and DHCP. By following the steps outlined in this guide, users can create a flexible and powerful virtualization platform that supports both container-based and hypervisor-based virtualization, making it suitable for a wide range of use cases and workloads. Here is my initial network diagram:

## Getting Started

To get started, users should download and install Proxmox VE on their host machine. They should also download the Windows 11 and Server 2019 ISOs. From there, users can follow the steps outlined in this guide to create and configure their virtual environment.

## Prerequisites

Before beginning this project, users should have:

- A host machine capable of running Proxmox VE
- The Windows 11 and Server 2019 ISOs
- Basic knowledge of virtualization and networking

## Steps

1. Download and install Proxmox VE on your host machine.
2. Download the Windows 10 and Server 2019 ISOs.
3. Create a domain controller virtual machine and install Server 2019
on it by following the steps outlined in the guide.
4. Name the server and install Active Directory using PowerShell.
5. Set up RAS/NAT.
6. Set up DHCP on the domain controller.
7. Run a PowerShell script to create 100 users in Active Directory.
8. Create a client virtual machine and install Windows 11 on it.
9. Join the client to the domain and log in with a domain account.

These steps provide a comprehensive guide to setting up a virtual environment for testing, development, or production purposes.

## Built With

This project was built using the following:

- Proxmox VE
- Windows Server 2019
- PowerShell

## Authors

- Gregory N. (https://github.com/gregorynow)

## Acknowledgments

- [Proxmox VE Documentation](https://pve.proxmox.com/pve-docs/)
- [Microsoft Active Directory Documentation](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
