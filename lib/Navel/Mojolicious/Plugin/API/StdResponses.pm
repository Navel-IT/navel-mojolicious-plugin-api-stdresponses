# Copyright (C) 2015-2017 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-mojolicious-plugin-api-stdresponses is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Mojolicious::Plugin::API::StdResponses 0.1;

use Navel::Base;

use Mojo::Base 'Mojolicious::Plugin';

use Navel::Utils 'croak';

#-> methods

sub register {
    my ($self, $application, $register_options) = @_;

    my $handler = sub {
        shift->stash('api.object') ? 'openapi' : 'json';
    };
    
    $application->helper(
        'navel.api.definitions.ok_ko' => sub {
            my ($controller, $ok, $ko) = @_;

            croak('ok must be a ARRAY reference') unless ref $ok eq 'ARRAY';
            croak('ko must be a ARRAY reference') unless ref $ko eq 'ARRAY';

            {
                ok => $ok,
                ko => $ko
            };
        }
    );

    $application->helper(
        'navel.api.responses.unauthorized' => sub {
            my $controller = shift;

            $controller->render(
                $handler->($controller) => $controller->navel->api->definitions->ok_ko(
                    [],
                    [
                        'unauthorized.'
                    ]
                ),
                status => 401
            );
        }
    );

    $application->helper(
        'navel.api.responses.resource_not_found' => sub {
            my ($controller, $resource_name) = @_;

            $controller->render(
                $handler->($controller) => $controller->navel->api->definitions->ok_ko(
                    [],
                    [
                        'the resource ' . (defined $resource_name ? $resource_name . ' ' : '') . 'could not be found.'
                    ]
                ),
                status => 404
            );
        }
    );

    $application->helper(
        'navel.api.responses.resource_already_exists' => sub {
            my ($controller, $resource_name) = @_;

            $controller->render(
                $handler->($controller) => $controller->navel->api->definitions->ok_ko(
                    [],
                    [
                        'the resource ' . (defined $resource_name ? $resource_name . ' ' : '') . 'already exists.'
                    ]
                ),
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

Navel::Mojolicious::Plugin::API::StdResponses

=head1 COPYRIGHT

Copyright (C) 2015-2017 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-mojolicious-plugin-api-stdresponses is licensed under the Apache License, Version 2.0

=cut
