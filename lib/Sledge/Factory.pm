package Sledge::Factory;
use strict;
use warnings;
use base qw/Class::Data::Inheritable/;
use 5.00800;
our $VERSION = '0.03';
use constant false => 0;

sub import {
    my $pkg = caller(0);

    no strict 'refs';
    unshift @{"$pkg\::ISA"}, "Class::Data::Inheritable";
    $pkg->mk_classdata('__prepare_arguments' => sub {
        my ($class, $app, $args) = @_;
        $args;
    });
    $pkg->mk_classdata('__class' => undef);
    $pkg->mk_classdata('__constructor' => 'new');
    $pkg->mk_classdata('__per_context' => false);

    *{"$pkg\::per_context"} = sub {
        $pkg->__per_context(shift);
    };
    *{"$pkg\::class"} = sub ($) {
        $pkg->__class(shift);
    };
    *{"$pkg\::prepare_arguments"} = sub (&) {
        $pkg->__prepare_arguments(shift);
    };
}

1;
__END__

=for stopwords TheSchwartz

=encoding utf8

=head1 NAME

Sledge::Factory - the factory.

=head1 SYNOPSIS

    package YourProj::Factory::TheSchwartz;
    use strict;
    use warnings;
    use Sledge::Factory;

    class "TheSchwartz";

    prepare_arguments {
        my ($app, $args) = @_;
        %$args;
    };

    1;

=head1 DESCRIPTION

Sledge::Factory is factory module for Sledge.

This is inspire of L<Catalyst::Model::Adaptor>

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

L<Catalyst::Model::Adaptor>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
