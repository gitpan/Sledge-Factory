use inc::Module::Install;
name 'Sledge-Factory';
all_from 'lib/Sledge/Factory.pm';

requires $_ for (qw/
/);

build_requires 'Test::More';
build_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
