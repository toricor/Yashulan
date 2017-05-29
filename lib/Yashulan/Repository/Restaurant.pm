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
