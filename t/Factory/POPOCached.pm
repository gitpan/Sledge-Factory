package t::Factory::POPOCached;
use strict;
use warnings;
use Sledge::Factory;

per_context 1;

class('t::POPO');

prepare_arguments {
    my ($app, $args) = @_;
    return { prepare => $args };
};

1;
