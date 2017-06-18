package Yashulan::Web::C::Station;
use strict;
use utf8;
use warnings;

use Data::Page;
use Yashulan;
use Yashulan::Repository::Station;

sub get_station_name_by_id {
    my ($class, $c, $args) = @_;
    my $station_id = $args->{station_id};
    my $row = Yashulan::Repository::Station->fetch_station_name_by_id($station_id)
        or return $c->res_nodata_json;    
    return $c->render_json({
        name => $row->name,
    });
};

1;
