package t::POPO;
use strict;
use warnings;
use Test::More;

my $cnt = 0;

sub new {
    my ($class, $args) = @_;
    $cnt++;
    bless {%$args}, $class;
}

sub foo {
    my $self = shift;
    is_deeply $self, { prepare => { args => 1, } };
}

sub bar { $cnt }

1;
