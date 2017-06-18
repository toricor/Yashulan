<template>
  <div class="station">
    <tr><th>最寄駅</th><td>{{ station.name }}</td></tr>
  </div>
</template>

<script>
const axios = require('axios')
export default {
  name: 'station',
  data () {
    return {
      restaurant: axios
        .get('/api/station/' + this.$route.params.station)
        .then(res => {
          this.$data.station = res.data
        }
      )
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
