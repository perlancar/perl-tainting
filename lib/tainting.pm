package tainting;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

use Taint::Runtime qw(taint_env taint_start taint_stop);

my $env_tainted;

sub import {
    my $self = shift;

    taint_start();
    taint_env() unless $env_tainted++;
}

sub unimport {
    my $self = shift;

    taint_stop();
}

1;
#ABSTRACT: (DEPRECATED) Enable taint mode lexically

=for Pod::Coverage ^(import|unimport)$

=head1 SYNOPSIS

To enable tainting in a lexical block:

 {
     use tainting;
     # tainting is enabled
 }
 # tainting is disabled again

To disable tainting in a lexical block:

 use tainting;
 {
     no tainting;
     # tainting is disabled
 }
 # tainting is enabled again


=head1 DESCRIPTION

B<DEPRECATION NOTICE>: tainting.pm is broken because the lexical switching is
done at compile time while tainting is performed at runtime. Please see
L<Taint::Local> as alternative.

This module provides a simpler interface to L<Taint::Runtime>. The idea is so
that there is no functions or variables to import. Just C<use> or C<no>, like
L<warnings> or L<strict>. Tainting of C<%ENV> will be done one time
automatically the first time this module is used.

Please (PLEASE) read Taint::Runtime's documentation first about the pro's and
con's of enabling/disabling tainting at runtime. TL;DR: Use -T if you can.


=head1 SEE ALSO

L<Taint::Runtime>

=cut
