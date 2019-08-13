import Vue from 'vue/dist/vue.esm';
import TurbolinksAdapter from 'vue-turbolinks';
import DropDown from 'components/DropDown.vue';
import SectionWithImageList from 'components/top/SectionWithImageList.vue';
import DiscussionButtonList from 'components/top/DiscussionButtonList.vue';
import NoticeHeader from "components/NoticeHeader.vue";

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
    if (document.querySelector('#js-dropdown')) {
        new Vue({
            el: "#js-dropdown",
            name: 'drop-down',
            components: {
                DropDown,
            },
        });
    }

    if (document.querySelector('.js-section-with-image-list')) {
        new Vue({
            el: ".js-section-with-image-list",
            name: 'section-with-image-list',
            components: {
                SectionWithImageList,
            },
        });
    }

    if (document.querySelector('.js-discussion-button-list')) {
        new Vue({
            el: ".js-discussion-button-list",
            name: 'discussion-button-list',
            components: {
                DiscussionButtonList,
            },
        });
    }

    if (document.querySelector('#js-notice-header')) {
        new Vue({
            el: "#js-notice-header",
            name: 'notice-header',
            components: {
                NoticeHeader,
            },
        });
    }
});
