package Moonshine::Web::Index;

use parent 'Dancer2::Template::Moonshine::Base';
use JSON qw/encode_json/;

sub build_html {
    my ( $self, $c ) = @_;

    my $div = $self->component->div();

    my $jumbotron = $div->add_child(
        $self->component->jumbotron(
            {
                style =>
'background: -webkit-linear-gradient(#98F36A, #D8D857); background: -o-linear-gradient(#98F36A, #D8D857); background: -moz-linear-gradient(#98F36A, #D8D857); background: linear-gradient(#98F36A, #D8D857);',
                children => [
                    {
                        action => 'h1',
                        data   => 'Build Some Moonshine',
                        txt    => 'center',
                        children =>
                          [ { action => 'glyphicon', switch => 'globe' } ],
                    },
                ],
            }
        )
    );

    my $container = $div->add_child( $self->component->container );

    my $example_data = $self->example_data;
    my $select_fg =
      $container->add_child( $self->component->form_group( { fields => [] } ) );

    my $should_be_in_a_css_class =
'height: 29px; margin-top: 2px; margin-right: 5px; background: #F8F8F7; color: #2D0000; font-size: 14px; padding: 0px 11px; border-radius: 3px; font-family: initial; box-sizing: border-box;';
    my $select = $select_fg->add_child(
        {
            tag   => 'select',
            class => 'selectpicker pull-right',
            style => $should_be_in_a_css_class . 'margin-right:0;',
            onchange =>
"var ta = document.getElementById('buildMoonshine'); var o = JSON.parse(this.value); ta.value = JSON.stringify(o, undefined, 4);",
        }
    );
    $select->add_child(
        { tag => 'option', data => 'Select an Example', value => '', } );

    for ( @{$example_data} ) {
        $select->add_child(
            {
                tag   => 'option',
                data  => $_->{name},
                value => $_->{moon_struct},
            }
        );
    }

    my %generic_for_this_button = (
        sizing => 'sm',
        class  => 'pull-right',
        style  => $should_be_in_a_css_class,
    );

    $select_fg->add_child(
        $self->component->button(
            {
                data => 'Format Json',
                onclick =>
"var ta = document.getElementById('buildMoonshine'); var o = JSON.parse(ta.value); ta.value = JSON.stringify(o, undefined, 4);",
                %generic_for_this_button
            }
        )
    );

    $select_fg->add_child(
        $self->component->button(
            {
                data => 'Clear TextArea',
                onclick =>
"var ta = document.getElementById('buildMoonshine'); ta.value = ''",
                %generic_for_this_button
            }
        )
    );

    my $text_area_placeholder =
"{&#10;\t&quot;action&quot;:&quot;glyphicon&quot;,&#10;\t&quot;switch&quot;:&quot;search&quot;&#10;}";
    if ( $c->{request}->{env}->{HTTP_USER_AGENT} =~ /firefox/gi ) {
        $text_area_placeholder =
'{ &quot;action&quot;:&quot;glyphicon&quot;, &quot;switch&quot;:&quot;search&quot; }';
    }

    my $form = $container->add_child(
        $self->component->form(
            {
                action   => '/display',
                method   => 'post',
                enctype  => 'application/json',
                children => [
                    {
                        action   => 'form_group',
                        children => [
                            {
                                action => 'label',
                                for    => 'buildMoonshine',
                                class  => 'pull-left',
                                data => 'Insert your (JSON) data struct below',
                            },
                            {
                                action      => 'input',
                                name        => 'buildMoonshine',
                                id          => 'buildMoonshine',
                                tag         => 'textarea',
                                style       => 'min-height:150px;',
                                placeholder => $text_area_placeholder,
                                onkeydown =>
"if(event.keyCode===9){var v=this.value,s=this.selectionStart,e=this.selectionEnd;this.value=v.substring(0, s)+'\t'+v.substring(e);this.selectionStart=this.selectionEnd=s+1;return false;}"
                            }
                        ],
                        fields => [],
                    },
                    {
                        action => 'input',
                        type   => 'submit',
                    }
                ],
            }
        )
    );

    return $div;
}

sub example_data {
    my $jumbotron = encode_json(
        {
            action   => 'jumbotron',
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
        }
    );

    $jumbotron =~ s/\"/\&quot;/g;

    my @example_data = (
        {
            name        => 'Jumbotron',
            moon_struct => $jumbotron,
        }
    );

    return \@example_data;
}

1;
