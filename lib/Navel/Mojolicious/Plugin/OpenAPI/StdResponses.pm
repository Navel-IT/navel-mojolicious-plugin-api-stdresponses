# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-mojolicious-plugin-openapi-stdresponses is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Mojolicious::Plugin::OpenAPI::StdResponses 0.1;

use Navel::Base;

use Mojo::Base 'Mojolicious::Plugin';

#-> methods

sub register {
    my ($self, $application, $register_options) = @_;

    $application->helper(
        resource_not_found => sub {
            my ($controller, $resource_name) = @_;

            $controller->render(
                openapi => {
                    ok => [],
                    ko => [
                        'the resource ' . (defined $resource_name ? $resource_name . ' ' : '') . 'could not be found.'
                    ]
                },
                status => 404
            );
        }
    );

    $application->helper(
        resource_already_exists => sub {
            my ($controller, $resource_name) = @_;

            $controller->render(
                openapi => {
                    ok => [],
                    ko => [
                        'the resource ' . (defined $resource_name ? $resource_name . ' ' : '') . 'already exists.'
                    ]
                },
                status => 409
            );
        }
    );
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Mojolicious::Plugin::OpenAPI::StdResponses

=head1 COPYRIGHT

Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-mojolicious-plugin-openapi-stdresponses is licensed under the Apache License, Version 2.0

=cut
