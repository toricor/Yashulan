import Vue from 'vue'
import Router from 'vue-router'
import Root from '@/components/Root'
import Restaurant from '@/components/Restaurant'
import Login from '@/components/Login'
import Favorite from '@/components/Favorite'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Root',
      component: Root
    },
    {
      path: '/:restaurant_id',
      name: 'Restaurant',
      component: Restaurant
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/favorite',
      name: 'Favorite',
      component: Favorite
    }
  ]
})
