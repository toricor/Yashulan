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
    <router-link to="/">一覧へ</router-link>
  </div>
</template>

<script>
const axios = require('axios')
export default {
  name: 'restaurant',
  data () {
    return {
      restaurant: axios
          .get('/api/' + this.$route.params.restaurant_id)
          .then(res => {
            this.$data.restaurant = res.data
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
