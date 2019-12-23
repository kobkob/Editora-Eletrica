use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'EditoraEletrica',
    license             => 'lgpl3',
    dist_author         => 'Monsenhor <monsenhor@cpan.org>',
    dist_version_from   => 'lib/EditoraEletrica.pm',
    requires => {
        'Test::More'            => 0,
        'version'               => 0,
        "Carp"                  => 0,
        "Mojolicious"           => 0,
        "Pithub"                => 0,
        "Encode"                => 0,
        "MIME::Base64"          => 0,
        "Text::MultiMarkdown"   => 0,
    },
    add_to_cleanup      => [ 'EditoraEletrica-*' ],
);

$builder->create_build_script();
