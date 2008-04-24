package Sledge::Plugin::Factory;
use strict;
use warnings;
use base qw/Exporter/;
our @EXPORT = qw/adaptor/;
use Sledge::Utils;
use UNIVERSAL::require;

sub adaptor {
    my ($app, $module) = @_;

    my $base = Sledge::Utils::class2appclass($app);
    my $adaptor = "${base}::Factory::${module}";
    $adaptor->require or die $@;

    if ($adaptor->__per_context) {
        $app->{"__Factory::$module"} ||= _create_instance( $app, $module, $adaptor );
    } else {
        _create_instance( $app, $module, $adaptor );
    }
}

sub _create_instance {
    my ($app, $module, $adaptor) = @_;

    my $config = $app->create_config->{"Factory::$module"};

    my $constructor = $adaptor->__constructor;
    my $klass = $adaptor->__class;
    $klass->require or die $@;
    $klass->$constructor( $adaptor->__prepare_arguments->($app, $config) );
}

1;
__END__

=head1 NAME

Sledge::Plugin::Factory - adaptor

=head1 SYNOPSIS

    package Your::Pages;
    use Sledge::Plugin::Factory;

    sub dispatch_index {
        my $self = shift;
        $self->adaptor('TheSchwartz')->insert($job);
        $self->adaptor('TheSchwartz')->list_jobs({funcname => 'MyApp::Worker'});
    }

=head1 DESCRIPTION

Sledge plugin of Sledge::Factory.

=head1 AUTHOR

Tokuhiro Matsuno

=head1 SEE ALSO

L<Sledge::Factory>, L<Catalyst::Model::Adaptor>

