use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'EditoraEletrica',
    AUTHOR              => 'Monsenhor <monsenhor@cpan.org>',
    VERSION_FROM        => 'lib/EditoraEletrica.pm',
    ABSTRACT_FROM       => 'lib/EditoraEletrica.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
        "Carp"                  => 0,
        "Mojolicious"           => 0,
        "Pithub"                => 0,
        "Encode"                => 0,
        "MIME::Base64"          => 0,
        "Text::MultiMarkdown"   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'EditoraEletrica-*' },
);
