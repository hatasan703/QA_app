<template>
    <div class="howToWrap">
        <section-with-image-item
            title="回答者への報酬額を決めて、相談する"
            image-src="assets/howTo_item01.png"
            image-alt=""
        />

        <section-with-image-item
            title="集まった回答の中から<br>ベストアンサーを選ぶ"
            image-src="assets/howTo_item02.png"
            image-alt=""
        />

        <section-with-image-item
            title="ベストアンサーに選ばれた回答者は<br>報酬が貰える"
            image-src="assets/howTo_item03.png"
            image-alt=""
        />
    </div>
</template>

<script>
import SectionWithImageItem from './SectionWithImageItem.vue';
import DiscussionButtonList from 'components/top/DiscussionButtonList.vue';

export default {
    components: {
        SectionWithImageItem,
        DiscussionButtonList,
    },
};

</script>
