package t::Factory::POPO;
use strict;
use warnings;
use Sledge::Factory;

class('t::POPO');

prepare_arguments {
    my ($app, $args) = @_;
    return { prepare => $args };
};

1;
