use strict;
use warnings;

# tests mofedge style ->base_name method.

package t::Tondemonai;
use Test::More tests => 1;
use Sledge::Plugin::Factory;

sub new { bless { }, shift }

sub base_name { 't' }

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

t::Tondemonai->new->dispatch_foo;

