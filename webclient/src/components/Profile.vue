<template>
  <div class="profile">

    <div class="main-profile">

      <div class="profile-avatar">
        <img src="../assets/default-user.png" alt="user">
      </div>

      <div class="profile-descripcion">
        <h1 class="profile-name">Nombre Usuario</h1>
        <p class="profile-email">email@plataforma.com</p>
      </div>

    </div>

  </div>
</template>

<script>
  export default {
    name: 'Profile',
    data() {
      return {
        name: 'hola',
      };
    },
  };
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css?family=Montserrat');
  .profile {
    padding: 16px;
  }
  .main-profile {
    display: block;
    padding: 22px 0;
  }
  .profile-avatar {
    width: 60px;
    height: 60px;
    margin: 0 10px 0 0;
    overflow: hidden;
    position: relative;
    float: left;
    -webkit-border-radius: 50%;
    border-radius: 50%;
    background-color: #fff;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
  }
  .profile-descripcion {
    margin-left: 5px;
    display: block;
    padding: 0 20px;
  }
  .profile-name {
  font-family: 'Montserrat', sans-serif;
  letter-spacing: 0px;
  font-size: 17px;
  color: #fff;
  text-transform: none;
  margin: 0;
  padding: 10px 0 0;
  text-decoration: none;
  width: 100%;
  margin-left: 30px;
    margin-bottom: 3px;
    margin-top: 4px;
  }
  .profile-email {
  font-size: 12px;
  color: #9b9b9b;
  position: absolute;
  margin-top: 0px;
      margin-left: 44px;
  }
  img {
    /*width: 100%;*/
  }
</style>
