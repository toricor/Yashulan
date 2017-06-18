package Yashulan::Repository::Station;
use strict;
use utf8;
use warnings;
use Yashulan;

sub db { Yashulan->context->db };

sub fetch_station_name_by_id {
    my ($class, $station_id) = @_;
    return $class->db->single('station', {id => $station_id});
}

1;
