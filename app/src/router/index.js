import Vue from 'vue'
import Router from 'vue-router'
import Root from '@/components/Root'
import Restaurant from '@/components/Restaurant'
import Signin from '@/components/Signin'
import Login from '@/components/Login'
import Favorite from '@/components/Favorite'
import Station from '@/components/Station'
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/restaurants',
      name: 'Root',
      component: Root
    },
    {
      path: '/restaurants/:restaurant_id',
      name: 'Restaurant',
      component: Restaurant
    },
    {
      path: '/station/:station_id',
      name: 'Station',
      component: Station
    },
    {
      path: '/account/signup',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/account/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/account/favorite',
      name: 'Favorite',
      component: Favorite
    }
  ]
})
