package Yashulan::Web::C::Restaurant;
use strict;
use utf8;
use warnings;

use Yashulan;
use Yashulan::Repository::Restaurant;

sub get_the_restaurant {
    my ($class, $c, $args) = @_;
    my $restaurant_id = $args->{restaurant_id};
    my $row = Yashulan::Repository::Restaurant->fetch_by_restaurant_id_and_get_station_name($restaurant_id)
        or return $c->res_nodata_json;    
    return $c->render_json({
        id              => $restaurant_id,
        name            => $row->name,
        station         => $row->station_name,
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

sub get_restaurants_with_pager {
    my ($class, $c, $args) = @_;
    
    my $params = $c->req->parameters; 
    my $page  = $params->{page}  || 1;
    my $limit = $params->{limit} || 20;
    
    my @rows = Yashulan::Repository::Restaurant->fetch_all_restaurants_and_get_station_name_with_pager(
        {
           page  => $page,
           limit => $limit,
        }
    ) or return $c->res_nodata_json;
    
    return $c->render_json([
        map {
            +{		 
                 id              => $_->id,
                 name            => $_->name,
                 station         => $_->station_name,
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
    my @rows = Yashulan::Repository::Restaurant->fetch_favorites_by_userid($user_id)
        or return $c->res_nodata_json;
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
