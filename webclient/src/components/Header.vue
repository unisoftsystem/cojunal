<template>
    <div class="Header">

      <header class="main">
        <a href="#" class="logo-container">
          <img src="../assets/logo.png">
        </a>
      </header>

    </div>
</template>

<script>
export default {
  name: 'Header',
  data() {
    return {
      name: 'hola',
    };
  },
};
</script>

<style scoped>
  .Header {
    background-color: white;
  }
  .main {
    background: #fff;
    width: 100%;
    left: 0;
    height: auto;
    -webkit-transition: 0.4s;
    -o-transition: 0.4s;
    -ms-transition: 0.4s;
    -moz-transition: 0.4s;
    transition: 0.4s;
    position: fixed;
    z-index: 10000;
    top: 0;
    -webkit-box-shadow: 0 2px 2px rgba(0,0,0,0.14), 0 1px 0 rgba(0,0,0,0.03);
    box-shadow: 0 2px 2px rgba(0,0,0,0.14), 0 1px 0 rgba(0,0,0,0.03);
    display: block;
  }
  .logo-container {
    cursor: pointer;
    display: block;
    float: left;
    height: 26px;
    margin: 22px 19px;
    -webkit-transition: 0.3s;
    -o-transition: 0.3s;
    -ms-transition: 0.3s;
    -moz-transition: 0.3s;
    transition: 0.3s;
    position: relative;
  }
  .logo-container img {
    height: 100%;
  }

</style>
