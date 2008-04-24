use inc::Module::Install;
name 'Sledge-Factory';
all_from 'lib/Sledge/Factory.pm';

requires "Class::Data::Inheritable";
requires 'Exporter';
requires 'Sledge::Utils';
requires 'UNIVERSAL::require';

build_requires 'Test::More';
build_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
