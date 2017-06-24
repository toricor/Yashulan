<template>
  <div class="root">
    <h1>レストラン一覧</h1>
      <button v-on:click="greet">Greet</button>
      <button v-on:click="genNextPageLink">g</button>
      
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
export default {
  name: 'root',
  data () {
    return {
      restaurants: axios
          .get('/api/restaurants')
          .then(res => {
            this.$data.restaurants = res.data
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
    },
    genNextPageLink: function () {
      console.log(this)
      alert(this)
    },
    getCurrentPage: function () {
      alert()
    },
    genPreviousPageLink: function () {
      alert()
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
