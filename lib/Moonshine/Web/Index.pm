package Moonshine::Web::Index;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ($self, $c) = @_;

    my $jumbotron = $self->component->jumbotron({
        children => [ 
            {
                action => 'h1', 
                data => 'Rock God',
                txt => 'center',
                children => [
                     { action => 'glyphicon', switch => 'headphones' } 
                ],
            },
        ],
    });
    
    return $jumbotron;
}

1;
