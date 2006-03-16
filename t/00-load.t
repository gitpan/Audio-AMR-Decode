
use Test::More tests => 4;

use_ok('Audio::AMR::Decode');

ok(! Audio::AMR::Decode::amr2raw('test.amr', 'test.raw'), 'file conversion - good');

ok(-s 'test.raw', 'output file exists - good');
ok(unlink 'test.raw');