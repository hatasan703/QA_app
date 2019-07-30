<template>
    <div class="howToWrap">
        <section-with-image-item
            title="回答者への報酬額を決めて<br>相談する"
            image-src="assets/talk.png"
            image-alt=""
        />

        <section-with-image-item
            title="集まった回答の中から<br>ベストアンサーを選ぶ"
            image-src="assets/answer@2x.png"
            image-alt=""
        />

        <section-with-image-item
            title="ベストアンサーに選ばれた回答者は<br>報酬が貰える"
            image-src="assets/pay.png"
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
