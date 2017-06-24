package Yashulan::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Yashulan::Web::C::Restaurant;
use Yashulan::Web::C::Account;

base 'Yashulan::Web::C';

get  '/api/restaurants/:restaurant_id'   => 'Restaurant#get_the_restaurant';
get  '/api/restaurants'                  => 'Restaurant#get_restaurants_with_pager';
post '/api/account/favorite'             => 'Restaurant#get_favorites_of_the_user';
post '/api/account/signup'               => 'Account#signup';
post '/api/account/login'                => 'Account#login';
post '/api/account/post_favorite'        => 'Account#favorite';

1;
