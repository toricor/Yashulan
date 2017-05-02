package Yashulan::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

get '/:id' => sub {
    my ($c, $args) = @_;
    my $restaurant_id = $args->{id};
    my $row = $c->db->single('restaurant', {id => $restaurant_id});
        
    return $c->render_json({
             id       =>    $restaurant_id,
             name     =>    $row->name,
             station  =>    $row->station,
             genre    =>    $row->genre,
            budget_lower => $row->budget_lower,
            budget_upper => $row->budget_upper,
            lunch_or_dinner => $row->lunch_or_dinner,
            star          => $row->star,
           good          => $row->good,
          tabelog       => $row->tabelog,
         created_at => $row->created_at,
         updated_at => $row->updated_at,
    });
};
1;
