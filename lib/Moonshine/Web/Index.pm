package Moonshine::Web::Index;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ($self, $c) = @_;

    my $div = $self->component->div();

    my $jumbotron = $div->add_child(
        $self->component->jumbotron({
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
        })
    );
    
    my $container = $div->add_child($self->component->container);

    my $form = $container->add_child(
        $self->component->form({
            action => '/display',
            method => 'post',
            enctype => 'application/json',
            children => [
                {
                    action   => 'form_group',
                    children => [
                        {
                            action => 'label',
                            for => 'buildMoonshine',  
                            data => 'Insert your data struct below',  
                        },
                        {
                            action => 'input',
                            name => 'buildMoonshine',
                            tag => 'textarea',
                            style => 'min-height:200px;',
                            onkeydown => "if(event.keyCode===9){var v=this.value,s=this.selectionStart,e=this.selectionEnd;this.value=v.substring(0, s)+'\t'+v.substring(e);this.selectionStart=this.selectionEnd=s+1;return false;}"
                        }
                    ],
                    fields => [], 
                },
                {
                    action => 'submit_button',
                    class => 'center-block',
                }
            ],
        })
    );

    return $div;
}

1;
