package Audio::AMR::Decode;

use strict;
use warnings;

require Exporter;
require XSLoader;

our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();
our $VERSION = '0.01';

XSLoader::load('Audio::AMR::Decode', $VERSION);

1;
__END__

=head1 NAME

Audio::AMR::Decode - Perl extension do decode .amr files

=head1 SYNOPSIS

  use Audio::AMR::Decode;
  Audio::AMR::Decode::amr2raw('infile.amr', 'outfile.pcm');

=head1 DESCRIPTION

This module will attempt to decode an amr encoded audio file to a raw pcm
audio encoded file.

The package contains C-source files for the optimized fixed-point speech
decoder. The optimized fixed-point speech decoder is bit-exact with 3GPP TS
26.073 fixed-point speech decoder version 4.1.0.

=head1 CAVEATS

Technically this works but I wouldn't call this code 'mature'. Proceed with
caution

=head1 SEE ALSO

ftp://ftp.3gpp.org/Specs/latest/Rel-5/26_series

Please note the following codec version information:

  ===================================================================
   TS 26.104
   R99   V3.5.0 2003-03
   REL-4 V4.5.0 2003-06
   REL-5 V5.2.0 2003-06
   3GPP AMR Floating-point Speech Codec
  ===================================================================

=head1 AUTHOR

Nick Gerakines, E<lt>nick@socklabs.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Nick Gerakines

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
