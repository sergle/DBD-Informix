# @(#)$Id: Informix.pm,v 2007.2 2007/09/03 00:20:56 jleffler Exp $

package Bundle::DBD::Informix;

$VERSION = '2011.0612';

1;

__END__

=head1 NAME

Bundle::DBD::Informix - A bundle to install all DBD::Informix related modules

=head1 SYNOPSIS

C<perl -MCPAN -e 'install Bundle::DBD::Informix'>

=head1 CONTENTS

Test::Pod      - Test for POD accuracy

Time::HiRes    - High Resolution Timing by DEWEG (Douglas Wegscheid)

Bundle::DBI    - Bundle for DBI by TIMB (Tim Bunce)

DBD::Informix  - DBD::Informix by JOHNL (Jonathan Leffler)

=head1 DESCRIPTION

This bundle includes all the modules used by the Perl Database
Interface (DBI) driver for Informix (DBD::Informix), assuming the
use of DBI version 1.02 or later, created by Tim Bunce.

If you've not previously used the CPAN module to install any
bundles, you will be interrogated during its setup phase.
But when you've done it once, it remembers what you told it.
You could start by running:

    C<perl -MCPAN -e 'install Bundle::CPAN'>
    C<perl -MCPAN -e 'install Bundle::libnet'>
    C<perl -MCPAN -e 'install Bundle::LWP'>

DBD::Informix uses the Time::HiRes module for timing insert cursors.

=head1 SEE ALSO

Bundle::DBI

=head1 AUTHOR

Jonathan Leffler E<lt>F<jleffler@us.ibm.com>E<gt>

=head1 THANKS

This bundle was created by ripping off Bundle::libnet created by 
Graham Barr E<lt>F<gbarr@ti.com>E<gt>, and radically simplified
with some information from Jochen Wiedmann E<lt>F<joe@ispsoft.de>E<gt>.

  Copyright 1998-1999 Jonathan Leffler
  Copyright 2000      Informix Software Inc
  Copyright 2002      IBM
  Copyright 2007      Jonathan Leffler

=cut
