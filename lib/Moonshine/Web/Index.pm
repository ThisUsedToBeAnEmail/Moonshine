package Moonshine::Web::Index;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ($self, $c) = @_;

    my $div = $self->component->div();

    my $jumbotron = $div->add_child(
        $self->component->jumbotron({
            style => 'background: -webkit-linear-gradient(#98F36A, #D8D857); background: -o-linear-gradient(#98F36A, #D8D857); background: -moz-linear-gradient(#98F36A, #D8D857); background: linear-gradient(#98F36A, #D8D857);',
            children => [ 
                {
                    action => 'h1', 
                    data => 'Build Some Moonshine',
                    txt => 'center',
                    children => [
                        { action => 'glyphicon', switch => 'globe' } 
                    ],
                },
            ],
        })
    );
    
    my $container = $div->add_child($self->component->container);

    my $text_area_placeholder = "{&#10;\t&quot;action&quot;:&quot;glyphicon&quot;,&#10;\t&quot;switch&quot;:&quot;search&quot;&#10;}";
    if ($c->{request}->{env}->{HTTP_USER_AGENT} =~ /firefox/gi) {
        $text_area_placeholder = '{ &quot;action&quot;:&quot;glyphicon&quot;, &quot;switch&quot;:&quot;search&quot; }';
    }
  
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
                            data => 'Insert your (JSON) data struct below',  
                        },
                        {
                            action => 'input',
                            name => 'buildMoonshine',
                            tag => 'textarea',
                            style => 'min-height:150px;',
                            placeholder => $text_area_placeholder,
                            onkeydown => "if(event.keyCode===9){var v=this.value,s=this.selectionStart,e=this.selectionEnd;this.value=v.substring(0, s)+'\t'+v.substring(e);this.selectionStart=this.selectionEnd=s+1;return false;}"
                        }
                    ],
                    fields => [], 
                },
                {
                    action => 'input',
                    type => 'submit',
                }
            ],
        })
    );

    return $div;
}

1;
