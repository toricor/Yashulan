package Yashulan::Web::C::Restaurant;
use strict;
use utf8;
use warnings;

use Yashulan;
#use Yashulan::Repository::  ;

sub get_the_restaurant {
    my ($class, $c, $args) = @_;
    my $restaurant_id = $args->{restaurant_id};
    my $row = $c->db->single('restaurant', {id => $restaurant_id});
        
    return $c->render_json({
        id              => $restaurant_id,
        name            => $row->name,
        station         => $row->station,
        genre           => $row->genre,
        budget_lower    => $row->budget_lower,
        budget_upper    => $row->budget_upper,
        lunch_or_dinner => $row->lunch_or_dinner,
        star            => $row->star,
        good            => $row->good,
        tabelog         => $row->tabelog,
        created_at      => $row->created_at,
        updated_at      => $row->updated_at,
    });
};

sub get_restaurants {
    my ($class, $c, $args) = @_;
    my @rows = $c->db->search('restaurant');
    return $c->render_json([
        map {
            +{		 
                 id              => $_->id,
                 name            => $_->name,
                 station         => $_->station,
                 genre           => $_->genre,
                 budget_lower    => $_->budget_lower,
                 budget_upper    => $_->budget_upper,
                 lunch_or_dinner => $_->lunch_or_dinner,
                 star            => $_->star,
                 good            => $_->good,
                 tabelog         => $_->tabelog,
                 created_at      => $_->created_at,
                 updated_at      => $_->updated_at,
                }
            } @rows
        ]
    );
};

sub get_favorites_of_the_user {
    my ($class, $c) = @_;
    my $user_id = $c->req->parameters->{user_id};
    my @rows = $c->db->search_by_sql(q{
        SELECT
            restaurant_id
        FROM
            favorite
        WHERE
            user_id = ?
    }, [ $user_id ]);
    
    return $c->render_json([
        map {
            +{
                restaurant_id => $_->restaurant_id 
            }
        } @rows
     ]
  ); 
};

1;
