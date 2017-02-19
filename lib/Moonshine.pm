package Moonshine;
use Dancer2;
our $VERSION = '0.1';

get '/' => sub {
    template 'Index';
};

any '/display' => sub {
    my $moon_struct = decode_json(params->{'buildMoonshine'}); 
    template 'Display', { moon_struct => $moon_struct };
};

true;
