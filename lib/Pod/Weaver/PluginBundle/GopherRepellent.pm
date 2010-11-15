package Pod::Weaver::PluginBundle::GopherRepellent;
BEGIN {
  $Pod::Weaver::PluginBundle::GopherRepellent::VERSION = '0.003011';
}
# ABSTRACT: keep those pesky gophers out of your POD!

use strict;
use warnings;

use Pod::Weaver::PluginBundle::Default ();
#use Pod::Weaver::Plugin::WikiDoc ();
use Pod::Weaver::Section::Support 1.001 (); # not on CPAN
use Pod::Elemental::Transformer::List ();

use Pod::Weaver::Config::Assembler;
sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

# TODO: use modules

our $NAME = join('', '@', (__PACKAGE__ =~ /([^:]+)$/));

sub mvp_bundle_config {
  my @plugins;
  push @plugins, (
    #[ "$NAME/WikiDoc",     _exp('-WikiDoc'), {} ],
    [ "$NAME/CorePrep",    _exp('@CorePrep'), {} ],
    [ "$NAME/Name",        _exp('Name'),      {} ],
    [ "$NAME/Version",     _exp('Version'),   {} ],

    [ "$NAME/Prelude",     _exp('Region'),  { region_name => 'prelude'     } ],
    [ "$NAME/Synopsis",    _exp('Generic'), { header      => 'SYNOPSIS'    } ],
    [ "$NAME/Description", _exp('Generic'), { header      => 'DESCRIPTION' } ],
    [ "$NAME/Overview",    _exp('Generic'), { header      => 'OVERVIEW'    } ],

    #[ "$NAME/Stability",   _exp('Generic'), { header      => 'STABILITY'   } ],
  );

  for my $plugin (
    [ 'Attributes', _exp('Collect'), { command => 'attr'   } ],
    [ 'Methods',    _exp('Collect'), { command => 'method' } ],
    [ 'Functions',  _exp('Collect'), { command => 'func'   } ],
  ) {
    $plugin->[2]{header} = uc $plugin->[0];
    push @plugins, $plugin;
  }

  push @plugins, (
    [ "$NAME/Leftovers", _exp('Leftovers'), {} ],
    [ "$NAME/postlude",  _exp('Region'),    { region_name => 'postlude' } ],

	# include Support section with various cpan links and github repo
    [ "$NAME/Support",   _exp('Support'),
		{
			repository_content => '',
			repository_link => 'both'
		}
	],

    [ "$NAME/Authors",   _exp('Authors'),   {} ],
    [ "$NAME/Legal",     _exp('Legal'),     {} ],
    [ "$NAME/List",      _exp('-Transformer'), { 'transformer' => 'List' } ],
  );

  return @plugins;
}

1;


__END__
=pod

=head1 NAME

Pod::Weaver::PluginBundle::GopherRepellent - keep those pesky gophers out of your POD!

=head1 VERSION

version 0.003011

=head1 SYNOPSIS

	# weaver.ini

	[@GopherRepellent]

or with a dist.ini like so:

	# dist.ini

	[@GopherRepellent]

you don't need a weaver.ini at all.

=head1 DESCRIPTION

This PluginBundle is like the @Default
with the following additions:

=over 4

=item *

Inserts a SUPPORT section to the POD just before AUTHOR

=item *

Adds the List Transformer

=back

It is roughly equivalent to:

	[@CorePrep]               ; [@Default]

	[Name]                    ; [@Default]
	[Version]                 ; [@Default]

	[Region  / prelude]       ; [@Default]

	[Generic / SYNOPSIS]      ; [@Default]
	[Generic / DESCRIPTION]   ; [@Default]
	[Generic / OVERVIEW]      ; [@Default]

	[Collect / ATTRIBUTES]    ; [@Default]
	command = attr

	[Collect / METHODS]       ; [@Default]
	command = method

	[Collect / FUNCTIONS]     ; [@Default]
	command = func

	[Leftovers]               ; [@Default]

	[Region  / postlude]      ; [@Default]

	; custom section
	[Support]                 ; =head1 SUPPORT (bugs, cpants, git...)
	repository_content =
	repository_link = both

	[Authors]                 ; [@Default]
	[Legal]                   ; [@Default]

	[-Transformer]            ; =for :list
	transformer = List

=for Pod::Coverage mvp_bundle_config

=head1 AUTHOR

Randy Stauner <rwstauner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Randy Stauner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

