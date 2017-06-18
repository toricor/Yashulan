package Yashulan::Repository::Restaurant;
use strict;
use utf8;
use warnings;
use Yashulan;

sub db { Yashulan->context->db };

sub fetch_by_restaurant_id {
    my ($class, $restaurant_id) = @_;
    return $class->db->single('restaurant', {id => $restaurant_id});

}

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
sub fetch_all_restaurants_and_get_station_name {
    my ($class, $restaurant_id) = @_;
    return $class->db->search_by_sql(q{
        SELECT
            restaurant.id, restaurant.name, station.name AS station_name, genre, budget_lower, budget_upper, lunch_or_dinner, star, good, tabelog, author, created_at, updated_at
        FROM
            restaurant
        INNER JOIN
            station ON restaurant.station = station.id
}, [ ]);
}

sub fetch_all_restaurants {
    my ($class) = @_;
    return $class->db->search('restaurant');
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
