<template>
  <div class="restaurant">
    <h1>{{ restaurant.name }}</h1>
      <table>
        <tr><th>最寄駅</th><td>{{ restaurant.station }}</td></tr>
        <tr><th>カテゴリ</th><td>{{ restaurant.genre }}</td></tr>
        <tr><th>予算</th><td>{{ restaurant.budget_lower }}～{{restaurant.budget_upper }}円 ({{ restaurant.lunch_or_dinner ? 'ランチ' : 'ディナー' }})</td></tr>
        <tr><th>星</th><td><b>{{ restaurant.star }}</b>/5.0</td></tr>
        <tr><th>グッド！</th><td>{{ restaurant.good }}</td></tr>
        <tr v-if=restaurant.tabelog><th>たべログ</th><td><a v-bind:href=restaurant.tabelog>{{ restaurant.tabelog }}</a></td></tr>
        <tr><th>作成日</th><td>{{ restaurant.created_at }}</td></tr>
        <tr><th>更新日</th><td>{{ restaurant.updated_at }}</td></tr>
      </table>
      <button v-if="cookie.id" v-on:click="add_favorite">{{ txt.favorite }}</button>
      <p v-if="err.catch"><span style="color:red">{{ error.message }}</span></p>
    <router-link to="/restaurants">一覧へ</router-link>
  </div>
</template>

<script>
const axios = require('axios')
const vuecookie = require('vue-cookies')
export default {
  name: 'restaurant',
  data () {
    return {
      restaurant: axios
        .get('/api/restaurants/' + this.$route.params.restaurant_id)
        .then(res => {
          this.$data.restaurant = res.data
        }),
      cookie: {
        id: vuecookie.get('id'),
        name: vuecookie.get('name')
      },
      err: {
        catch: false,
        message: null
      },
      txt: {
        favorite: 'お気に入り登録'
      }
    }
  },
  methods: {
    add_favorite: function () {
      var params = new URLSearchParams()
      params.append('user_id', this.$data.cookie.id)
      params.append('restaurant_id', this.$data.restaurant.id)
      this.$data.txt.favorite = '登録中'
      axios.post('/api/account/favorite', params)
      .then(res => {
        console.log(res.data)
        if (res.data.response === -1) {
          this.$data.txt.favorite = 'お気に入り登録済'
          this.$data.err.catch = true
          this.$data.err.message = res.data.message
        } else if (res.data.response === 1) {
          this.$data.txt.favorite = 'お気に入り登録済'
        }
      })
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
