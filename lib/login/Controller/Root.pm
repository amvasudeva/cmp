package login::Controller::Root;
use Moose;
use namespace::autoclean;

use login::Model::DB;

#- dbh Attribute
has 'dbh' => (
    isa      => 'login::Model::DB',
    is       => 'rw',
    required => 1,
    default  => sub { login::Model::DB->new() }
);


BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

login::Controller::Root - Root Controller for login

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $params = $c->request->parameters();
    $self->_config_db( $c );
    my $ra_db = $self->dbh();
    $c->log->debug("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"); 
    $c->log->debug($params); 
    $c->log->debug("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG"); 
    my $user_details  = $ra_db->resultset('LoginDetails')->get_user_details($params)->first();

    if ($user_details) {
        $c->stash(
            'user'    => $user_details,
        );
    }

    

    $c->stash->{template} = 'welcome.tt2';
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'not_found.tt2';
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}


sub _config_db {
    my (
        $self,
        $c,
        $db_name
    ) = @_;

    my $db_config = $c->config->{ 'site::DB' };
    my $dns_info  = $c->config->{ 'dsn_info' };
    
    my $dsn = $dns_info->{'dbi'}
      . ':' . $dns_info->{'database'}
      . ':' . $dns_info->{'host'}
      . ':' . $dns_info->{'port'};

    $db_config->{'connect_info'}->{'dsn'} = $dsn;
    my $dbh = login::Model::DB->new( $db_config );
    $self->dbh( $dbh );
}



=head1 AUTHOR

om,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub register : Local {
    my ( $self, $c ) = @_;
    my $params = $c->request->parameters();
    $self->_config_db( $c );
    my $app_db = $self->dbh();
    $c->stash(
        'template'     => 'register.tt2'
    );

}



sub create_user: Local {
    my ( $self, $c ) = @_;
    my $params = $c->request->parameters();
    $self->_config_db( $c );
    my $app_db = $self->dbh();
    use Data::Dumper;
    my $user;
    my $user_details  = $app_db->resultset('LoginDetails')->search({user_name => $params->{user_name}});
    my $size = scalar($user_details);
    if($size > 0){
	$c->stash( user_exists => 1 );
    }else{
	$user = {
		user_name   	=> $params->{user_name},
		login_user_pass => $params->{password},
		first_name  	=> $params->{first_name},
		last_name   	=> $params->{last_name}
	};
	$c->stash( user_created_successfully => 1 );
        $app_db->resultset('LoginDetails')->create($user);
	$c->redirect('/login');
    }
    $c->stash(
        'template'     => 'register.tt2'
    );

}

sub check :Local {
    my ( $self, $c ) = @_;
    my $params = $c->request->parameters();
    $self->_config_db( $c );
    my $app_db = $self->dbh();
    my $user_details  = $app_db->resultset('LoginDetails')->get_user_details($params)->first();

    if ($user_details) {
        $c->stash(
            'user'    => $user_details,
            'template'     => 'success.tt2'
        );
    }
    else{
        $c->stash(
            'error'    => 1,
            'template'     => 'login.tt2'
        );

    }
}

sub create_blueprint :Local { 
    my ( $self, $c ) = @_;
    my $params = $c->request->parameters();
    $self->_config_db( $c );
    my $app_db = $self->dbh();

    use Data::Dumper;
    $c->log->debug(Dumper $params);
    my $user_details  = $app_db->resultset('LoginDetails')->get_user_details({ id=>$params->{user_id},})->first();
    my $blue_print_exists = $app_db->resultset('Blueprints')->search( { instance_name => $params->{instance_name} } )->single;
    $c->log->debug(Dumper $blue_print_exists);
    
    if(!$blue_print_exists){
	   my $blueprint = $app_db->resultset('Blueprints')->create($params);
	   $c->log->debug("Blueprint created");
    }

    $c->stash(
        'user'    => $user_details,
        'template'     => 'success.tt2'
    );
    
}





__PACKAGE__->meta->make_immutable;

1;
