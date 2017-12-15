<template>
  <div class="container">
    <AppHeader />

    <div class="b-main-container">
      <div class="b-sidebar-container">
        <Sidebar :menu="menu" />
      </div>

      <div class="b-data-container">
        <div class="page">
          <slot></slot>
        </div>
      </div>
    </div>
    <footer>
        <div class="large-6 medium-6 small-12 columns">
          <p>© 2016 <span>COJUNAL</span> Todos los derechos reservados.</p>
        </div>
        <div class="large-6 medium-6 small-12 columns">
        <div class="footer-autor">
          <a href="http://www.imaginamos.com" target="_blank">Diseño web: <span id="ahorranito2"></span> Imagin<span>a</span>mos.com</a>
        </div>
        </div>
        <div class="clear"></div>
      </footer>
  </div>
</template>

<script>
  import AppHeader from '@/components/Header';
  import Sidebar from '@/components/Sidebar';

  export default {
    name: 'Coordinador',
    components: {
      AppHeader,
      Sidebar,
    },
    props: {
      menu: {
        required: true,
        type: String,
      },
    },
    data() {
      return {
        msg: 'Welcome to Your Vue.js App',
      };
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  footer {
    background: #fff;
    height: auto;
    width: 100%;
    z-index: 9;
    position: fixed;
    padding-left: 20%;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 41px;
  }
  footer p {
    font-family:'Avenir LT Std 45 Book';
    font-size: 13px;
    margin: 13px 20px 10px;
    color: #5d5d5d;
    display: block;
  }
  footer p span {
    font-weight:bold;
  }

  .footer-autor {
    display: inline-block;
    vertical-align: top;
    height: auto;
    line-height: 20px;
    margin: 12px 20px 0 0;
    float: right;
  }
  .footer-autor a {
    font-family:'Avenir LT Std 45 Book';
    font-weight:bold;
    font-size: 13px;
    color: #5d5d5d;
    text-decoration: none;
  }
  .container {
    background-color: #f6f6f6;
    height: 100vh;
  }
  .b-main-container {
    display: flex;
    flex-direction: row;
  }
  .b-sidebar-container {
    max-width: 240px;
    max-width: 17%;
    overflow: hidden;
    width: 100%;
    float: left;
  }
  .b-data-container {
    background-color: #f6f6f6;
    max-width: 83%;
    height: 100%;
    float: left;
    /*background: red;*/
    /*max-width: 80vw;*/
    float: right;
    position: inherit;
    margin: auto;
  }
  .page {
    padding: 0px 20px;
    margin-top: 85px;
  }
</style>
