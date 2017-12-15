<template>
  <div class="Sidebar">

    <div class="main-sidebar">

      <Profile />

      <ul class="sidebar-items">
        <li class="sidebar-item top"></li>
        <li class="sidebar-item" v-for="m in getMenu()" @click="goTo(m.link)">
          <a><i :class="m.class"></i>{{ m.name }}</a>
        </li>
        <li class="sidebar-item"><a href="#"><i class="fa fa-lock"></i> Cerrar Sessión</a></li>
      </ul>

    </div>

  </div>
</template>

<script>
  import Profile from '@/components/Profile';
  import RouteMixin from '@/mixins/RouteMixin';

  export default {
    name: 'Sidebar',
    mixins: [RouteMixin],
    components: {
      Profile,
    },
    props: {
      menu: {
        required: true,
        type: String,
      },
    },
    data() {
      return {
        menus: {
          coordinador: {
            campanas: {
              name: 'campañas',
              class: 'fa fa-home',
              link: '/coordinador/campanas',
            },
            carteras: {
              name: 'cartera',
              class: 'fa fa-users',
              link: '',
            },
            asesores: {
              name: 'asesores',
              class: 'fa fa-calendar-o',
              link: '/coordinador/asesores',
            },
            asignarTareas: {
              name: 'Tareas',
              class: 'fa fa-calendar-o',
              link: '/coordinador/tareas',
            },
          },
        },
      };
    },
    methods: {
      getMenu() {
        return this.menus[this.menu];
      },
    },
  };
</script>

<style scoped>

  .Sidebar {
    background-color: #193153;
    padding-bottom: 130px;
    width: 240px;
    position: fixed;
    left: 0;
    top: 70px;
    margin: 0;
    height: 100%;
    z-index: 999;
    overflow-y: auto;
  }
  .sidebar-items {
    list-style: none;
    padding: 0;

  }
  .sidebar-item {
    border-bottom: 1px solid rgba(155, 155, 155, 0.45);
    color: #9b9b9b;
    padding: 0 20px;
    line-height: 64px;
    cursor: pointer;
    transition: all 0.2s;
    text-transform: uppercase;
  }
  .sidebar-item a {
    font-family: 'Avenir LT Std 45 Book' !important;
    font-style: normal;
    font-weight: normal;
  }

  .sidebar-item:hover {
    border-left: 4px solid #f5a623;
    background: #e5e5e5;
    color: #6c6c6c;
  }
  .sidebar-item:hover a {
    color: #6c6c6c;
  }
  .sidebar-item a {
  color: #9b9b9b;
  text-transform: uppercase;
  font-family: 'avenir';
  font-size: .9rem;
  position: relative;
  text-decoration: none;

  }
  .sidebar-item a i{
    font-size: 1.4rem;
    vertical-align: middle;
    display: inline-block;
    margin: 0 16px 0 13px;
  }
</style>
