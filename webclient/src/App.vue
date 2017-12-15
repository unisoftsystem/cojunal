<template>
  <div id="app">
    <!-- <img src="./assets/logo.png"> -->
    <router-view/>
  </div>
</template>

<script>
import '../node_modules/normalize.css/normalize.css';
import './app.style.css';

export default {
  name: 'app',
};
</script>

<style>
@import url(https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css);
#app {
	/*font-family: 'Montserrat', sans-serif;*/
}
</style>
