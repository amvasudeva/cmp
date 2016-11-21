package Conf::Schema::DB::Result::Blueprints;
use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->table("blueprints");

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "provider_type",
  { data_type => "text", is_nullable => 1 },
  "instance_name",
  { data_type => "text", is_nullable => 1 },
  "flavor",
  { data_type => "text", is_nullable => 1 },
  "image",
  { data_type => "text", is_nullable => 1 },
  "network",
  { data_type => "text", is_nullable => 1 },
  "security_group",
  { data_type => "text", is_nullable => 1 },
  "key_pair_name",
  { data_type => "integer", is_nullable => 1 },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->meta->make_immutable;
1;
