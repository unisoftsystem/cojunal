export default {
  methods: {
    goTo(rute, prms) {
      this.$router.push({ path: rute, params: prms });
    },
  },
};
