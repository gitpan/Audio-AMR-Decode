use 5.008006;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME           => 'Audio::AMR::Decode',
	VERSION_FROM   => 'lib/Audio/AMR/Decode.pm',
	PREREQ_PM      => {},
	ABSTRACT_FROM  => 'lib/Audio/AMR/Decode.pm',
	AUTHOR         => 'Nick Gerakines <nick@socklabs.com>',
	LIBS           => [''],
	DEFINE         => '',
	INC            => '',
	OBJECT         => '$(O_FILES)',
	OPTIMIZE       => '-O4 -Wall -DVAD1',
	CC             => 'gcc',
);
