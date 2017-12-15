<template>
  <div class="coordinador">
  
    <Campanas />
  
  </div>
</template>

<script>
import Campanas from './Campanas';
import Container from '../../components/Container';
import PageTitle from '../../components/PageTitle';


export default {
  name: 'Coordinador',
  components: {
    Campanas,
    Container,
    PageTitle,
  },
  data() {
    return {
    };
  },
  methods: {

  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
