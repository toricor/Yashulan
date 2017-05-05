package Yashulan::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

get '/api/restaurants/:restaurant_id' => sub {
    my ($c, $args) = @_;
    my $restaurant_id = $args->{restaurant_id};
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

get '/api/restaurants' => sub {
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

get '/api/restaurants/favorite/:user_id' => sub {
    my ($c, $args) = @_;
    my $user_id = $args->{user_id};
    my @rows = $c->db->search_by_sql(q{
        SELECT
            restaurant_id
        FROM
            favorite
        WHERE
            user_id = ?
    }, [ $user_id ]);
    
    return $c->render_json([
        map {
            +{
                restaurant_id => $_->restaurant_id 
            }
        } @rows
     ]
  ); 
};

post '/api/account/signup' => sub {
    my ($c) = @_;
    my $name   = $c->req->parameters->{name};
    my $password = $c->req->parameters->{password};
    
    my $row = $c->db->single('user', {name => $name});
    if ($row){
        return $c->render_json({
            response => -1,
            message  => 'same user同じユーザー名があります',
        });
    }
    if (!$password){
        return $c->render_json({
            response => -1,
            message  => 'blank passwordパスワードを入力してください',
        });
    }
    my $id = $c->db->insert('user', {
        name => $name,
        password => $password,
        created_at => '2000-01-01'
    });
    
    return $c->render_json([
        response => 1,
        name     => $name,
    ]); 
};

post '/api/account/login' => sub {
    my ($c) = @_;
    my $name     = $c->req->parameters->{name};
    my $password = $c->req->parameters->{password};
    
    my $row = $c->db->single('user', {name => $name}, {password => $password});
    unless ($row) {
        return $c->render_json([
            response => -1,
            message  => 'user id not foundユーザーIDが見つかりません'
        ]);
    }
    return $c->render_json([
        response => 1,
        id       => $row->id,
        name     => $name,
    ]);
};

post '/api/account/favorite' => sub {
    my ($c) = @_;
    my $user_id = $c->req->parameters->{user_id};
    my $restaurant_id = $c->req->parameters->{restaurant_id};
    my @rows = $c->db->search_by_sql(q{ 
        SELECT
            user_id, restaurant_id
        FROM
            favorite
        WHERE 
            user_id = ?
        AND
            restaurant_id = ?
    }, [ $user_id, $restaurant_id ], 'favorite');
   
    if (@rows){
        return $c->render_json([
           response => -1,
           message  => 'already on listお気に入りに登録済みです',
        ]);
    }; 
    
    $c->db->insert('favorite', {
        user_id => $user_id,
        restaurant_id => $restaurant_id,
        created_at => '2000-01-01'
    });
    return $c->render_json([
        response => 1,
    ]);
};

1;
