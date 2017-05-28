package Yashulan::Web::C::Account;
use strict;
use warnings;
use utf8;

use Yashulan;
#use Yashulan::Repository:: ;
use DDP;

sub signup {
    my ($class, $c) = @_;
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

sub login {
    my ($class, $c) = @_;
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

sub favorite {
    my ($class, $c) = @_;
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
