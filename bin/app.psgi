#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use Module::Find;
use lib "$FindBin::Bin/../lib";

BEGIN {
    use Moonshine;
    use Moonshine::Bootstrap::v3;
}

Moonshine->dance;
