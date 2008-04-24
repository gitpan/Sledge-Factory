use strict;
use warnings;

package t::Pages;
use Sledge::Plugin::Factory;
use Test::More tests => 4;

sub new { bless { }, shift }

sub dispatch_foo {
    my $self = shift;
    is $self->adaptor('POPO')->bar, 1;
    is $self->adaptor('POPO')->bar, 2;

    is $self->adaptor('POPOCached')->bar, 3;
    is $self->adaptor('POPOCached')->bar, 3; # not incremented here.
}

sub create_config {
    {
        'Factory::POPO' => {
            args => 1,
        }
    }
}

package main;

t::Pages->new->dispatch_foo;

