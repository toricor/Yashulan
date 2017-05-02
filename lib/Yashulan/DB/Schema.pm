package Yashulan::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'Yashulan::DB::Row';

table {
    name 'station';
    pk 'id';
    columns qw(id name);
}

table {
    name 'user';
    pk 'id';
    columns qw(id name password);
};


table {
    name 'restaurant';
    pk 'id';
    columns qw(id name station genre budget_lower budget_upper lunch_or_dinner star good tabelog author created_at updated_at);
};
table {
    name 'favorite';
    pk 'id';
    qw(id user_id restaurant_id created_at);
};

1;
