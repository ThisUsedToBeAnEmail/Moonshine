package Moonshine::Web::Wrapper::Base;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html { 
    my ($self, $c) = @_;

    my $base_element = $self->component->basic_template({ 
        style => 'background: #000',
        header => [
            {
                action => 'title',
                data => 'Moonshine',
            },
            {
                action => 'link',
                href => 'css/bootstrap.css',
                rel => 'stylesheet',
            }
        ],
        body => [
            $c->{content},
            {
                action => 'script',
                src => 'javascripts/jquery.js',  
            },
            {   
                action => 'script',
                src => 'javascripts/bootstrap.js',
            },   
        ]
    });

    return $base_element;
}

1;
