package Moonshine::Web::Display;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ($self, $c) = @_;

    return $self->component->div;
}

1;
