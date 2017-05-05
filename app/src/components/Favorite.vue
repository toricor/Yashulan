<template>
  <div class="header">
  <div class="root">
    <h1>レストラン一覧</h1>
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
  </div>
  </div>
</template>

<script>
const axios = require('axios')
export default {
  name: 'root',
  data () {
    return {
      restaurants: axios
          .get('/api')
          .then(res => {
            this.$data.restaurants = res.data
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
