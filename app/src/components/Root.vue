<template>
  <div class="root">
    <h1>レストラン一覧</h1>
      <button v-on:click="greet">Greet</button>
      <div class="pager">
        <h3>
          <a v-if="page * 1 > 1" v-bind:href=previousPageLink>{{ page * 1 - 1 }}</a>
          {{ page }}
          <a v-bind:href=nextPageLink>{{ page * 1 + 1 }}</a>
        </h3>
      </div>    
      <ul>
        <li v-for="restaurant in restaurants">
          <div>
            <h2><router-link :to="{name: 'Restaurant', params: { restaurant_id: restaurant.id} }">{{ restaurant.name }}</router-link></h2> 
       <p>{{ restaurant.star }}({{ restaurant.genre }})</p>
         <table>
           <tr><td>駅:</td><td> {{restaurant.station }}</td></tr>
           <tr><td>グッド！:</td><td> {{ restaurant.good }}</td></tr>
           <tr><td>tabelog:</td><td> {{ restaurant.tabelog }}</td></tr>
           <tr><td>作成日:</td><td> {{restaurant.created_at }}</td></tr>
           <tr><td>更新日:</td><td> {{restaurant.updated_at }}</td></tr>
         </table>
         </div>
     </li>  
    </ul>
    <router-link to="/account/login" v-if="!cookie.name">Log In</router-link>
    <p v-if="cookie.name">{{ cookie.name }}さんこんにちは<br>
      <router-link to="/account/favorite">お気に入りリスト</router-link>
      <router-link to="/account/logout">Log Out</router-link>
    </p>    
  </div>
</template>

<script>
const vuecookie = require('vue-cookies')
const axios = require('axios')
const qs = require('querystringify')
const query = qs.parse(window.location.search)
const page = Number(query['page']) || 1

export default {
  name: 'root',
  data () {
    return {
      page: page,
      nextPageLink: '/restaurants' + qs.stringify({ page: page + 1 }, true),
      previousPageLink: '/restaurants' + qs.stringify({ page: page - 1 }, true),
      restaurants: axios
          .get('/api/restaurants', {
            params: {
              page: page
            }
          })
          .then(res => {
            this.$data.restaurants = res.data
          })
          .catch(function (error) {
            console.log(error)
          }),
      cookie: {
        id: vuecookie.get('id'),
        name: vuecookie.get('name')
      }
    }
  },
  methods: {
    greet: function (event) {
      alert('Hello')
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
