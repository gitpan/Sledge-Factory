package Sledge::Plugin::Factory;
use strict;
use warnings;
use base qw/Exporter/;
our @EXPORT = qw/factory/;
use Sledge::Utils;
use UNIVERSAL::require;

sub factory {
    my ($app, $module) = @_;

    my $base = Sledge::Utils::class2appclass($app);
    my $factory = "${base}::Factory::${module}";
    $factory->require or die $@;

    if ($factory->__per_context) {
        $app->{"__Factory::$module"} ||= _create_instance( $app, $module, $factory );
    } else {
        _create_instance( $app, $module, $factory );
    }
}

sub _create_instance {
    my ($app, $module, $factory) = @_;

    my $config = $app->create_config->{"Factory::$module"};

    my $constructor = $factory->__constructor;
    my $klass = $factory->__class;
    $klass->require or die $@;
    $klass->$constructor( $factory->__prepare_arguments->($app, $config) );
}

1;
__END__

=head1 NAME

Sledge::Plugin::Factory - factory

=head1 SYNOPSIS

    package Your::Pages;
    use Sledge::Plugin::Factory;

    sub dispatch_index {
        my $self = shift;
        $self->factory('TheSchwartz')->insert($job);
        $self->factory('TheSchwartz')->list_jobs({funcname => 'MyApp::Worker'});
    }

=head1 DESCRIPTION

Sledge plugin of Sledge::Factory.

=head1 AUTHOR

Tokuhiro Matsuno

=head1 SEE ALSO

L<Sledge::Factory>, L<Catalyst::Model::Adaptor>

