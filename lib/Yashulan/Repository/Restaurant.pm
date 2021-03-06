package Yashulan::Repository::Restaurant;
use strict;
use utf8;
use warnings;
use Yashulan;

use Data::Page;

sub db { Yashulan->context->db };

sub fetch_by_restaurant_id_and_get_station_name {
    my ($class, $restaurant_id) = @_;
    return $class->db->search_by_sql(q{
        SELECT
            restaurant.id, restaurant.name, station.name AS station_name , genre, budget_lower, budget_upper, lunch_or_dinner, star, good, tabelog, author, created_at, updated_at
        FROM
            restaurant
        INNER JOIN
            station ON restaurant.station = station.id
        WHERE
            restaurant.id = ?    
}, [ $restaurant_id ]);
}

sub fetch_all_restaurants_and_get_station_name_with_pager {
    my ($class, $args) = @_;
    my $page  = $args->{page};
    my $limit = $args->{limit};
    my @rows  = $class->db->search_by_sql(q{
        SELECT
            restaurant.id, restaurant.name, station.name AS station_name, genre, budget_lower, budget_upper, lunch_or_dinner, star, good, tabelog, author, created_at, updated_at
        FROM
            restaurant
        INNER JOIN
            station ON restaurant.station = station.id
}, [ ]);
    my $pager = Data::Page->new(scalar(@rows), $limit, $page);
    return $pager->splice(\@rows);
}

sub fetch_favorites_by_userid {
    my ($class, $user_id) = @_;
    return $class->db->search_by_sql(q{
        SELECT
            restaurant_id
        FROM
            favorite
        WHERE
            user_id = ?
    }, [ $user_id ]);
}

1;
