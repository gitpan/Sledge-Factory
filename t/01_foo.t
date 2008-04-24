use strict;
use warnings;

package t::Pages;
use Test::More tests => 1;
use Sledge::Plugin::Factory;

sub new { bless { }, shift }

sub dispatch_foo {
    my $self = shift;
    $self->factory('POPO')->foo;
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

