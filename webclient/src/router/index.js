import Vue from 'vue';
import Router from 'vue-router';

// Pages
import Coordinador from '@/views/coordindador/Coordindador';
import Campanas from '@/views/coordindador/Campanas';
import Asesores from '@/views/coordindador/Asesores';
import Tareas from '@/views/coordindador/Tareas';
import AsignarTarea from '@/views/coordindador/AsignarTarea';

Vue.use(Router);

export default new Router({
  routes: [
    /**
     * Coordinador
     */
    {
      path: '/coordinador',
      component: Coordinador,
      meta: {
        title: 'Campañas asignadas',
      },
    },
    {
      path: '/coordinador/asesores',
      component: Asesores,
      meta: {
        title: 'Asesores',
      },
    },
    {
      path: '/coordinador/asignar-tarea/:idWallet/:idAdviser',
      component: AsignarTarea,
      meta: {
        title: 'Asignar tarea',
      },
    },
    {
      path: '/coordinador/tareas',
      component: Tareas,
      meta: {
        title: 'Tareas',
      },
    },
    {
      path: '/coordinador/campanas',
      component: Campanas,
      meta: {
        title: 'Campañas asignadas',
      },
    },
  ],
});
