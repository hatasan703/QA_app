import Vue from 'vue/dist/vue.esm';
import TurbolinksAdapter from 'vue-turbolinks';
import DropDown from 'components/DropDown.vue';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
    if (document.querySelector('#dropdown')) {
        Vue.config.devtools = true;
        new Vue({
            el: "#dropdown",
            name: 'drop-down',
            components: {
                DropDown,
            },
        });
    }
});
