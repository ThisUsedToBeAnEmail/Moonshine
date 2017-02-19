package Moonshine::Web::Index;

use parent 'Dancer2::Template::Moonshine::Base';
use JSON qw/encode_json/;

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
  
	my $example_data = $self->example_data;
	my $select_fg = $container->add_child($self->component->form_group({ fields => [] }));
	my $select = $select_fg->add_child({ 
		tag => 'select', 
		class => 'pull-right', 
		style => 'color:#000; margin-botton:8px;',
		onchange => "console.log(this); var ta = document.getElementById('buildMoonshine'); ta.value = this.value;", 
	});
	$select->add_child({ tag => 'option', data => 'Select an Example', value => '', });
	for ( @{ $example_data } ) {
		$select->add_child({
			tag => 'option',
			data => $_->{name},
			value => $_->{moon_struct},	
		});
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
							class => 'pull-left',
                            data => 'Insert your (JSON) data struct below',  
                        },
                        {
                            action => 'input',
                            name => 'buildMoonshine',
							id => 'buildMoonshine',
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

sub example_data {
	my $jumbotron = encode_json({
		action => 'jumbotron',
		children => [
			{
				action => 'h1',
				data   => 'Hello, world!',
			    style  => 'color:#000',
            },
			{
				action => 'p',
				data   => 'This is jumbotron',
				style  => 'color:#000;',
			},
			{
				action => 'button',
				tag    => 'a',
				sizing => 'lg',
				href   => 'http://getbootstrap.com/components/',
				role   => 'button',
				data   => 'Learn more',
				switch => 'primary'
			},
		],
	});

    $jumbotron =~ s/\"/\&quot;/g;

	my @example_data = (
      	{
			name => 'Jumbotron',
			moon_struct => $jumbotron,
		}
	);
	
	return \@example_data;
}

1;
