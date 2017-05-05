<template>
  <div id="header">
    <router-link :to="{ name: 'Root' }">一覧へ</router-link>
    <router-link :to="{ name: 'Login' }">ログイン</router-link>
    <router-link :to="{ name: 'Signin'}">ユーザー登録</router-link>
  </div>
</template>
