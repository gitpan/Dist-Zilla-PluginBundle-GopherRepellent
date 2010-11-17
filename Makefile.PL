
use strict;
use warnings;

BEGIN { require 5.006; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'keep those pesky gophers out of your dists!',
  'AUTHOR' => 'Randy Stauner <rwstauner@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Test::More' => '0.96'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Dist-Zilla-PluginBundle-GopherRepellent',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::PluginBundle::GopherRepellent',
  'PREREQ_PM' => {
    'Dist::Zilla' => '2.100922',
    'Dist::Zilla::Plugin::CompileTests' => '1.100740',
    'Dist::Zilla::Plugin::Git::DescribeVersion' => '0.006',
    'Dist::Zilla::Plugin::GitFmtChanges' => '0.003',
    'Dist::Zilla::Plugin::GithubMeta' => '0.10',
    'Dist::Zilla::Plugin::MetaNoIndex' => '1.101130',
    'Dist::Zilla::Plugin::MetaProvides::Package' => '1.11044404',
    'Dist::Zilla::Plugin::MinimumPerl' => '0.02',
    'Dist::Zilla::Plugin::PodWeaver' => '0',
    'Dist::Zilla::Plugin::PortabilityTests' => '0',
    'Dist::Zilla::Plugin::Repository' => '0.16',
    'Dist::Zilla::Plugin::TaskWeaver' => '0.101620',
    'Dist::Zilla::PluginBundle::Basic' => '0',
    'Dist::Zilla::Role::PluginBundle::Easy' => '0',
    'Moose' => '0',
    'Moose::Autobox' => '0',
    'Pod::Elemental::Transformer::List' => '0',
    'Pod::Weaver::Config::Assembler' => '0',
    'Pod::Weaver::PluginBundle::Default' => '0',
    'Pod::Weaver::Section::Support' => '1.000'
  },
  'VERSION' => '0.004001',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



