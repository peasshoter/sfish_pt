
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(39902);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.0 Security Update:  RealPlayer (2009-05-21)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for RealPlayer");
 script_set_attribute(attribute: "description", value: "RealPlayer 10 is vulnerable to a critical security problem
in the flash plugin (CVE-2007-5400). Real does not provide
updated binaries of RealPlayer 10 and SUSE is not allowed
to ship RealPlayer 11. Therefore this update disables the
flash plugin by setting restrictive file system permissions.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for RealPlayer");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=412630");
script_end_attributes();

 script_cve_id("CVE-2007-5400");
script_summary(english: "Check for the RealPlayer package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"RealPlayer-10.0.9-51.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
