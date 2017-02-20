package Moonshine::Web::Display;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ($self, $c) = @_;

    my $struct = $c->{moon_struct};
    
    my $container = $self->component->container();

    # 'action' should probably be 'component'
    my $action;
    unless ($action = delete $struct->{action}) {
        $container->add_child(
            $self->component->alert({
                switch => 'error',
                data => 'No "action" found, I was trying to - delete YOUR_INVALID_STRUCT->{action}',            
            }) 
        );
        $container->add_child(
            $self->component->input({
                type => 'button',
                value => 'Lets try again?',
                onclick => 'window.history.back()'
            })
        );
        return $container;
    }

    my $component = eval { 
        $self->component->$action($struct) 
    };

    if (my $bad_struct = $@) {
        $container->add_child(
            $self->component->alert({
                switch => 'error',
                data => sprintf 'Your data struct was bad it made Moonshine::Bootstrap::v3 cry - %s', $bad_struct,            
            }) 
        );
        return $container;       
    }
    
    $container->add_child($component);
    
    return $container;
}

1;
