
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(37759);
 script_version ("$Revision: 1.1 $");
 script_name(english: "MDKA-2007:125: ia_ora-gnome");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKA-2007:125 (ia_ora-gnome).");
 script_set_attribute(attribute: "description", value: "An invalid memory disallocation in the Ia_Ora GTK theme could cause
a crash in the GIMP when using the GIMP Small theme. This updated
package corrects the issue.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKA-2007:125");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the ia_ora-gnome package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"ia_ora-gnome-1.0.17-1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libia_ora-gnome-1.0.17-1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
