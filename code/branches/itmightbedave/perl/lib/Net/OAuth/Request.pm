package Net::OAuth::Request;
use warnings;
use strict;
use base qw/Net::OAuth::Message/;

our $VERSION = '0.1';

__PACKAGE__->mk_classdata(required_message_params => [qw/
    consumer_key
    signature_method
    timestamp
    nonce
    /]);

__PACKAGE__->mk_classdata(optional_message_params => [qw/
    version
	signature
    /]);

__PACKAGE__->mk_classdata(required_api_params => [qw/
    request_method
    request_url
    consumer_secret
    /]);

__PACKAGE__->mk_classdata(optional_api_params => [qw/
    signature_key
    token_secret
    extra_params
    session_handle
    /]);

__PACKAGE__->mk_classdata(signature_elements => [qw/
    request_method
    request_url
    normalized_message_parameters
    /]);

__PACKAGE__->mk_classdata(all_message_params => [
    @{__PACKAGE__->required_message_params},
    @{__PACKAGE__->optional_message_params},
	]);

__PACKAGE__->mk_classdata(all_api_params => [
    @{__PACKAGE__->required_api_params},
    @{__PACKAGE__->optional_api_params},	
	]);

__PACKAGE__->mk_classdata(all_params => [
    @{__PACKAGE__->all_api_params},
    @{__PACKAGE__->all_message_params},	
	]);

__PACKAGE__->mk_accessors(
    @{__PACKAGE__->all_params},
    );

sub signature_key {
    my $self = shift;
    # For some sig methods (I.e. RSA), users will pass in their own key
    my $key = $self->get('signature_key');
    unless (defined $key) {
        $key = Net::OAuth::Message::encode($self->consumer_secret) . '&';
        $key .= Net::OAuth::Message::encode($self->token_secret) if $self->can('token_secret');
    }
    return $key;
}

=head1 NAME

Net::OAuth::Request - base class for OAuth requests

=head1 SEE ALSO

L<http://oauth.net>

=head1 AUTHOR

Keith Grennan, C<< <kgrennan at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2007 Keith Grennan, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
