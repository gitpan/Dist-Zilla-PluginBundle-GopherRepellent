use strict;
use warnings;
use Test::More 0.88;
# This is a relatively nice way to avoid Test::NoWarnings breaking our
# expectations by adding extra tests, without using no_plan.  It also helps
# avoid any other test module that feels introducing random tests, or even
# test plans, is a nice idea.
our $success = 0;
END { $success && done_testing; }

my $v = "\n";

eval {                     # no excuses!
    # report our Perl details
    my $want = '5.006';
    my $pv = ($^V || $]);
    $v .= "perl: $pv (wanted $want) on $^O from $^X\n\n";
};
defined($@) and diag("$@");

# Now, our module version dependencies:
sub pmver {
    my ($module, $wanted) = @_;
    $wanted = " (want $wanted)";
    my $pmver;
    eval "require $module;";
    if ($@) {
        if ($@ =~ m/Can't locate .* in \@INC/) {
            $pmver = 'module not found.';
        } else {
            diag("${module}: $@");
            $pmver = 'died during require.';
        }
    } else {
        my $version;
        eval { $version = $module->VERSION; };
        if ($@) {
            diag("${module}: $@");
            $pmver = 'died during VERSION check.';
        } elsif (defined $version) {
            $pmver = "$version";
        } else {
            $pmver = '<undef>';
        }
    }

    # So, we should be good, right?
    return sprintf('%-45s => %-10s%-15s%s', $module, $pmver, $wanted, "\n");
}

eval { $v .= pmver('Dist::Zilla','4.102345') };
eval { $v .= pmver('Dist::Zilla::Plugin::Authority','1.001') };
eval { $v .= pmver('Dist::Zilla::Plugin::Bugtracker','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::CompileTests','1.100740') };
eval { $v .= pmver('Dist::Zilla::Plugin::DualBuilders','1.001') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::DescribeVersion','0.006') };
eval { $v .= pmver('Dist::Zilla::Plugin::GitFmtChanges','0.003') };
eval { $v .= pmver('Dist::Zilla::Plugin::GithubMeta','0.10') };
eval { $v .= pmver('Dist::Zilla::Plugin::KwaliteeTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaNoIndex','1.101130') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaProvides::Package','1.11044404') };
eval { $v .= pmver('Dist::Zilla::Plugin::MinimumPerl','0.02') };
eval { $v .= pmver('Dist::Zilla::Plugin::MinimumVersionTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PkgVersion','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodCoverageTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodLinkTests','1.003') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodSpellingTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodSyntaxTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodWeaver','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::PortabilityTests','any version') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReportVersions::Tiny','1.01') };
eval { $v .= pmver('Dist::Zilla::Plugin::Repository','0.16') };
eval { $v .= pmver('Dist::Zilla::Plugin::TaskWeaver','0.101620') };
eval { $v .= pmver('Dist::Zilla::PluginBundle::Basic','any version') };
eval { $v .= pmver('Dist::Zilla::Role::PluginBundle::Easy','any version') };
eval { $v .= pmver('Dist::Zilla::Stash::PodWeaver','1.001000') };
eval { $v .= pmver('File::Find','any version') };
eval { $v .= pmver('File::Temp','any version') };
eval { $v .= pmver('Module::Build','0.3601') };
eval { $v .= pmver('Moose','any version') };
eval { $v .= pmver('Pod::Elemental','0.102360') };
eval { $v .= pmver('Pod::Elemental::Transformer::List','any version') };
eval { $v .= pmver('Pod::Weaver','3.101632') };
eval { $v .= pmver('Pod::Weaver::Config::Assembler','any version') };
eval { $v .= pmver('Pod::Weaver::Plugin::StopWords','1.000001') };
eval { $v .= pmver('Pod::Weaver::Plugin::Transformer','any version') };
eval { $v .= pmver('Pod::Weaver::Plugin::WikiDoc','any version') };
eval { $v .= pmver('Pod::Weaver::PluginBundle::Default','any version') };
eval { $v .= pmver('Pod::Weaver::Section::Support','1.001') };
eval { $v .= pmver('Test::More','0.96') };



# All done.
$v .= <<'EOT';

Thanks for using my code.  I hope it works for you.
If not, please try and include this output in the bug report.
That will help me reproduce the issue and solve you problem.

EOT

diag($v);
ok(1, "we really didn't test anything, just reporting data");
$success = 1;

# Work around another nasty module on CPAN. :/
no warnings 'once';
$Template::Test::NO_FLUSH = 1;
exit 0;
