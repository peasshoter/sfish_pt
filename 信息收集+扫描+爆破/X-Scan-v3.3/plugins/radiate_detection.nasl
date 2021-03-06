#
# (C) Tenable Network Security, inc.
#

include("compat.inc");

if(description)
{
 script_id(11999);
 script_version("$Revision: 1.8 $");
 script_name(english: "RADIATE detection");
 script_set_attribute(attribute:"synopsis", value:
"A spyware is isntalled on the remote host." );
 script_set_attribute(attribute:"description", value:

"The remote host is using the RADIATE program.  
You should ensure that :

  - the user intended to install RADIATE (it is sometimes silently installed)
  - the use of RADIATE matches your corporate mandates and security policies.

To remove this sort of software, you may wish to check out ad-aware or spybot." );
 script_set_attribute(attribute:"see_also", value:"http://www.ca.com/us/securityadvisor/pest/pest.aspx?id=622" );
 script_set_attribute(attribute:"solution", value:
"Run a spyware remover." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );

 script_end_attributes();

 script_summary(english: "RADIATE detection");
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security");
 script_family(english: "Windows");
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");

 script_require_ports(139, 445);
 exit(0);
}


# start the script
include('smb_func.inc');
path[1] = "software\classes\clsid\{6d0bb051-a1a3-11d3-a67c-0050da2ce984}";
path[2] = "software\classes\interface\{141c673d-4515-4482-905d-a2caa68538a1}";
path[3] = "software\classes\interface\{6d0bb050-a1a3-11d3-a67c-0050da2ce984}";
path[4] = "software\classes\interface\{6d0bb053-a1a3-11d3-a67c-0050da2ce984}";
path[5] = "software\classes\interface\{8a2a68ae-9a25-444c-965b-b560105ed0a0}";
path[6] = "software\classes\interface\{e670155f-7d8c-4bba-8cfe-24e5b5a31760}";
path[7] = "software\classes\interface\{e976a28e-3b3d-4e18-a7d4-255a9f0e8ade}";
path[8] = "software\classes\typelib\{6d0bb056-a1a3-11d3-a67c-0050da2ce984}";
path[9] = "software\microsoft\windows\currentversion\uninstallradiate";

if ( ! get_kb_item("SMB/Registry/Enumerated") ) exit(0);



port = kb_smb_transport();
if(!port || ! get_port_state(port) )exit(0);

login = kb_smb_login();
pass  = kb_smb_password();
domain = kb_smb_domain();

          
soc = open_sock_tcp(port);
if(!soc) exit(0);

session_init(socket:soc, hostname:kb_smb_name());
r = NetUseAdd(login:login, password:pass, domain:domain, share:"IPC$");
if ( r != 1 ) exit(0);

handle = RegConnectRegistry(hkey:HKEY_LOCAL_MACHINE);
if ( isnull(handle) )
{
 NetUseDel();
 exit(0);
}


for (i=0; path[i]; i++) {
       key_h = RegOpenKey(handle:handle, key:path[i], mode:MAXIMUM_ALLOWED);
       if ( !isnull(key_h) ) 
       { 
         RegCloseKey(handle:key_h);
         RegCloseKey(handle:handle);
	 security_warning(kb_smb_transport()); 
	 NetUseDel();
	 exit(0);
       }
}


RegCloseKey(handle:handle);
NetUseDel();
