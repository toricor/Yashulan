package Yashulan:::Web::Plugin::Response;
use strict;
use warnings;
use utf8;
use Amon2::Util ();


sub init {
    my ($class, $c, $conf) = @_;
    Amon2::Util::add_method($c, 'res_400_json', \&res_400_json) unless $c->can('res_400_json'));
    Amon2::Util::add_method($c, 'res_404_json', \&res_404_json) unless $c->can('res_404_json'));
    Amon2::Util::add_method($c, 'res_nodata_json', \&res_nodata_json) unless $c->can('res_nodata_json'));
}

sub res_nodata_json { return $_[0]->render_json({statys => 'Nodata'})}

1;
