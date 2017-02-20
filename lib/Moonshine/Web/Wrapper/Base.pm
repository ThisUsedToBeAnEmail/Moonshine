package Moonshine::Web::Wrapper::Base;

use parent 'Dancer2::Template::Moonshine::Base';

sub build_html {
    my ( $self, $c ) = @_;

    my $nav = {
        action   => 'div',
        children => [
            {
                action   => 'p',
                children => [
                    {
                        action => 'a',
                        href   => 'https://www.lnation.org',
                        data   => 'LNATION 2017',
                    }
                ]
            },
            {
                action => 'h1',
                data   => 'Rock God',
                txt    => 'center',
                children =>
                  [ { action => 'glyphicon', switch => 'headphones' } ],
            },
        ],
    };

    my $base_element = $self->component->basic_template(
        {
            style  => 'background: #000',
            header => [
                {
                    action => 'title',
                    data   => 'Moonshine',
                },
                {
                    action => 'link',
                    href   => 'css/bootstrap.css',
                    rel    => 'stylesheet',
                },
                {
                    action => 'link',
                    href   => 'css/cover.css',
                    rel    => 'stylesheet',
                }
            ],
            body => [
                {
                    action   => 'div',
                    class    => 'site-wrapper',
                    children => [
                        {
                            action   => 'div',
                            class    => 'site-wrapper-inner',
                            children => [
                                {
                                    action   => 'div',
                                    class    => 'cover-container',
                                    children => [ $nav, ],
                                },
                                {
                                    action   => 'div',
                                    class    => 'inner-page',
                                    children => [ $c->{content} ],
                                },
                                {
                                    action   => 'div',
                                    class    => 'mastfoot',
                                    children => [
                                        {
                                            action   => 'div',
                                            class    => 'inner',
                                            children => [],
                                        },
                                    ]
                                }
                            ],
                        },
                    ]
                },
                {
                    action => 'script',
                    src    => 'javascripts/jquery.js',
                },
                {
                    action => 'script',
                    src    => 'javascripts/bootstrap.js',
                },
            ]
        }
    );

    return $base_element;
}

1;
