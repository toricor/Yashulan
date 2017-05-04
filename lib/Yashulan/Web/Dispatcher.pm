package Yashulan::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

get '/api/:id' => sub {
    my ($c, $args) = @_;
    my $restaurant_id = $args->{id};
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

get '/api' => sub {
    my ($c, $args) = @_;
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
get '/' => sub {
    my ($c) = @_;
    return $c->redirect('/api');
};

1;
