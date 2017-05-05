<template>

  <div class="login">
    <div v-if="flag">ID : {{ username }}</div>
    <div v-else> ID : not login</div>
  <h1>Login Page</h1>
  <h3>Login</h3>
      <form id=form v-on:submit.prevent="adduser">
        <b>Username</b>
        <input type="text" v-model="name" size="30">
        <input type="submit" value="Login">
      </form> 
      <p>
        <router-link to="/">一覧へ</router-link>
      </p>
  </div>
 
</template>

<script>
const axios = require('axios')
export default {
  name: 'login',
  data () {
    return {
      flag: window.sessionStorage.getItem('flag'),
      username: window.sessionStorage.getItem('name')
    }
  },
  methods: {
    adduser () {
      return { login: axios
        .post('/post/login/' + this.name)
        .then(res => {
          window.sessionStorage.setItem('name', res.data.name)
          window.sessionStorage.setItem('flag', res.data.flag)
          alert(res.data.message)
          this.$router.push('/')
        })
      }
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
