<template>
    <div
        v-if="isLogin"
        class="discussionBtn"
        :class="{ 'mobile-bottom': !isPc }"
    >
        <a
            class="questionBtn"
            data-method="get"
            :href="questionLink"
        >
            相談する
        </a>
        <a
            class="answerBtn"
            data-method="get"
            :href="answerLink"
        >
            回答する
        </a>
    </div>
    <div
        v-else
        :class="{ 'mobile-bottom': !isPc }"
    >
        <a
            class="howToUseBtn"
            data-method="get"
            :href="lpLink"
        >
            使ってみる
        </a>
    </div>
</template>

<script>
export default {
    props: {
        questionLink: {
            type: String,
            required: true,
        },
        answerLink: {
            type: String,
            required: true,
        },
        isPc: {
            type: Boolean,
            default: false,
        },
        isLogin: {
            type: Boolean,
            default: false,
        },
    },
};
</script>

<style module lang="scss">
/* PC と MOBILE で構造が違うので一旦これでいく */

.mobile-bottom {
    background-color: white;
    margin-top: -20px;
    padding: 30px 40px;
    border-radius: 12px;
}
</style>
