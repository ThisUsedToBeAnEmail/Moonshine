package Dancer2::Template::Moonshine;

use Moo;

with 'Dancer2::Core::Role::Template';

has '+default_tmpl_ext' => (
    default => sub { 'pm' },
);

has '+layout_dir' => (
    default => sub { 'Wrapper' },
);

has 'components' => (
    is => 'ro',
    lazy => 1,
    builder => 1,
);

sub _build_components {
    return Moonshine::Bootstrap::v3->new;
}

sub render {
    my ($self, $file, $tokens) = @_;

    my $template = require_template($file);
     
    my $html = $template->new({ %{$tokens}, components => $self->components });

    return $tokens->{content} ? $html->render : $html->element;
}

sub require_template {
    my ($file) = @_;
    $file =~ s/^lib\///;
    !$INC{$file} and require $file;
    $file =~ s/\//::/g;
    $file =~ s/\.pm$//g;
    return $file;
} 

1;
