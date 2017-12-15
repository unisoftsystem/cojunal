// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import router from './router';
import VModal from '../node_modules/vue-js-modal';
import BootstrapVue from '../node_modules/bootstrap-vue/dist/bootstrap-vue';
import ElementUI from '../node_modules/element-ui';
import '../node_modules/element-ui/lib/theme-chalk/index.css';

Vue.use(VModal, { componentName: 'app-modal' });
Vue.use(BootstrapVue);
Vue.use(ElementUI);

Vue.config.productionTip = false;

/* eslint-disable no-new */
window.busHub = new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App },
});
