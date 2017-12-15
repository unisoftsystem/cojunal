<template>
  <div class="coordinador">
  
    <Container :menu="'coordinador'">
  
      <PageTitle />

      <AsignarTareaComponent />
    
    </Container>
  
  </div>
</template>

<script>
import Container from '../../components/Container';
import PageTitle from '../../components/PageTitle';
import AsignarTareaComponent from '../../components/AsignarTarea';


export default {
  name: 'AsignarTarea',
  components: {
    Container,
    PageTitle,
    AsignarTareaComponent,
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
